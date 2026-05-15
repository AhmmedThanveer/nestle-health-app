import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  /// LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.primaryBlue,

    primaryColor: AppColors.primaryBlue,

    fontFamily: 'Roboto',

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,

      secondary: AppColors.lightBlue,

      surface: AppColors.primaryBlue,

      onPrimary: AppColors.white,

      onSecondary: AppColors.white,
    ),

    /// APP BAR
    appBarTheme: const AppBarTheme(
      elevation: 0,

      centerTitle: true,

      backgroundColor: Colors.transparent,

      foregroundColor: AppColors.white,
    ),

    /// TEXT THEME
    textTheme: const TextTheme(
      /// LARGE TITLE
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
        fontFamily: 'Montserrat',
      ),

      /// MEDIUM TITLE
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontFamily: 'Roboto',
      ),

      /// SMALL TITLE
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        fontFamily: 'Roboto',
      ),

      /// BODY LARGE
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        fontFamily: 'Roboto',
      ),

      /// BODY MEDIUM
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.hintColor,
        fontFamily: 'Roboto',
      ),

      /// LABEL LARGE
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        fontFamily: 'Roboto',
      ),
    ),

    /// ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,

        backgroundColor: AppColors.lightBlue,

        foregroundColor: AppColors.white,

        minimumSize: const Size(double.infinity, 60),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ),

    /// TEXT BUTTON THEME
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.white,

        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),

    /// INPUT FIELD THEME
    inputDecorationTheme: InputDecorationTheme(
      filled: false,

      hintStyle: const TextStyle(
        color: AppColors.hintColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),

        borderSide: const BorderSide(color: AppColors.borderColor, width: 1.5),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),

        borderSide: const BorderSide(color: AppColors.borderColor, width: 1.5),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),

        borderSide: const BorderSide(color: AppColors.white, width: 1.5),
      ),
    ),

    /// ICON THEME
    iconTheme: const IconThemeData(color: AppColors.white, size: 24),

    /// DIVIDER
    dividerColor: AppColors.borderColor,
  );
}
