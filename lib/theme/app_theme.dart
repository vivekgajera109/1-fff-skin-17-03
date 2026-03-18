import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';

class AppThemeV2 {
  static ThemeData get darkPremium {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DesignTokens.background,
      dividerColor: DesignTokens.divider,
      colorScheme: const ColorScheme.dark(
        surface: DesignTokens.surface,
        onSurface: DesignTokens.textPrimary,
        primary: DesignTokens.primary,
        secondary: DesignTokens.secondary,
        error: DesignTokens.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      // ── Typography ──────────────────────────────────────────────────────
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: DesignTokens.textPrimary,
            letterSpacing: -1,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: DesignTokens.textPrimary, size: 24),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: DesignTokens.textPrimary,
        ),
      ),

      // ── Card Theme ──────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: DesignTokens.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXL),
          side: const BorderSide(color: DesignTokens.border, width: 1),
        ),
      ),

      // ── Button Theme ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          ),
          elevation: 8,
          shadowColor: DesignTokens.primary.withOpacity(0.4),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ── Input Decoration ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: const BorderSide(color: DesignTokens.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: const BorderSide(color: DesignTokens.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: DesignTokens.textSecondary),
        hintStyle: const TextStyle(color: DesignTokens.textMuted, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),

      // ── Navigation Bar ───────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: DesignTokens.surface,
        indicatorColor: DesignTokens.primary.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: DesignTokens.primary);
          }
          return GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: DesignTokens.textSecondary);
        }),
      ),
    );
  }

  // Temporary for backwards compatibility
  static ThemeData get lightMinimal => darkPremium;
}

