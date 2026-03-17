import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';

class AppThemeV2 {
  static ThemeData get lightMinimal {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: DesignTokens.background,
      dividerColor: DesignTokens.divider,
      colorScheme: const ColorScheme.light(
        primary: DesignTokens.primary,
        secondary: DesignTokens.secondary,
        surface: DesignTokens.background,
        onSurface: DesignTokens.textPrimary,
        error: DesignTokens.warning,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: GoogleFonts.outfitTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
            letterSpacing: -0.5,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
            letterSpacing: -0.5,
          ),
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: DesignTokens.textPrimary,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: DesignTokens.textSecondary,
            height: 1.5,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DesignTokens.textPrimary,
          ),
        ),
      ),

      // ── AppBar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: DesignTokens.textPrimary, size: 20),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: DesignTokens.textPrimary,
          letterSpacing: -0.5,
        ),
      ),

      // ── Card Theme ──────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: DesignTokens.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          side: const BorderSide(color: DesignTokens.divider, width: 1),
        ),
      ),

      // ── Button Theme ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          ),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Input Decoration ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: const BorderSide(color: DesignTokens.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: const BorderSide(color: DesignTokens.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: DesignTokens.textSecondary),
        hintStyle: const TextStyle(color: DesignTokens.textSecondary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // ── Navigation Bar ───────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DesignTokens.background,
        indicatorColor: DesignTokens.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: DesignTokens.primary);
          }
          return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: DesignTokens.textSecondary);
        }),
      ),
    );
  }
}

