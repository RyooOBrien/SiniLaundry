import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/splash_bubble.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), (  ) {
      if (!mounted) return;

      context.go(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
        children: [
          // ======================
          // TOP LEFT
          // ======================

          const Positioned(
            top: -40,
            left: -40,
            child: SplashBubble(size: 170),
          ),

          const Positioned(
            top: 40,
            left: 120,
            child: SplashBubble(
              size: 50,
              opacity: .18,
            ),
          ),

          const Positioned(
            top: 120,
            left: 40,
            child: SplashBubble(
              size: 28,
              opacity: .22,
            ),
          ),

          // ======================
          // TOP RIGHT
          // ======================

          const Positioned(
            top: -35,
            right: -35,
            child: SplashBubble(size: 150),
          ),

          const Positioned(
            top: 70,
            right: 95,
            child: SplashBubble(
              size: 42,
              opacity: .18,
            ),
          ),

          const Positioned(
            top: 140,
            right: 35,
            child: SplashBubble(
              size: 22,
              opacity: .25,
            ),
          ),

          // ======================
          // BOTTOM LEFT
          // ======================

          const Positioned(
            bottom: -45,
            left: -45,
            child: SplashBubble(size: 180),
          ),

          const Positioned(
            bottom: 85,
            left: 85,
            child: SplashBubble(
              size: 40,
              opacity: .18,
            ),
          ),

          const Positioned(
            bottom: 145,
            left: 25,
            child: SplashBubble(
              size: 24,
              opacity: .25,
            ),
          ),

          // ======================
          // BOTTOM RIGHT
          // ======================

          const Positioned(
            bottom: -40,
            right: -40,
            child: SplashBubble(size: 170),
          ),

          const Positioned(
            bottom: 95,
            right: 90,
            child: SplashBubble(
              size: 38,
              opacity: .18,
            ),
          ),

          const Positioned(
            bottom: 150,
            right: 30,
            child: SplashBubble(
              size: 24,
              opacity: .25,
            ),
          ),

          // ======================
          // BRAND
          // ======================

          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Sini",
                    style: AppTextStyles.displayLarge.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: "Laundry",
                    style: AppTextStyles.displayLarge.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}