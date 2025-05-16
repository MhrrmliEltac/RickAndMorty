import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: "Inter",
    colorScheme: ColorScheme(
      primary: Color(0xFF42B4CA),
      onPrimary: Color(0xFF42B4CA),
      secondary: Color(0xFFD5E9ED),
      onSecondary: Color(0xFFD5E9ED),
      surface: Colors.white,
      brightness: Brightness.light,
      onSurface: Color(0xFF414A4C),
      error: Color(0xFFEA7979),
      onError: Color(0xFFEA7979),
      tertiary: Color(0xFFB5C4C7),
      
      
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: const Color(0xFF42B4CA)),
    ),
  );
}
