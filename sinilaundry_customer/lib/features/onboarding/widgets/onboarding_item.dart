import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel item;

  const OnboardingItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // ========================
          // Ilustrasi
          // ========================
          Transform.scale(
            scale: 1.25,
            child: SizedBox(
              height: 330,
              child: Image.asset(
                item.image,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ========================
          // Judul
          // ========================
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: .85),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}