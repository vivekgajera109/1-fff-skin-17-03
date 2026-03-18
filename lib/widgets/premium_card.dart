import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool useGradient;
  final List<Color>? gradientColors;
  final double? borderRadius;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.useGradient = false,
    this.gradientColors,
    this.borderRadius,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? DesignTokens.radiusXL;
    
    return GestureDetector(
      onTapDown: (_) => widget.onTap != null ? _controller.forward() : null,
      onTapUp: (_) => widget.onTap != null ? _controller.reverse() : null,
      onTapCancel: () => widget.onTap != null ? _controller.reverse() : null,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: widget.useGradient
                ? LinearGradient(
                    colors: widget.gradientColors ?? [DesignTokens.primary, DesignTokens.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.useGradient ? null : DesignTokens.surface,
            border: Border.all(
              color: DesignTokens.border.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: widget.useGradient 
              ? [
                BoxShadow(
                  color: (widget.gradientColors?.first ?? DesignTokens.primary).withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
              : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
