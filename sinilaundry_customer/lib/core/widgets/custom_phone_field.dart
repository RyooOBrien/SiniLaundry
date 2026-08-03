import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sinilaundry_customer/core/data/countries.dart';
import 'package:sinilaundry_customer/core/models/country_model.dart';
import 'package:sinilaundry_customer/core/theme/app_colors.dart';
import 'package:sinilaundry_customer/core/theme/app_radius.dart';
import 'package:sinilaundry_customer/core/theme/app_spacing.dart';
import 'package:sinilaundry_customer/core/theme/app_text_styles.dart';

class CustomPhoneField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  CountryModel selectedCountry = countries.first;

  void _showCountryPicker() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: 550,
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];

              return ListTile(
                leading: Text(
                  country.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(country.name),
                subtitle: Text(country.dialCode),
                trailing: country.code == selectedCountry.code
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedCountry = country;
                  });

                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      );
    },
  );
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
          validator: widget.validator,
          keyboardType: TextInputType.phone,
          cursorColor: AppColors.primary,

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(
              selectedCountry.maxLength,
            ),
          ],

          style: AppTextStyles.bodyLarge,

          decoration: InputDecoration(
            hintText: selectedCountry.example,

            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),

            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),

            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.md),
                onTap: _showCountryPicker,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCountry.flag,
                      style: const TextStyle(fontSize: 22),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      selectedCountry.dialCode,
                      style: AppTextStyles.bodyLarge,
                    ),

                    const SizedBox(width: 2),

                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),

                    const SizedBox(width: 10),

                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.border,
                    ),

                    const SizedBox(width: 10),
                  ],
                ),
              ),
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
          ),
        ),
      ],
    );
  }
}