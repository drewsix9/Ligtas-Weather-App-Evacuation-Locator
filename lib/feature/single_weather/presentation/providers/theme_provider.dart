import 'package:flutter/material.dart';

import '../../../../core/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isToggled = false;
  ThemeData _currentTheme = Themes.lightmode;

  bool get isToggled => _isToggled;
  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == Themes.lightmode) {
      _currentTheme = Themes.darkmode;
    } else {
      _currentTheme = Themes.lightmode;
    }
    _isToggled = !_isToggled;
    notifyListeners();
  }
}
