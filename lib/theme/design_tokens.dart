import 'package:flutter/material.dart';

class DesignTokens {
  // ── Spacing (Consistent 8pt system) ────────────────────────────────────────
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusS = 8.0;
  static const double radiusM = 12.0; // Button radius
  static const double radiusL = 16.0; // Card radius
  static const double radiusFull = 999.0;

  // ── Minimal & Clean Color Palette ─────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F7FB); // Card background
  
  static const Color primary = Color(0xFF4F46E5); // Indigo
  static const Color secondary = Color(0xFF22C55E); // Green
  static const Color accent = Color(0xFFF59E0B); // Orange
  static const Color warning = Color(0xFFEF4444); // Red

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // ── Shadows (Very light or none) ──────────────────────────────────────────
  static const List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> none = [];
}


