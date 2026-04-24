import 'package:floor/floor.dart';

@Entity(tableName: 'SearchedWord')
class SearchedWord {
  @PrimaryKey()
  final String word;

  /// Constructs a SearchedWord instance with the given word.
  SearchedWord({ required this.word });
}