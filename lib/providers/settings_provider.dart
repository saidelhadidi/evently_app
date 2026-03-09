import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {

  bool isEnglish = true;
  ThemeMode currentTheme= ThemeMode.light;

  void changeLanguage(bool isSelected) {
    if (isEnglish == isSelected) return;
    isEnglish = isSelected;
    notifyListeners();
  }
  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }
}