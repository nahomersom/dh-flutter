import 'package:dh/routes/app_router.dart';
import 'package:dh/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:dh/constants/app_constants.dart';
import 'package:dh/widgets/cutom_text.dart';
import 'package:dh/screens/auth/widgets/shared_selectable_card.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  dynamic selectedValue; // Track the selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppConstants.bodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Forget Password?',
                    style: AppConstants.largeTitleTextStyle,
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                    title: "Please select a method to reset your password?",
                    textColor: AppConstants.grey800,
                    fontSize: AppConstants.large,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      SharedSelectableCard(
                        icon: Icons.mail_outline_outlined,
                        title: 'Send via SMS',
                        description:
                            'You will receive a verification code sent to your phone number.',
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        selected: selectedValue == 1,
                      ),
                      const SizedBox(height: 16),
                      SharedSelectableCard(
                        icon: Icons.email_outlined,
                        title: 'Send via Email',
                        description:
                            'You will receive a verification code sent to your email.',
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        selected: selectedValue == 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ActionButton(
                      onPressed: () {
                        context.go('/auth/forgot-password-phone');
                        // Handle continue action
                      },
                      text: 'Continue',
                      isActionButton: true,
                    ),
                    const SizedBox(height: 10),
                    ActionButton(
                      onPressed: () {
                        // Handle cancel action
                        print('Cancel button pressed');
                        context.go('/');
                      },
                      text: 'Cancel',
                      isActionButton: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
