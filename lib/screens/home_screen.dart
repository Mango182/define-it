import 'package:define_it_v2/database/app_database.dart';
import 'package:define_it_v2/database/word_dao.dart';
import 'package:define_it_v2/widgets/app_drawer.dart';
import 'package:define_it_v2/widgets/word_details.dart';
import 'package:flutter/material.dart';
import 'package:define_it_v2/widgets/search_bar.dart';
import 'package:define_it_v2/models/word_result.dart';
import 'package:define_it_v2/services/dictionary_api.dart';
import 'package:define_it_v2/database/favorite_word.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WordResult _wordResult = WordResult(word: '', definition: '', phonetic: '');
  late WordDao _wordDao;
  bool _isLoading = false;
  bool _isFavorite = false;

  Future<void>_initDatabase() async {
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();

    setState(() { _wordDao = database.wordDao; });
  }

  @override
  void initState() {
    super.initState();
    _loadWord("example");
    _initDatabase();
  }

  Future<void> _loadWord(String word) async {
    setState(() => _isLoading = true);
    try {
      // Wait for the API call to complete
      final json = await DictionaryAPI().fetchDefinition(word);
      
      // Check if widget is still mounted
      if (!mounted) return;

      setState(() {
        // Map JSON to your WordResult model
        _wordResult = WordResult.fromJson(json);
        _isLoading = false;
      });
    } catch (e) {
      // Failed to load word
      setState(() => _isLoading = false);
      debugPrint("Error loading word: $e");
    }
  }

  // Favorite Word
  void _favoriteWord() async {
    if (_isLoading) return;
    final favoriteWord = FavoriteWord(
      word: _wordResult.word,
      definition: _wordResult.definition,
      phonetic: _wordResult.phonetic
    );
    final word = _wordResult.word;

    await _wordDao.insertFavoriteWord(favoriteWord);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"$word" added to favorites!')),
    );
    setState(() => _isFavorite = true);
  }
  
  void _removeFavorite() async {
    if (_isLoading) return;
    final favoriteWord = FavoriteWord(
      word: _wordResult.word,
      definition: _wordResult.definition,
      phonetic: _wordResult.phonetic
    );
    final word = _wordResult.word;

    await _wordDao.deleteFavoriteWord(favoriteWord);

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
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WordSearchbar(onSearch: _loadWord),
            ),

            WordDetails(
              word: _wordResult.word,
              definition: _wordResult.definition,
              phonetic: _wordResult.phonetic
            ),
          ]
        ),
      ),

      // Favorite Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _isFavorite ? _removeFavorite() : _favoriteWord(),
        tooltip: 'Favorite',
        child: Icon(_isFavorite? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}