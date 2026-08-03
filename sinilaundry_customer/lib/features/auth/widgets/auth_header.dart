import 'package:flutter/material.dart' ;
import 'package:sinilaundry_customer/core/theme/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.displayLarge,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.heading1,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}