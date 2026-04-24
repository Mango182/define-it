// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteWordDao? _favoriteWordDaoInstance;

  SearchedWordDao? _searchedWordDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavoriteWord` (`word` TEXT NOT NULL, `definition` TEXT NOT NULL, `phonetic` TEXT NOT NULL, PRIMARY KEY (`word`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SearchedWord` (`word` TEXT NOT NULL, PRIMARY KEY (`word`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteWordDao get favoriteWordDao {
    return _favoriteWordDaoInstance ??=
        _$FavoriteWordDao(database, changeListener);
  }

  @override
  SearchedWordDao get searchedWordDao {
    return _searchedWordDaoInstance ??=
        _$SearchedWordDao(database, changeListener);
  }
}

class _$FavoriteWordDao extends FavoriteWordDao {
  _$FavoriteWordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteWordInsertionAdapter = InsertionAdapter(
            database,
            'FavoriteWord',
            (FavoriteWord item) => <String, Object?>{
                  'word': item.word,
                  'definition': item.definition,
                  'phonetic': item.phonetic
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteWord> _favoriteWordInsertionAdapter;

  @override
  Future<List<FavoriteWord>> findAllFavoriteWords() async {
    return _queryAdapter.queryList('SELECT * FROM FavoriteWord',
        mapper: (Map<String, Object?> row) => FavoriteWord(
            word: row['word'] as String,
            definition: row['definition'] as String,
            phonetic: row['phonetic'] as String));
  }

  @override
  Future<void> deleteFavoriteWord(String word) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM FavoriteWord WHERE word = ?1',
        arguments: [word]);
  }

  @override
  Future<void> insertFavoriteWord(FavoriteWord word) async {
    await _favoriteWordInsertionAdapter.insert(
        word, OnConflictStrategy.replace);
  }
}

class _$SearchedWordDao extends SearchedWordDao {
  _$SearchedWordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _searchedWordInsertionAdapter = InsertionAdapter(
            database,
            'SearchedWord',
            (SearchedWord item) => <String, Object?>{'word': item.word});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchedWord> _searchedWordInsertionAdapter;

  @override
  Future<List<SearchedWord>> findAllSearchedWords() async {
    return _queryAdapter.queryList('SELECT * FROM SearchedWord',
        mapper: (Map<String, Object?> row) =>
            SearchedWord(word: row['word'] as String));
  }

  @override
  Future<List<SearchedWord>> findRecentSearchedWords(int limit) async {
    return _queryAdapter.queryList(
        'SELECT * FROM SearchedWord ORDER BY rowid DESC LIMIT ?1',
        mapper: (Map<String, Object?> row) =>
            SearchedWord(word: row['word'] as String),
        arguments: [limit]);
  }

  @override
  Future<String?> findLastSearchedWord() async {
    return _queryAdapter.query(
        'SELECT word FROM SearchedWord ORDER BY rowid DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<void> deleteSearchedWord(String word) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SearchedWord WHERE word = ?1',
        arguments: [word]);
  }

  @override
  Future<void> insertSearchedWord(SearchedWord word) async {
    await _searchedWordInsertionAdapter.insert(
        word, OnConflictStrategy.replace);
  }
}
