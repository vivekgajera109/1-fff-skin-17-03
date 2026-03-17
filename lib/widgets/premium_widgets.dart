import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/common_button/common_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CyberButton — high-end button with tap animations and glows
// ─────────────────────────────────────────────────────────────────────────────
class CyberButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final Color? color;
  final double height;
  final double? width;

  const CyberButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.color,
    this.height = 60,
    this.width,
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? DesignTokens.primary;
    final secondaryColor = widget.isSecondary ? Colors.transparent : DesignTokens.secondary;

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DesignTokens.radiusL),
            gradient: widget.isSecondary 
                ? null 
                : LinearGradient(
                    colors: [baseColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: widget.isSecondary ? baseColor.withOpacity(0.12) : null,
            border: widget.isSecondary 
                ? Border.all(color: baseColor.withOpacity(0.4), width: 1.5)
                : null,
            boxShadow: widget.isSecondary 
                ? null 
                : [
                    BoxShadow(
                      color: baseColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: secondaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(DesignTokens.radiusL),
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(widget.icon,
                                color: widget.isSecondary ? baseColor : Colors.white,
                                size: 20),
                            const SizedBox(width: 10),
                          ],
                          Text(
                            widget.text.toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: widget.isSecondary ? baseColor : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PremiumDashboardCard — with gradient borders and neon glows
// ─────────────────────────────────────────────────────────────────────────────
class PremiumDashboardCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double? width;
  final double? height;
  final bool showGlow;
  final double borderRadius;

  const PremiumDashboardCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.width,
    this.height,
    this.showGlow = true,
    this.borderRadius = DesignTokens.radiusL,
  });

  @override
  Widget build(BuildContext context) {
    final accent = color ?? DesignTokens.primary;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showGlow ? [
          BoxShadow(
            color: accent.withOpacity(0.12),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: [
              accent.withOpacity(0.5),
              DesignTokens.secondary.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(1.5), // The Border width
        child: Container(
          decoration: BoxDecoration(
            color: DesignTokens.surface,
            borderRadius: BorderRadius.circular(borderRadius - 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius - 1),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GradientButton — primary CTA with glow effect (Updated)
// ─────────────────────────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final Color? color;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.color,
    this.height = 58,
  });

  @override
  Widget build(BuildContext context) {
    return CyberButton(
      text: text, 
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isSecondary: isSecondary,
      color: color,
      height: height,
    );
  }
}

// Backward-compatible alias
typedef NeonButton = GradientButton;
typedef PremiumButton = GradientButton;

// ─────────────────────────────────────────────────────────────────────────────
// GlassContainer — glassmorphism card with neon border
// ─────────────────────────────────────────────────────────────────────────────
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color? borderColor;
  final Color? glowColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.blur = 15.0,
    this.opacity = 0.08,
    this.borderRadius = DesignTokens.radiusL,
    this.borderColor,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = borderColor ?? DesignTokens.primary.withOpacity(0.2);
    final effectiveGlow = glowColor ?? DesignTokens.primary.withOpacity(0.08);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: effectiveGlow,
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DesignTokens.surface.withOpacity(opacity + 0.4),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: effectiveBorder,
                width: 1.5,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.01),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Backward-compatible alias
typedef GlassCard = GlassContainer;

// ─────────────────────────────────────────────────────────────────────────────
// NeonCard — solid card with neon border and glow
// ─────────────────────────────────────────────────────────────────────────────
class NeonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const NeonCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.borderRadius = DesignTokens.radiusL,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumDashboardCard(
      onTap: onTap,
      width: width,
      height: height,
      color: borderColor,
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// GlowContainer — adds a colored glow effect to any widget
// ─────────────────────────────────────────────────────────────────────────────
class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double blurRadius;
  final double spreadRadius;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor = DesignTokens.primary,
    this.blurRadius = 24.0,
    this.spreadRadius = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.2),
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GradientHeader — styled section header with neon accent bar
// ─────────────────────────────────────────────────────────────────────────────
class GradientHeader extends StatelessWidget {
  final String title;
  final Color? accentColor;
  final double fontSize;
  final bool centerTitle;

  const GradientHeader({
    super.key,
    required this.title,
    this.accentColor,
    this.fontSize = 13,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? DesignTokens.primary;
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, DesignTokens.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.8), blurRadius: 10),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.outfit(
              color: DesignTokens.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: fontSize,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ],
    );

    if (centerTitle) {
      return Center(child: row);
    }
    return row;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GlowIconButton — icon with neon glow backdrop
// ─────────────────────────────────────────────────────────────────────────────
class GlowIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final double size;

  const GlowIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? DesignTokens.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          border: Border.all(color: iconColor.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AnimatedListTile — animated list item with neon glow on tap
// ─────────────────────────────────────────────────────────────────────────────
class AnimatedListTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? accentColor;
  final Widget? trailing;

  const AnimatedListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.accentColor,
    this.trailing,
  });

  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? DesignTokens.primary;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: NeonCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          borderColor: accent.withOpacity(0.3),
          borderRadius: DesignTokens.radiusL,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accent.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                        color: accent.withOpacity(0.2), blurRadius: 12),
                  ],
                ),
                child: Icon(widget.icon, color: accent, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: DesignTokens.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle!,
                        style: GoogleFonts.outfit(
                          color: DesignTokens.textSecondary,
                          fontSize: 12,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              widget.trailing ??
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: accent.withOpacity(0.4), size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PremiumCard — animated tap card for home feature grid
// ─────────────────────────────────────────────────────────────────────────────
class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? glowColor;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.glowColor,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? DesignTokens.primary;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: GlowContainer(
          glowColor: glow.withOpacity(0.2),
          blurRadius: 16,
          spreadRadius: -4,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CyberSliverAppBar — sliver app bar with cyberpunk header aesthetic
// ─────────────────────────────────────────────────────────────────────────────
class CyberSliverAppBar extends StatelessWidget {
  final double expandedHeight;
  final String title;
  final bool showBack;
  final List<Widget> backgroundExtras;
  final Color? accentColor;
  final VoidCallback? onBack;

  const CyberSliverAppBar({
    super.key,
    required this.title,
    this.expandedHeight = 180,
    this.showBack = true,
    this.backgroundExtras = const [],
    this.accentColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? DesignTokens.primary;
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      stretch: true,
      backgroundColor: DesignTokens.background,
      leading: showBack
          ? Center(
              child: GlowIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                color: accent,
                size: 16,
                onTap: onBack ??
                    () async {
                      await CommonOnTap.openUrl();
                      await Future.delayed(const Duration(milliseconds: 400));
                      if (context.mounted) Navigator.pop(context);
                    },
              ),
            )
          : null,
      automaticallyImplyLeading: showBack,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        title: Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 4,
            color: DesignTokens.textPrimary,
            shadows: [
              Shadow(color: accent.withOpacity(0.8), blurRadius: 10),
            ],
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Deep dark gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accent.withOpacity(0.25),
                    DesignTokens.background,
                  ],
                ),
              ),
            ),
            // Scan line overlay
            Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _ScanLinePainter()),
            ),
            // Neon corner accent
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              left: -40,
              bottom: 40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.secondary.withOpacity(0.08),
                ),
              ),
            ),
            ...backgroundExtras,
            // Bottom gradient fade
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    DesignTokens.background.withOpacity(0.8),
                    DesignTokens.background,
                  ],
                  stops: const [0.5, 0.9, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// PageWrapper — base scaffold with cyberpunk ambient background
// ─────────────────────────────────────────────────────────────────────────────
class PageWrapper extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  const PageWrapper({
    super.key,
    required this.child,
    this.useSafeArea = true,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        extendBody: extendBody,
        body: Stack(
          children: [
            // Ambient glow — top right
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.primary.withOpacity(0.06),
                ),
              ),
            ),
            // Ambient glow — bottom left
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.secondary.withOpacity(0.05),
                ),
              ),
            ),
            useSafeArea ? SafeArea(child: child) : child,
          ],
        ),
      ),
    );
  }
}


