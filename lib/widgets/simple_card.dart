import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class SimpleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const SimpleCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? DesignTokens.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        border: Border.all(color: DesignTokens.border.withOpacity(0.5), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(DesignTokens.spacing16),
            child: child,
          ),
        ),
      ),
    );
  }
}
