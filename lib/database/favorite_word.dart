import 'package:floor/floor.dart';

@entity
class FavoriteWord {
  @primaryKey
  final String word;
  final String definition;
  final String phonetic;

  FavoriteWord({ required this.word, required this.definition, required this.phonetic });
}