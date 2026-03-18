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
  static const double radiusL = 20.0; // Card radius (slightly larger for premium look)
  static const double radiusFull = 999.0;

  // ── Modern Premium Color Palette ──────────────────────────────────────────
  static const Color background = Color(0xFFFBFBFE);
  static const Color surface = Color(0xFFFFFFFF); // Card background
  
  static const Color primary = Color(0xFF6366F1); // Modern Indigo
  static const Color primaryGradientStart = Color(0xFF6366F1);
  static const Color primaryGradientEnd = Color(0xFF8B5CF6);
  
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryGradientStart = Color(0xFF10B981);
  static const Color secondaryGradientEnd = Color(0xFF059669);

  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color warning = Color(0xFFEF4444); // Rose

  static const Color textPrimary = Color(0xFF1F2937); // Rich Gray
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientStart, primaryGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF9FAFB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Shadows (Multi-layered for depth) ─────────────────────────────────────
  static const List<BoxShadow> lightShadow = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 20,
      offset: Offset(0, 10),
      spreadRadius: -5,
    ),
  ];

  static const List<BoxShadow> none = [];
}


