import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum to represent the theme mode options
enum ThemeModeOption { system, light, dark }
class ThemeProvider extends ChangeNotifier {
  // State variables
  ThemeModeOption _themeMode = ThemeModeOption.system;
  ThemeModeOption get themeMode => _themeMode;

  ThemeProvider() {
    _loadPreferences();
  }

  /// Loads the saved theme preference from SharedPreferences
  Future<void> _loadPreferences() async {
    // Default to system theme if no preference is found
    final pref = await SharedPreferences.getInstance();
    final themeIndex = pref.getInt('themeMode') ?? 0;
    _themeMode = ThemeModeOption.values[themeIndex];
    notifyListeners();
  }

  Future<void> setTheme(ThemeModeOption mode) async {
    // Update the theme mode and save the preference
    _themeMode = mode;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('themeMode', mode.index);
  }

  /// Converts the internal ThemeModeOption to Flutter's ThemeMode
  ThemeMode get flutterThemeMode => switch (_themeMode) {
    ThemeModeOption.light => ThemeMode.light,
    ThemeModeOption.dark => ThemeMode.dark,
    ThemeModeOption.system => ThemeMode.system
  };
}