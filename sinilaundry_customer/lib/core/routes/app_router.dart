import 'package:go_router/go_router.dart';

import 'package:sinilaundry_customer/core/routes/app_routes.dart';
import 'package:sinilaundry_customer/features/auth/pages/login_page.dart';
import 'package:sinilaundry_customer/features/auth/pages/register_page.dart';
import 'package:sinilaundry_customer/features/splash/pages/splash_page.dart';
import 'package:sinilaundry_customer/features/onboarding/pages/onboarding_page.dart';
import 'package:sinilaundry_customer/features/auth/pages/forgot_password_page.dart';
import '../../features/home/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],

  );
}