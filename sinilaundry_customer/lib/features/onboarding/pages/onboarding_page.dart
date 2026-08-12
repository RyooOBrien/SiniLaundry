import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/routes/app_routes.dart';
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
      image: "assets/images/onboarding/onboarding1.png",
      title: "Laundry Tanpa Ribet",
      description:
          "Pesan Laundry Hanya Dalam Beberapa Langkah Mudah.",
    ),

    OnboardingModel(
      image: "assets/images/onboarding/onboarding2.png",
      title: "Jemput Dan Antar",
      description:
          "Kurir Akan Menjemput Pakaian Dan Mengantarkannya Kembali Setelah Selesai Dicuci.",
    ),

    OnboardingModel(
      image: "assets/images/onboarding/onboarding3.png",
      title: "Pantau Laundry",
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
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF42B5FF),
              Color(0xFF2D9CDB),
              Color(0xFF238FD4),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
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

                const SizedBox(height: 10),

                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: items.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: OnboardingItem(
                          key: ValueKey(index),
                          item: items[index],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                SmoothPageIndicator(
                  controller: pageController,
                  count: items.length,
                  effect: const WormEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white38,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),

                const SizedBox(height: 30),

                NextButton(
                  onPressed: nextPage,
                  isLastPage: currentPage == items.length - 1,
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}