import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- COLORS ---
  static const Color primary = Color(0xFF1B3C53);
  static const Color secondary = Color(0xFF456882);
  static const Color accent = Color(0xFFD2C1B6);
  static const Color accent2 = Color(0xFF7C7861);
  static const Color bgColor = Colors.white;

  // Use this helper for readability
  static int _alpha(double opacity) => (255 * opacity).round();

  // --- SEMANTIC COLORS ---
  static final Color primaryLow = primary.withAlpha(_alpha(0.10)); // 10%
  static final Color primaryGhost = primary.withAlpha(_alpha(0.05)); // 5%
  static final Color shadow = Colors.black.withAlpha(_alpha(0.08)); // 8%

  // --- BORDER RADIUS ---
  static const double rSmall = 4.0;
  static const double rMedium = 12.0;
  static const double rLarge = 24.0;
  static const double rFull = 100.0;

  static final BorderRadius brSmall = BorderRadius.circular(rSmall);
  static final BorderRadius brMedium = BorderRadius.circular(rMedium);
  static final BorderRadius brLarge = BorderRadius.circular(rLarge);
  static final BorderRadius brFull = BorderRadius.circular(rFull);

  // --- TEXT STYLES ---
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    color: primary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    color: primary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: primary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
    color: primary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.1,
    color: primary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: primary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
    color: primary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 11,
    letterSpacing: 0.5,
    fontWeight: FontWeight.normal,
    color: primary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    letterSpacing: 0.5,
    fontWeight: FontWeight.normal,
    color: primary,
  );

  static const TextStyle labelExLarge = TextStyle(
    fontSize: 20,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w800,
    color: primary,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.playpenSansTextTheme(),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppTheme.bgColor,
      ),
    );
  }
}
