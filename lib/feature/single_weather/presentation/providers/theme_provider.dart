import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isToggled = false;
  ThemeData _currentTheme = Themes.lightmode;
  static const String themeKey = 'theme_preference';

  bool get isToggled => _isToggled;
  ThemeData get currentTheme => _currentTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  // Load saved theme preference
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(themeKey) ?? false;

    _isToggled = isDarkMode;
    _currentTheme = isDarkMode ? Themes.darkmode : Themes.lightmode;
    notifyListeners();
  }

  // Save theme preference
  Future<void> _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode);
  }

  void toggleTheme() {
    if (_currentTheme == Themes.lightmode) {
      _currentTheme = Themes.darkmode;
      _isToggled = true;
    } else {
      _currentTheme = Themes.lightmode;
      _isToggled = false;
    }

    _saveThemePreference(_isToggled);
    notifyListeners();
  }
}
