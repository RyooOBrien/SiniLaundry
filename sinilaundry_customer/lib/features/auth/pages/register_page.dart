import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sinilaundry_customer/core/routes/app_routes.dart';
import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/widgets/custom_phone_field.dart';
import 'package:sinilaundry_customer/core/widgets/custom_text_field.dart';

import 'package:sinilaundry_customer/features/auth/widgets/auth_button.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_footer.dart';
import 'package:sinilaundry_customer/features/auth/widgets/auth_header.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(_checkFormValidity);
    phoneController.addListener(_checkFormValidity);
    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
    confirmPasswordController.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    final isValid =
        nameController.text.trim().length >= 3 &&
        phoneController.text.trim().length >= 9 &&
        RegExp(r'^[0-9]+$').hasMatch(phoneController.text) &&
        RegExp(
          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(emailController.text.trim()) &&
        passwordController.text.length >= 8 &&
        confirmPasswordController.text == passwordController.text;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),

                const AuthHeader(
                  title: "Daftar",
                  subtitle: "Buat Akun Baru",
                  description:
                      "Daftar untuk mulai menggunakan layanan SiniLaundry.",
                ),

                const SizedBox(height: AppSpacing.xl),

                CustomTextField(
                  controller: nameController,
                  onChanged: (_) => _checkFormValidity(),
                  label: "Nama Lengkap",
                  hintText: "Masukkan nama lengkap",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama lengkap wajib diisi";
                    }

                    if (value.trim().length < 3) {
                      return "Minimal 3 karakter";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                CustomPhoneField(
                  label: "Nomor Telepon",
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nomor telepon wajib diisi";
                    }

                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Nomor telepon hanya boleh berisi angka";
                    }

                    if (value.length < 9) {
                      return "Nomor telepon tidak valid";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                CustomTextField(
                  controller: emailController,
                  onChanged: (_) => _checkFormValidity(),
                  label: "Email",
                  hintText: "Masukkan email",
                  keyboardType: TextInputType.emailAddress,
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
                  onChanged: (_) => _checkFormValidity(),
                  label: "Password",
                  hintText: "Masukkan password",
                  obscureText: true,
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

                const SizedBox(height: AppSpacing.md),

                CustomTextField(
                  controller: confirmPasswordController,
                  onChanged: (_) => _checkFormValidity(),
                  label: "Konfirmasi Password",
                  hintText: "Masukkan ulang password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Konfirmasi password wajib diisi";
                    }

                    if (value != passwordController.text) {
                      return "Password tidak sama";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                AuthButton(
                  text: "Daftar",
                  onPressed: _isFormValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            print("Form Valid");
                          }
                        }
                      : null,
                ),

                const SizedBox(height: AppSpacing.lg),

                AuthFooter(
                  text: "Sudah punya akun? ",
                  actionText: "Masuk",
                  onTap: () {
                    context.go(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}