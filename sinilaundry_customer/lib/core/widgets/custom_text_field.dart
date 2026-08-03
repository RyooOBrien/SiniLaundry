import 'package:flutter/material.dart';

import 'package:sinilaundry_customer/core/theme/app_colors.dart';
import 'package:sinilaundry_customer/core/theme/app_radius.dart';
import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    
    _obscureText = widget.obscureText;
  }
  
  void _validate(String value) {
      if (widget.validator == null) return;

      setState(() {
        _errorText = widget.validator!(value);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodyLarge,
        ),

        const SizedBox(height: AppSpacing.sm),

        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          cursorColor: AppColors.primary,
          style: AppTextStyles.bodyLarge,
          autovalidateMode: AutovalidateMode.disabled,

          onChanged: (value) {
            _validate(value);

            widget.onChanged?.call(value);
          },

          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: _errorText,

            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),

            suffixIcon: widget.obscureText
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  )
                : widget.suffixIcon,

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
                
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 2,
              ),
            ),
            errorStyle: AppTextStyles.error,
          ),
        ),
      ],
    );
  }
}