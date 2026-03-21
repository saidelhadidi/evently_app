import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String onboardingKey = "isOnboarded";
  static const String themeKey = "isDarkTheme";

  static Future<void> saveOnboardingFinished() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }

  static Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  static Future<void> saveCurrentTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }

  static Future<bool> getCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }

}
