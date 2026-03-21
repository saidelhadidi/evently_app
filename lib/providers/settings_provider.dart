import 'package:evently_app/core/constants/shared_prefs_helper.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {

  bool isEnglish = true;
  ThemeMode currentTheme= ThemeMode.light;
  SettingsProvider() {
    _loadThemeFromPrefs();
  }
  Future<void> _loadThemeFromPrefs() async {
    bool isDark = await SharedPrefsHelper.getCurrentTheme();
    currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    SharedPrefsHelper.saveCurrentTheme(currentTheme==ThemeMode.dark);
    notifyListeners();
  }
  void changeLanguage(bool isSelected) {
    if (isEnglish == isSelected) return;
    isEnglish = isSelected;
    notifyListeners();
  }
}