import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/common_button/common_button.dart';
import 'premium_card.dart';
export 'premium_card.dart';

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
    this.height = 56,
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
            borderRadius: BorderRadius.circular(DesignTokens.radiusM),
            gradient: widget.isSecondary 
                ? null 
                : DesignTokens.primaryGradient,
            color: widget.isSecondary ? Colors.transparent : null,
            border: widget.isSecondary 
                ? Border.all(color: baseColor, width: 2)
                : null,
            boxShadow: widget.isSecondary 
                ? null 
                : DesignTokens.neonGlow(baseColor),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isLoading ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(DesignTokens.radiusM),
              child: Center(
                child: widget.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(widget.icon,
                                color: Colors.white,
                                size: 20),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            widget.text,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
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
  final double? borderRadius;

  const PremiumDashboardCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.width,
    this.height,
    this.showGlow = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? DesignTokens.radiusXL;
    return PremiumCard(
      onTap: onTap,
      borderRadius: effectiveRadius,
      child: child,
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
  final double? borderRadius;
  final Color? borderColor;
  final Color? glowColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.blur = 20.0,
    this.opacity = 0.1,
    this.borderRadius,
    this.borderColor,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? DesignTokens.radiusXL;
    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DesignTokens.surface.withOpacity(opacity),
            borderRadius: BorderRadius.circular(effectiveRadius),
            border: Border.all(
              color: (borderColor ?? Colors.white).withOpacity(0.1),
              width: 1,
            ),
          ),
          child: child,
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
        child: Container(
          decoration: BoxDecoration(
            color: DesignTokens.surface,
            borderRadius: BorderRadius.circular(DesignTokens.radiusL),
            border: Border.all(color: DesignTokens.border.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                ),
                child: Icon(widget.icon, color: accent, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle!,
                        style: GoogleFonts.inter(
                          color: DesignTokens.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              widget.trailing ??
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: DesignTokens.textMuted, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

// PremiumCard removed — now imported from premium_card.dart

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
                      if (context.mounted) Navigator.of(context).maybePop();
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
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: DesignTokens.textPrimary,
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

// ─────────────────────────────────────────────────────────────────────────────
// CyberFrameCard — Tech-styled frame with custom clipping and neon pulse
// ─────────────────────────────────────────────────────────────────────────────

class CyberFrameCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? accentColor;

  const CyberFrameCard({
    super.key,
    required this.child,
    this.onTap,
    this.accentColor,
  });

  @override
  State<CyberFrameCard> createState() => _CyberFrameCardState();
}

class _CyberFrameCardState extends State<CyberFrameCard> with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.accentColor ?? DesignTokens.primary;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulseAnim,
        builder: (context, child) {
          return CustomPaint(
            painter: _CyberFramePainter(
              color: color.withOpacity(_pulseAnim.value),
              strokeWidth: 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: DesignTokens.surface.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                   // Tech background details
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Icon(Icons.settings_input_component_rounded, color: color.withOpacity(0.05), size: 80),
                  ),
                  widget.child,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CyberFramePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CyberFramePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Top Left Corner
    path.moveTo(0, 40);
    path.lineTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);
    path.lineTo(60, 0);

    // Bottom Right Corner
    path.moveTo(size.width - 60, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, size.height - 40);

    // Small accents
    canvas.drawPath(path, paint);

    // Glow effect
    canvas.drawPath(path, Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));
  }

  @override
  bool shouldRepaint(covariant _CyberFramePainter oldDelegate) => oldDelegate.color != color;
}

// ─────────────────────────────────────────────────────────────────────────────
// CyberImageFrame — luxury image frame with reflection and aura
// ─────────────────────────────────────────────────────────────────────────────

class CyberImageFrame extends StatelessWidget {
  final String? imagePath;
  final IconData? fallbackIcon;
  final Color accentColor;
  final double height;

  const CyberImageFrame({
    super.key,
    this.imagePath,
    this.fallbackIcon,
    required this.accentColor,
    this.height = 280,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Multi-layered Aura
          _buildAura(2),
          _buildAura(1),
          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main Image
              Expanded(
                child: _buildImage(isReflection: false),
              ),
              
              // Mirror Reflection
              SizedBox(
                height: height * 0.25,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white.withOpacity(0.3), Colors.transparent],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(1.0, -1.0)
                      ..translate(0.0, 10.0),
                    child: _buildImage(isReflection: true),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAura(int layer) {
    return Container(
      width: 140.0 * layer,
      height: 140.0 * layer,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            accentColor.withOpacity(0.15 / layer),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildImage({required bool isReflection}) {
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.contain,
        opacity: isReflection ? const AlwaysStoppedAnimation(0.3) : null,
      );
    }
    return Icon(
      fallbackIcon ?? Icons.inventory_2_outlined,
      size: isReflection ? 40 : 80,
      color: accentColor.withOpacity(isReflection ? 0.2 : 1),
    );
  }
}

