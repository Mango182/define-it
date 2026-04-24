import 'package:flutter/material.dart';

import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:define_it_v2/widgets/word_details.dart';
import 'package:define_it_v2/widgets/search_bar.dart';
import 'package:define_it_v2/models/word_result.dart';
import 'package:define_it_v2/services/dictionary_api.dart';
import 'package:define_it_v2/services/word_repository.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialWord});

  final String? initialWord;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WordRepository _wordRepo = WordRepository.instance;
  WordResult _wordResult = WordResult(word: '', definition: '', phonetic: '', audioUrl: '');
  List<String> _recentSearches = const [];
  bool _isLoading = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    await _refreshRecentSearches();
    final lastSearchedWord = await _wordRepo.getLastSearchedWord();
    await _loadWord(widget.initialWord ?? lastSearchedWord ?? 'example', saveToHistory: false);
  }

  Future<void> _refreshFavoriteStatus() async {
    final currentWord = _wordResult.word;
    if (currentWord.isEmpty) return;

    final favorite = await _wordRepo.isFavorite(currentWord);
    if (!mounted) return;
    setState(() => _isFavorite = favorite ?? false);
  }

  Future<void> _refreshRecentSearches() async {
    final recentSearches = await _wordRepo.getRecentSearches();
    if (!mounted) return;
    setState(() => _recentSearches = recentSearches);
  }

  Future<void> _loadWord(String word, {bool saveToHistory = true}) async {
    final normalizedWord = word.trim();
    if (normalizedWord.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      // Wait for the API call to complete
      final json = await DictionaryAPI().fetchDefinition(normalizedWord);
      final loadedWord = WordResult.fromJson(json);

      if (saveToHistory) {
        await _wordRepo.insertSearchedWord(loadedWord);
      }
      
      // Check if widget is still mounted
      if (!mounted) return;

      setState(() {
        // Map JSON to your WordResult model
        _wordResult = loadedWord;
        _isLoading = false;
      });

      if (saveToHistory) {
        await _refreshRecentSearches();
      }

      await _refreshFavoriteStatus();
    } catch (e) {
      // Failed to load word
      setState(() => _isLoading = false);
      debugPrint("Error loading word: $e");
    }
  }

  // Favorite Word
  void _favoriteWord() async {
    if (_isLoading) return;
    final word = _wordResult.word;

    await _wordRepo.insertFavoriteWord(_wordResult);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"$word" added to favorites!')),
    );
    setState(() => _isFavorite = true);
  }
  
  void _removeFavorite() async {
    if (_isLoading) return;
    // Delete from database
    final word = _wordResult.word;
    await _wordRepo.deleteFavoriteWord(word);

    // Show snackbar and update state
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$word" removed from favorites')),
    );
    setState(() => _isFavorite = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Define It'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WordSearchbar(
                onSearch: _loadWord,
                suggestions: _recentSearches,
              ),
            ),

            WordDetails(
              word: _wordResult.word,
              definition: _wordResult.definition,
              phonetic: _wordResult.phonetic,
              audioUrl: _wordResult.audioUrl,
            ),
          ]
        ),
      ),

      // Favorite Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _isFavorite ? _removeFavorite() : _favoriteWord(),
        tooltip: 'Favorite',
        child: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}