import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'favorite_word.dart';
import 'word_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [FavoriteWord])
abstract class AppDatabase extends FloorDatabase {
  WordDao get wordDao;
}