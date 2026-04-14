import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/remote/local/shared_prefs_helper.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool isEnglish = true;
  ThemeMode currentTheme = ThemeMode.light;

  SettingsProvider() {
    _loadSettingsFromPrefs();
  }

  Future<void> _loadSettingsFromPrefs() async {
    // Load Theme
    bool isDark = await SharedPrefsHelper.getCurrentTheme();
    currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  void initLanguage(BuildContext context) {
    isEnglish = context.locale.languageCode == 'en';
  }

  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    SharedPrefsHelper.saveCurrentTheme(currentTheme == ThemeMode.dark);
    notifyListeners();
  }

  void changeLanguage(bool isSelected, BuildContext context) {
    if (isEnglish == isSelected) return;
    isEnglish = isSelected;
    
    String langCode = isEnglish ? "en" : "ar";
    context.setLocale(Locale(langCode));
    notifyListeners();
  }
}
