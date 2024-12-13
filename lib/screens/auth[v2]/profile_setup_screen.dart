import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/routes/app_router.dart';
import 'package:dh_flutter_v2/widgets/action_button.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  // Method to check form validity and update the button state
  void _updateButtonState() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize for the keyboard
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: AppConstants.bodyPadding.copyWith(top: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setup your profile',
                      style: AppConstants.largeTitleTextStyle
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 25.h),
                    Form(
                      key: _formKey,
                      onChanged:
                          _updateButtonState, // Dynamically check form validity
                      child: Column(
                        children: [
                          SharedTextFormField(
                            controller: _firstNameController,
                            label: 'First Name',
                            hintText: 'Insert First Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15.h),
                          SharedTextFormField(
                            controller: _middleNameController,
                            label: 'Middle Name',
                            hintText: 'Insert Middle Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Middle Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15.h),
                          SharedTextFormField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            hintText: 'Insert Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15.h),
                          SharedTextFormField(
                            controller: _emailController,
                            label: 'Email (optional)',
                            hintText: 'Insert Email',
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed ActionButton at the Bottom
            Padding(
              padding: EdgeInsets.only(
                left: AppConstants.bodyPadding.left,
                right: AppConstants.bodyPadding.right,
                bottom: 16.h, // Adjust for spacing from the screen edge
              ),
              child: ActionButton(
                onPressed: _isFormValid
                    ? () {
                        // Navigate when form is valid
                        context.go('/auth/profile-image');
                      }
                    : null, // Disable the button when the form is invalid
                text: 'Continue',
                isActionButton: true,
                bottomButtonText: 'Log in',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
