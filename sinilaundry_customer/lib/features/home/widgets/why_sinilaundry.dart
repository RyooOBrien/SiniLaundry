import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class WhySiniLaundry extends StatelessWidget {
  const WhySiniLaundry({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        Icons.location_on_rounded,
        'Terdekat',
      ),
      (
        Icons.access_time_filled_rounded,
        'Cepat',
      ),
      (
        Icons.verified_user_rounded,
        'Aman',
      ),
      (
        Icons.chat_bubble_rounded,
        'Chat',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) {
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.$1,
                  color: AppColors.primary,
                  size: 23,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                item.$2,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}