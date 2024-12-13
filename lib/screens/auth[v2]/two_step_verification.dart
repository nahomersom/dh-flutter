import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/widgets/action_button.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  @override
  _TwoStepVerificationScreenState createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
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
                '2 Step Verfication',
                style: AppConstants.largeTitleTextStyle
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 25.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedTextFormField(
                      controller: _newPasswordController,
                      label: '2-step verfication password',
                      labelTextStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppConstants.lightTextColor,
                      ),
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
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => context.go('/auth/forgot-password'),
                      child: Text(
                        'Forgot Password?',
                        style: AppConstants.bodySmallTextStyle.copyWith(
                            color: AppConstants.primaryAlternativeColor),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              const ActionButton(
                onPressed: null,
                text: 'Login',
                isActionButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
