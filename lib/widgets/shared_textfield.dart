import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword; // To handle password visibility toggle
  final TextStyle? labelTextStyle;
  const SharedTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.hintText = '',
    this.validator,
    this.labelTextStyle,
    this.isPassword = false, // Default: not a password field
  }) : super(key: key);

  @override
  State<SharedTextFormField> createState() => _SharedTextFormFieldState();
}

class _SharedTextFormFieldState extends State<SharedTextFormField> {
  bool _obscureText = true; // Password visibility toggle state

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: widget.labelTextStyle ??
              AppConstants.bodyTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppConstants.lightTextColor,
              ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: widget.controller,
          obscureText:
              widget.isPassword ? _obscureText : false, // Toggle visibility
          decoration: InputDecoration(
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            labelStyle: widget.labelTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Color(0xFFD6D6D7),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Color(0xFF4525A2),
                width: 2.0,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: 12, // Show errors with a small font size
              color: Colors.red,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null, // No suffix icon if it's not a password field
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
