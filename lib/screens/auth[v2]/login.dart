import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/widgets/action_button.dart';
import 'package:dh_flutter_v2/widgets/language_selector.dart';
import 'package:dh_flutter_v2/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _countryCode;
  String? _phoneNumber;
  PhoneNumber initialNumber = PhoneNumber(isoCode: 'ET');
  PhoneNumber selectedNumber = PhoneNumber(isoCode: 'ET');
  final phoneNumberController = TextEditingController();

  final _phoneNumberNode = FocusNode();
  bool isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.bodyPadding.copyWith(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Language Selection
                  LanguageSelector(),
                  const SizedBox(height: 40),

                  // Sign Up Header
                  Text('Login',
                      style: AppConstants.largeTitleTextStyle
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 20),

                  // Phone Number Input Label
                  Text('Phone Number',
                      style: AppConstants.bodyTextStyle
                          .copyWith(color: const Color(0xff2C2B2B))),
                  const SizedBox(height: 10),
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

                  const SizedBox(height: 30),
                ],
              ),
              ActionButton(
                onPressed: isPhoneNumberValid
                    ? () => context.go('/auth/2-step-verification')
                    : null, // Disable button if invalid
                text: 'Login',
                isActionButton: true,
                bottomButtonText: 'Sign up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
