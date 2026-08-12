import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SplashBubble extends StatelessWidget {
  final double size;
  final double opacity;

  const SplashBubble({
    super.key,
    required this.size,
    this.opacity = .12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: AppColors.secondary.withOpacity(opacity),

        border: Border.all(
          color: AppColors.primary.withOpacity(.22),
          width: 1.3,
        ),
      ),
    );
  }
}