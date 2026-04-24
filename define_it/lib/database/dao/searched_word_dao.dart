import 'package:floor/floor.dart';
import 'package:define_it_v2/database/entities/searched_word.dart';

@dao
abstract class SearchedWordDao {
  /// Retrieves a list of all searched words from the database.
  @Query('SELECT * FROM SearchedWord')
  Future<List<SearchedWord>> findAllSearchedWords();

  /// Retrieves a list of the most recently searched words from the database, limited by the specified number. The words are ordered by their insertion time, with the most recent first.
  @Query('SELECT * FROM SearchedWord ORDER BY rowid DESC LIMIT :limit')
  Future<List<SearchedWord>> findRecentSearchedWords(int limit);

  /// Retrieves the most recently searched word from the database. Returns null if there are no searched words.
  @Query('SELECT word FROM SearchedWord ORDER BY rowid DESC LIMIT 1')
  Future<String?> findLastSearchedWord();

  /// Inserts a [SearchedWord] into the database. If a word with the same primary key already exists, it will be replaced.
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSearchedWord(SearchedWord word);

  /// Deletes a word from the search history in the database based on the provided word string.
  @Query('DELETE FROM SearchedWord WHERE word = :word')
  Future<void> deleteSearchedWord(String word);
}