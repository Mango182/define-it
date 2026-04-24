import 'package:floor/floor.dart';

@Entity(tableName: 'FavoriteWord')
class FavoriteWord {
  @PrimaryKey()
  final String word;
  final String definition;
  final String phonetic;

  FavoriteWord({ required this.word, required this.definition, required this.phonetic });
}