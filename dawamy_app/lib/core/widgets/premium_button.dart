import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/typography.dart';

class PremiumButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final IconData? icon;

  const PremiumButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.icon,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: widget.isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isDisabled || widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: 150.ms,
        width: widget.width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: _isPressed ? 8 : 16,
              offset: Offset(0, _isPressed ? 2 : 6),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.2),
          ),
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onPrimary,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 18),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: AppTypography.button.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
