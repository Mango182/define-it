import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:define_it_v2/database/entities/favorite_word.dart';
import 'package:define_it_v2/database/entities/searched_word.dart';
import 'package:define_it_v2/database/dao/favorite_word_dao.dart';
import 'package:define_it_v2/database/dao/searched_word_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [FavoriteWord, SearchedWord])
abstract class AppDatabase extends FloorDatabase {
  FavoriteWordDao get favoriteWordDao;
  SearchedWordDao get searchedWordDao;
  
}