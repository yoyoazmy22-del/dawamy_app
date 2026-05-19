import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const SkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: isDark
            ? const Color(0xFF1E2038)
            : const Color(0xFFE8EAF0),
        highlightColor: isDark
            ? const Color(0xFF2A2C44)
            : const Color(0xFFF1F3F8),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1E2038)
                : const Color(0xFFE8EAF0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;

  const SkeletonCard({super.key, this.height, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(width: 120, height: 14),
            SizedBox(height: 12),
            SkeletonLoader(width: 200, height: 12),
            SizedBox(height: 8),
            SkeletonLoader(height: 12),
            SizedBox(height: 8),
            SkeletonLoader(width: 160, height: 12),
          ],
        ),
      ),
    );
  }
}

class SkeletonCalendar extends StatelessWidget {
  const SkeletonCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) => const SkeletonLoader(
            width: 32,
            height: 14,
            borderRadius: 4,
          )),
        ),
        const SizedBox(height: 16),
        ...List.generate(5, (row) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) => const SkeletonLoader(
              width: 36,
              height: 36,
              borderRadius: 10,
            )),
          ),
        )),
      ],
    );
  }
}
