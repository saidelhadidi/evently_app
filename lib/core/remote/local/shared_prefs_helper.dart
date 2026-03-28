import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String onboardingKey = "isOnboarded";
  static const String themeKey = "isDarkTheme";
  static const String languageKey = "language";
  static const String loginKey = "isLoggedIn";
  static const String profileImagePrefix = "profile_image_";

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

  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, langCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? "en";
  }

  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginKey, isLoggedIn);
  }

  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginKey) ?? false;
  }

  static Future<void> saveProfileImagePath(String email, String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("$profileImagePrefix$email", path);
  }

  static Future<String?> getProfileImagePath(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("$profileImagePrefix$email");
  }
}
