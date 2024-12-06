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
    const primaryColor = Color(0xFF4525A2);
    return SizedBox(
      width: double.infinity,
      child: isActionButton
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 12px radius
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryColor),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 12px radius
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
