import 'package:flutter/material.dart';

class DesignTokens {
  // ── Spacing (8pt system) ──────────────────────────────────────────────────
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusS = 8.0;
  static const double radiusM = 16.0;
  static const double radiusL = 22.0; // Updated to 22 per request
  static const double radiusXL = 32.0;
  static const double radiusFull = 999.0;

  // ── Ultra Premium Gaming Color Palette ──────────────────────────────────────
  static const Color background = Color(0xFF06080F);
  static const Color backgroundDark = Color(0xFF0B0F1A);
  static const Color surface = Color(0xFF12182B);
  
  static const Color primary = Color(0xFF8B5CF6); // Purple Glow
  static const Color secondary = Color(0xFF22D3EE); // Cyan Glow
  static const Color accent = Color(0xFFA855F7); // Purple accent
  static const Color warning = Color(0xFFF43F5E); // Pink/Red Glow
  static const Color highlight = Color(0xFF00FFA3); // Electric Green

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color divider = Color(0xFF1F2937);

  static const Color glassWhite = Color(0x0DFFFFFF); // rgba(255,255,255,0.05)

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Shadows & Glows ───────────────────────────────────────────────────────
  static List<BoxShadow> neonShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.35),
      blurRadius: 20,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 40,
      spreadRadius: -5,
    ),
  ];

  static const List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Colors.black54,
      blurRadius: 30,
      offset: Offset(0, 10),
    ),
  ];
}


