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
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Start the SQLite Inspector in debug mode
  if (kDebugMode) {
    await SqliteInspector.start();
  }

  // Initialize the database  
  final database = await $FloorAppDatabase
    .databaseBuilder('app_database.db')
    .build();

  // Initialize the WordRepository with the DAOs from the database
  WordRepository.initialize(
    favoriteWordDao: database.favoriteWordDao,
    searchedWordDao: database.searchedWordDao,
  );

  // Run the app with providers for database and theme management
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

  /// Builds the route based on the route name and arguments
  Route<dynamic> _buildRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':  // home route
        final initialWord = settings.arguments is String
            ? settings.arguments as String
            : null;
        return MaterialPageRoute(
          builder: (_) => HomePage(initialWord: initialWord),
          settings: settings,
        );
      case '/favorites':  // favorites route
        return MaterialPageRoute(
          builder: (_) => const BookmarkPage(),
          settings: settings,
        );
      case '/settings':  // settings route
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      default: // fallback route (home)
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Define It',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeProvider.flutterThemeMode, // Use the theme mode from the provider
      initialRoute: '/',
      onGenerateRoute: _buildRoute,
    );
  }
}

