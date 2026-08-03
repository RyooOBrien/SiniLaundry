import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_footer.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_header.dart';
import 'package:sinilaundry_customer/features/auth/widgets/divider_or.dart';
import 'package:sinilaundry_customer/features/auth/widgets/login_form.dart';
import 'package:sinilaundry_customer/features/auth/widgets/social_button.dart';
import 'package:go_router/go_router.dart';
import 'package:sinilaundry_customer/core/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),

              const AuthHeader(
                title: "Halo!",
                subtitle: "Selamat Datang Kembali",
                description:
                    "Masuk untuk melanjutkan menggunakan SiniLaundry.",
              ),

              const SizedBox(height: AppSpacing.xl),

              const LoginForm(),

              const SizedBox(height: AppSpacing.xl),

              const DividerOr(),

              const SizedBox(height: AppSpacing.xl),

              SocialButton(
                text: "Masuk dengan Google",
                icon: Image.asset(
                  "assets/images/logogoogle.png",
                  width: 22,
                  height: 22,
                  fit: BoxFit.contain,
                ),
                onPressed: () {},
              ),

              const SizedBox(height: AppSpacing.xl),

              AuthFooter(
                text: "Belum punya akun? ",
                actionText: "Daftar",
                onTap: () {
                context.push(AppRoutes.register);
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}