import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLastPage;

  const NextButton({
    super.key,
    required this.onPressed,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,

          // Override dari AppTheme agar tidak full width
          minimumSize: const Size(0, 56),
          fixedSize: const Size(170, 56),

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLastPage ? "Mulai" : "Selanjutnya",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),

            if (!isLastPage) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}