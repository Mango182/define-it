import 'package:define_it_v2/database/dao/searched_word_dao.dart';
import 'package:define_it_v2/database/dao/favorite_word_dao.dart';
import 'package:define_it_v2/database/entities/favorite_word.dart';
import 'package:define_it_v2/database/entities/searched_word.dart';
import 'package:define_it_v2/models/word_result.dart';

class WordRepository {
  static WordRepository? _instance;

  static WordRepository get instance {
    final instance = _instance;
    if (instance == null) {
      throw StateError('WordRepository not initialized. Call WordRepository.initialize(...) first.');
    }
    return instance;
  }

  static WordRepository initialize({
    required FavoriteWordDao favoriteWordDao,
    required SearchedWordDao searchedWordDao,
  }) => _instance ??= WordRepository._internal(favoriteWordDao, searchedWordDao);

  final FavoriteWordDao favoriteWordDao;
  final SearchedWordDao searchedWordDao;
  WordRepository._internal(this.favoriteWordDao, this.searchedWordDao);

  Future<void> insertFavoriteWord(WordResult word) async {
    final favoriteWord = FavoriteWord(
      word: word.word,
      definition: word.definition,
      phonetic: word.phonetic,
    );
    await favoriteWordDao.insertFavoriteWord(favoriteWord);
  }

  Future<void> insertSearchedWord(WordResult word) async {
    final searchedWord = SearchedWord(
      word: word.word,
    );
    await searchedWordDao.insertSearchedWord(searchedWord);
  }

  Future<List<FavoriteWord>> getAllFavoriteWords() async {
    return favoriteWordDao.findAllFavoriteWords();
  }

  Future<List<SearchedWord>> getAllSearchedWords() async {
    return searchedWordDao.findAllSearchedWords();
  }

  Future<List<String>> getRecentSearches({int limit = 8}) async {
    final searchedWords = await searchedWordDao.findRecentSearchedWords(limit);
    return searchedWords.map((word) => word.word).toList();
  }

  Future<String?> getLastSearchedWord() async {
    return searchedWordDao.findLastSearchedWord();
  }

  Future<void> deleteFavoriteWord(String word) async {
    await favoriteWordDao.deleteFavoriteWord(word);
  }

  Future<void> deleteSearchedWord(String word) async {
    await searchedWordDao.deleteSearchedWord(word);
  }

}