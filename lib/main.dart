import 'package:define_it_v2/screens/bookmark_screen.dart';
import 'package:define_it_v2/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// Database Inspector
import 'package:flutter/foundation.dart';
import 'package:sqlite_inspector/sqlite_inspector.dart';

// Database
import 'package:define_it_v2/database/app_database.dart';
import 'package:define_it_v2/services/word_repository.dart';

// Providers
import 'package:define_it_v2/providers/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await SqliteInspector.start();
  }

  final database = await $FloorAppDatabase
    .databaseBuilder('app_database.db')
    .build();

  WordRepository.initialize(
    favoriteWordDao: database.favoriteWordDao,
    searchedWordDao: database.searchedWordDao,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Define It',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeProvider.flutterThemeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/favorites': (context) => const BookmarkPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

