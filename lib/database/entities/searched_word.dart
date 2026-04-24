import 'package:floor/floor.dart';

@Entity(tableName: 'SearchedWord')
class SearchedWord {
  @PrimaryKey()
  final String word;

  SearchedWord({ required this.word });
}