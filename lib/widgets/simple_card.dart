import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class SimpleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final double? borderRadius;

  const SimpleCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.gradient,
    this.padding,
    this.width,
    this.height,
    this.boxShadow,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? DesignTokens.surface,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? DesignTokens.radiusL),
        boxShadow: boxShadow ?? DesignTokens.premiumShadow,
        border: Border.all(
          color: DesignTokens.border.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? DesignTokens.radiusL),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(DesignTokens.spacing16),
            child: child,
          ),
        ),
      ),
    );
  }
}
