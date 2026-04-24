import 'package:floor/floor.dart';

@Entity(tableName: 'FavoriteWord')
class FavoriteWord {
  @PrimaryKey()
  final String word;
  final String definition;
  final String phonetic;

  /// Constructs a FavoriteWord instance with the given word, definition, and phonetic representation.
  FavoriteWord({ required this.word, required this.definition, required this.phonetic });
}