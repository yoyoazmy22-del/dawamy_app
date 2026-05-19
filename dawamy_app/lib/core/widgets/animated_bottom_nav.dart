import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/typography.dart';

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;

  const AnimatedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? const Color(0xFF151729)
        : const Color(0xFFFFFFFF);
    final borderColor = isDark
        ? const Color(0xFF2E304A)
        : const Color(0xFFE2E5ED);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return Expanded(
                child: _NavItem(
                  item: items[index],
                  isSelected: currentIndex == index,
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _NavItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: 200.ms,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: 200.ms,
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
                size: 22,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.4),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
