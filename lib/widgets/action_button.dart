import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isActionButton;
  final String? bottomButtonText;
  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isActionButton,
    this.bottomButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: isActionButton
              ? ElevatedButton(
                  onPressed: isDisabled ? null : onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDisabled
                        ? const Color(0xFFA5A5A6) // Disabled background color
                        : AppConstants.secondayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // 12px radius
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
                          isDisabled ? FontWeight.w700 : FontWeight.bold,
                      letterSpacing: isDisabled ? 0.5 : null, // Reduced opacity
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: isDisabled ? null : onPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppConstants.secondayColor,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // 12px radius
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: AppConstants.secondayColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        if (bottomButtonText != null) ...[
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: AppConstants.bodyTextStyle.copyWith(
                  color: AppConstants.grey800,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: '$bottomButtonText here',
                    style: AppConstants.bodyTextStyle.copyWith(
                      color: AppConstants.primaryAlternativeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
