import 'package:floor/floor.dart';
import 'package:define_it_v2/database/entities/favorite_word.dart';

@dao
abstract class FavoriteWordDao {
  /// Retrieves a list of all favorited words with their details from the database.
  @Query('SELECT * FROM FavoriteWord')
  Future<List<FavoriteWord>> findAllFavoriteWords();

  /// Inserts a [FavoriteWord] into the database. If a word with the same primary key already exists, it will be replaced.
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoriteWord(FavoriteWord word);

  /// Deletes a word from the favorites list in the database based on the provided word string.
  @Query('DELETE FROM FavoriteWord WHERE word = :word')
  Future<void> deleteFavoriteWord(String word);

  /// Checks if a word is in the favorites list.
  @Query('SELECT EXISTS(SELECT 1 FROM FavoriteWord WHERE word = :word)')
  Future<bool?> isFavorite(String word);
}