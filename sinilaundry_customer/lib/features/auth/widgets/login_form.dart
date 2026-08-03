import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/widgets/custom_text_field.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          label: "Email",
          hintText: "Masukkan email",
        ),

        const SizedBox(height: AppSpacing.md),

        const CustomTextField(
          label: "Password",
          hintText: "Masukkan password",
          obscureText: true,
        ),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text("Lupa Password?"),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        AuthButton(
          text: "Masuk",
          onPressed: () {},
        ),
      ],
    );
  }
}