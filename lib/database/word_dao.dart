import 'package:floor/floor.dart';
import 'favorite_word.dart';

@dao
abstract class WordDao {
  @Query('SELECT * FROM FavoriteWord')
  Future<List<FavoriteWord>> findAllFavoriteWords();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoriteWord(FavoriteWord word);

  @delete
  Future<void> deleteFavoriteWord(FavoriteWord word);
}