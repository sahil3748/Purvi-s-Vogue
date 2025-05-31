import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color secondaryGold = Color(0xFFFFD700);
  static const Color darkCharcoal = Color(0xFF2F4F4F);
  static const Color cream = Color(0xFFFFFDD0);
  static const Color softBlack = Color(0xFF1A1A1A);

  static final ThemeData themeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: primaryGold,
      secondary: secondaryGold,
      surface: cream,
      background: Colors.white,
      onPrimary: softBlack,
      onSecondary: softBlack,
      onSurface: darkCharcoal,
      onBackground: darkCharcoal,
    ),

    // Typography
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: softBlack,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: softBlack,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: softBlack,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: softBlack,
      ),
      bodyLarge: GoogleFonts.lato(fontSize: 16, color: darkCharcoal),
      bodyMedium: GoogleFonts.lato(fontSize: 14, color: darkCharcoal),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: softBlack,
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGold,
        foregroundColor: softBlack,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  static BoxDecoration get backgroundGradient => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFFFFFDD0), Color(0xFFF5F5DC)],
      stops: [0.0, 0.5, 1.0],
    ),
  );
}
