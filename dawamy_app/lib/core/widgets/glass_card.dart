import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.borderRadius,
    this.boxShadow,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0x99FFFFFF).withOpacity(0.04)
            : Colors.white.withOpacity(0.7),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.3),
          width: 0.5,
        ),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
