import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isActionButton;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return SizedBox(
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
                  fontWeight: isDisabled ? FontWeight.w700 : FontWeight.bold,
                  // Reduce text opacity when disabled
                  letterSpacing: isDisabled ? 0.5 : null,
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
    );
  }
}
