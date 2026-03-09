import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // ===================== Light Theme =====================
  static final ThemeData lightMode = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    primaryColor: AppColors.lightMain,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.lightMain,
      onPrimaryContainer: AppColors.lightMain,
      outline: AppColors.lightStroke,
      onSurface: AppColors.lightMainText,
      error: AppColors.lightRed,
    ),

    // text
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.lightMainText,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightMainText,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightMainText),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.lightSecText,
        height: 1.5,
      ),
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.lightMain),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBackground,
      selectedItemColor: AppColors.lightMain,
      unselectedItemColor: AppColors.lightDisable,
      type: BottomNavigationBarType.fixed,
    ),
    //(Text Form Fields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInputs,
      hintStyle: const TextStyle(color: AppColors.lightSecText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.lightStroke),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.lightStroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.lightMain),
      ),
    ),
  );

  // ===================== Dark Theme =====================
  static final ThemeData darkMode = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    primaryColor: AppColors.darkMain,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      outline: AppColors.darkStroke,
      primary: AppColors.darkMain,
      onPrimaryContainer: Colors.white,
      onSurface: AppColors.darkMainText,
      error: AppColors.darkRed,
    ),

    //text
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.darkMainText,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkMainText,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkMainText),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.darkSecText),
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.darkMain),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.darkMain,
      unselectedItemColor: AppColors.darkDisable,
      type: BottomNavigationBarType.fixed,
    ),
    //(Text Form Fields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputs,
      hintStyle: const TextStyle(color: AppColors.darkSecText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.darkStroke),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.darkStroke),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.darkMain),
      ),
    ),
  );
}
