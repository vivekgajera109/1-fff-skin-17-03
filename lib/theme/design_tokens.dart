import 'package:flutter/material.dart';

class DesignTokens {
  // ── Spacing (Consistent 8pt system) ────────────────────────────────────────
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusFull = 999.0;

  // ── premium Dark + Neon Color Palette ──────────────────────────────────────
  static const Color primary = Color(0xFFFFB300); // Cyber Gold
  static const Color secondary = Color(0xFF00E5FF); // Electric Cyan
  static const Color background = Color(0xFF010409); // Deep Technical Obsidian
  static const Color surface = Color(0xFF0D1117);    // Deep Tech Surface
  static const Color cardBg = Color(0xFF0D1117);
  
  static const Color accentNeon = Color(0xFFFFB300);
  static const Color accentCyan = Color(0xFF00E5FF);
  
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  
  static const Color border = Color(0xFF1E293B);
  static const Color divider = Color(0xFF0F172A);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFFE082)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [secondary, Color(0xFF80DEEA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF010614), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Shadows & Glows ───────────────────────────────────────────────────────
  static List<BoxShadow> neonGlow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
    BoxShadow(
      color: color.withOpacity(0.1),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x20000000),
      blurRadius: 20,
      offset: Offset(0, 10),
      spreadRadius: -5,
    ),
  ];

  // ── Backward Compatibility Aliases (to be removed after migration) ───────
  static const Color accent = secondary;
  static const List<BoxShadow> premiumShadow = cardShadow;
  static const List<BoxShadow> lightShadow = cardShadow;

  static const List<BoxShadow> none = [];
}


