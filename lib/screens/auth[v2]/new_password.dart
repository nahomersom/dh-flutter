import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/widgets/action_button.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.bodyPadding.copyWith(top: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set New Password',
                style: AppConstants.largeTitleTextStyle
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 25.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SharedTextFormField(
                      controller: _newPasswordController,
                      label: 'New Password',
                      hintText: 'Enter new password',
                      isPassword: true, // Enable password visibility toggle
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    SharedTextFormField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      isPassword: true, // Enable password visibility toggle
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const ActionButton(
                onPressed: null,
                text: 'Reset Password',
                isActionButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
