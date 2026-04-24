import 'package:floor/floor.dart';
import 'package:define_it_v2/database/entities/searched_word.dart';

@dao
abstract class SearchedWordDao {
  @Query('SELECT * FROM SearchedWord')
  Future<List<SearchedWord>> findAllSearchedWords();

  @Query('SELECT * FROM SearchedWord ORDER BY rowid DESC LIMIT :limit')
  Future<List<SearchedWord>> findRecentSearchedWords(int limit);

  @Query('SELECT word FROM SearchedWord ORDER BY rowid DESC LIMIT 1')
  Future<String?> findLastSearchedWord();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSearchedWord(SearchedWord word);

  @Query('DELETE FROM SearchedWord WHERE word = :word')
  Future<void> deleteSearchedWord(String word);
}