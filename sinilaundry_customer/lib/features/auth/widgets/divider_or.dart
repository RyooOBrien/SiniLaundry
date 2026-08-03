import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_colors.dart';
import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/theme/app_text_styles.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: Text(
            "Atau masuk dengan",
            style: AppTextStyles.bodyMedium,
          ),
        ),

        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}