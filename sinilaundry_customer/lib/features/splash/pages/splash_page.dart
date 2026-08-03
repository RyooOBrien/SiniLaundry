import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:sinilaundry_customer/core/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
    @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      context.go(AppRoutes.onboarding);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.local_laundry_service_rounded,
              size: 90,
              color: Colors.white,
            ),

            const SizedBox(height: 24),

            Text(
              "SiniLaundry",
              style: AppTextStyles.displayLarge.copyWith(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Laundry jadi lebih mudah",
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}