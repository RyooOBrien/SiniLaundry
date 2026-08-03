import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/widgets/custom_text_field.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isFormValid = false;

  void _checkForm() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailValid = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);

    final passwordValid = password.length >= 8;

    setState(() {
      _isFormValid = emailValid && passwordValid;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            label: "Email",
            hintText: "Masukkan email",
            keyboardType: TextInputType.emailAddress,

            onChanged: (_) => _checkForm(),

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email wajib diisi";
              }

              if (!RegExp(
                r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value.trim())) {
                return "Format email tidak valid";
              }

              return null;
            },
          ),

          const SizedBox(height: AppSpacing.md),

          CustomTextField(
            controller: passwordController,
            label: "Password",
            hintText: "Masukkan password",
            obscureText: true,

            onChanged: (_) => _checkForm(),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password wajib diisi";
              }

              if (value.length < 8) {
                return "Password minimal 8 karakter";
              }

              return null;
            },
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
            onPressed: _isFormValid
                ? () {
                    if (_formKey.currentState!.validate()) {
                      debugPrint("Login");
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}