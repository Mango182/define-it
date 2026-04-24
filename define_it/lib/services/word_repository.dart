import 'package:define_it/database/dao/searched_word_dao.dart';
import 'package:define_it/database/dao/favorite_word_dao.dart';
import 'package:define_it/database/entities/favorite_word.dart';
import 'package:define_it/database/entities/searched_word.dart';
import 'package:define_it/models/word_result.dart';

class WordRepository {
  /// Singleton instance of WordRepository
  static WordRepository? _instance;
  static WordRepository get instance {
    final instance = _instance;
    if (instance == null) {
      throw StateError('WordRepository not initialized. Call WordRepository.initialize(...) first.');
    }
    return instance;
  }

  /// Initializes the WordRepository singleton with the required DAOs
  static WordRepository initialize({
    required FavoriteWordDao favoriteWordDao,
    required SearchedWordDao searchedWordDao,
  }) => _instance ??= WordRepository._internal(favoriteWordDao, searchedWordDao);

  final FavoriteWordDao favoriteWordDao;
  final SearchedWordDao searchedWordDao;
  WordRepository._internal(this.favoriteWordDao, this.searchedWordDao);

  /// Retrieves a list of all favorited words
  Future<List<String>> get favoritedWords async {
    final words = await favoriteWordDao.findAllFavoriteWords();
    return words.map((w) => w.word).toList();
  }

  /// inserts a word into the favorites list
  Future<void> insertFavoriteWord(WordResult word) async {
    final favoriteWord = FavoriteWord(
      word: word.word,
      definition: word.definition,
      phonetic: word.phonetic,
    );
    await favoriteWordDao.insertFavoriteWord(favoriteWord);
  }

  /// inserts a word into the search history
  Future<void> insertSearchedWord(WordResult word) async {
    final searchedWord = SearchedWord(
      word: word.word,
    );
    await searchedWordDao.insertSearchedWord(searchedWord);
  }

  /// Retrieves a list of all favorited words with their details
  Future<List<FavoriteWord>> getAllFavoriteWords() async {
    return favoriteWordDao.findAllFavoriteWords();
  }

  /// Retrieves a list of all searched words with their details
  Future<List<SearchedWord>> getAllSearchedWords() async {
    return searchedWordDao.findAllSearchedWords();
  }

  /// Retrieves a list of recent searched words, limited by the specified number
  Future<List<String>> getRecentSearches({int limit = 8}) async {
    final searchedWords = await searchedWordDao.findRecentSearchedWords(limit);
    return searchedWords.map((word) => word.word).toList();
  }

  /// Retrieves the last searched word, or null if no searches have been made
  Future<String?> getLastSearchedWord() async {
    return searchedWordDao.findLastSearchedWord();
  }

  /// Deletes a word from the favorites list
  Future<void> deleteFavoriteWord(String word) async {
    await favoriteWordDao.deleteFavoriteWord(word);
  }

  /// Deletes a word from the search history
  Future<void> deleteSearchedWord(String word) async {
    await searchedWordDao.deleteSearchedWord(word);
  }

  /// Checks if a word is in the favorites list
  Future<bool?> isFavorite(String word) async {
    return await favoriteWordDao.isFavorite(word);
  }
}