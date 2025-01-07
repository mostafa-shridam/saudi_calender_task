import 'package:flutter/material.dart';

const Color whiteColor = Colors.white;
const Color successGreen = Color(0xFF0CB450);
const Color warningYellow = Color(0xFFFFC100);
const Color dangerRed = Color(0xFFFE5960);
const Color primaryColor = Color(0XFF005a74);
const Color accentColor = Color(0XFF377dbf);
const MaterialColor graySwatch = MaterialColor(0XFF000000, {
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(0xFF64748B),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
});

ThemeData appTheme(String usedFontFamily) {
  final double alpha = 0.0;
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryIconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: graySwatch.shade600,
      size: 24,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: whiteColor,
      toolbarHeight: 57,
      titleTextStyle: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: usedFontFamily,
      ),
      iconTheme: IconThemeData(
        color: graySwatch.shade600,
        size: 24,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: whiteColor,
      selectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: usedFontFamily,
        color: graySwatch.shade600,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      unselectedIconTheme: IconThemeData(color: graySwatch.shade600),
      selectedIconTheme: const IconThemeData(color: primaryColor),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: graySwatch.shade900,
      unselectedItemColor: graySwatch.shade600,
    ),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      surface: whiteColor,
      secondary: accentColor,
      primary: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => primaryColor,
        ),
      ),
    ),
    fontFamily: usedFontFamily,
    scaffoldBackgroundColor: whiteColor,
    secondaryHeaderColor: const Color(0XFF262d31),
    dividerColor: const Color(0XFFE2E8F0),
    dividerTheme: const DividerThemeData(
      color: Color(0XFFE2E8F0),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 14 + alpha,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 16 + alpha,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: TextStyle(
        color: graySwatch.shade900,
        fontSize: 30 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: graySwatch.shade900,
        fontSize: 26 + alpha,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: graySwatch.shade900,
        fontSize: 22 + alpha,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
