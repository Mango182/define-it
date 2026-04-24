import 'package:floor/floor.dart';
import 'package:define_it_v2/database/entities/favorite_word.dart';

@dao
abstract class FavoriteWordDao {
  @Query('SELECT * FROM FavoriteWord')
  Future<List<FavoriteWord>> findAllFavoriteWords();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavoriteWord(FavoriteWord word);

  @Query('DELETE FROM FavoriteWord WHERE word = :word')
  Future<void> deleteFavoriteWord(String word);
}