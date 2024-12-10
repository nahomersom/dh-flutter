import 'package:dh/widgets/action_button.dart';
import 'package:dh/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:dh/constants/app_constants.dart';
import 'package:dh/widgets/cutom_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ForgetPasswordPhoneFieldScreen extends StatefulWidget {
  const ForgetPasswordPhoneFieldScreen({super.key});

  @override
  State<ForgetPasswordPhoneFieldScreen> createState() =>
      _ForgetPasswordPhoneFieldScreenState();
}

class _ForgetPasswordPhoneFieldScreenState
    extends State<ForgetPasswordPhoneFieldScreen> {
  dynamic selectedValue; // Track the selected value
  final TextEditingController _newPasswordController = TextEditingController();
  PhoneNumber selectedNumber = PhoneNumber(isoCode: 'ET');
  bool isPhoneNumberValid = false;
  final phoneNumberController = TextEditingController();
  PhoneNumber initialNumber = PhoneNumber(isoCode: 'ET');

  final _phoneNumberNode = FocusNode();
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
                    title:
                        "Please insert your phone number. You will receive a verification code sent to your phone number.",
                    textColor: AppConstants.grey800,
                    fontSize: AppConstants.large,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      PhoneNumberInputWidget(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            // Handle phone number change
                            selectedNumber = number;
                          });
                        },
                        onInputValidated: (bool isValid) {
                          setState(() {
                            // Handle validation state
                            isPhoneNumberValid = isValid;
                          });
                        },
                        textFieldController: phoneNumberController,
                        focusNode: _phoneNumberNode,
                        initialNumber: initialNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number is empty';
                          }
                          if (!isPhoneNumberValid) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
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
                        // Handle continue action
                        print('Continue button pressed');
                      },
                      text: 'Continue',
                      isActionButton: true,
                    ),
                    const SizedBox(height: 10),
                    ActionButton(
                      onPressed: () {
                        // Handle cancel action
                        print('Cancel button pressed');
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
