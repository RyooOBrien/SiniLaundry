import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_item.dart';
import '../widgets/next_button.dart';
import '../widgets/skip_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int currentPage = 0;

  final List<OnboardingModel> items = [
    OnboardingModel(
      image: "assets/images/onboarding_1.png",
      title: "Laundry Tanpa Ribet",
      description:
          "Pesan Laundry Hanya Dalam Beberapa Langkah Mudah.",
     ),

     OnboardingModel(
      image: "assets/images/onboarding_2.png",
      title: "Jemput Dan Antar Laundry",
      description:
          "Kurir Akan Menjemput Pakain Dan Mengantarkannya Kembali Setelah Selesai Dicuci.",
      ),

      OnboardingModel(
      image: "assets/images/onboarding_3.png",
      title: "Pembayaran Mudah",
      description:
          "Pantau proses laundry secara real-time hingga pesanan selesai.",
      ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage == items.length - 1) {
      context.go(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SkipButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingItem(item: items[index]);
                  },
                ),
              ),

              SmoothPageIndicator(
                controller: pageController,
                count: items.length,
                effect: WormEffect(
                  activeDotColor: AppColors.primary,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              NextButton(
                onPressed: nextPage,
                isLastPage: currentPage == items.length - 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}