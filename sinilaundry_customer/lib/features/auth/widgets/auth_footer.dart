import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_colors.dart';
import 'package:sinilaundry_customer/core/theme/app_text_styles.dart';

class  AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),

          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}