import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';

class AppThemeV2 {
  static ThemeData get premiumDark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DesignTokens.background,
      dividerColor: DesignTokens.divider,
      colorScheme: const ColorScheme.dark(
        primary: DesignTokens.primary,
        secondary: DesignTokens.secondary,
        tertiary: DesignTokens.highlight,
        surface: DesignTokens.surface,
        onSurface: DesignTokens.textPrimary,
        error: DesignTokens.warning,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: GoogleFonts.outfitTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: -1.5,
          ),
          displayMedium: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: -1.0,
          ),
          headlineLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: DesignTokens.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: DesignTokens.textPrimary,
            letterSpacing: 0.8,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFFE2E8F0),
            height: 1.6,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: DesignTokens.textSecondary,
            height: 1.5,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: DesignTokens.textPrimary,
          ),
        ),
      ),

      // ── AppBar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: DesignTokens.textPrimary),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: DesignTokens.textPrimary,
          letterSpacing: 2.0,
        ),
      ),

      // ── Card Theme ──────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: DesignTokens.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        ),
      ),

      // ── Button Theme ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),

      // ── Input Decoration ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: BorderSide(color: DesignTokens.primary.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: BorderSide(color: DesignTokens.primary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: DesignTokens.textSecondary),
        hintStyle:
            const TextStyle(color: DesignTokens.textSecondary, fontSize: 14),
      ),

      // ── Navigation Bar ───────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DesignTokens.background,
        indicatorColor: DesignTokens.primary.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.0),
        ),
      ),

      // ── Divider ──────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: DesignTokens.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

