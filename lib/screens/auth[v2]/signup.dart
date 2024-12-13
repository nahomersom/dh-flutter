import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/widgets/action_button.dart';
import 'package:dh_flutter_v2/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpByPhoneScreen extends StatefulWidget {
  @override
  _SignUpByPhoneScreenState createState() => _SignUpByPhoneScreenState();
}

class _SignUpByPhoneScreenState extends State<SignUpByPhoneScreen> {
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
                  Text('Sign Up',
                      style: AppConstants.largeTitleTextStyle
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 20),

                  // Phone Number Input Label
                  Text('Phone Number',
                      style: AppConstants.bodyTextStyle
                          .copyWith(color: const Color(0xff2C2B2B))),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          // Update the selected number and validation based on input
                          if (phoneNumberController.text.isEmpty) {
                            isPhoneNumberValid = false;
                          } else {
                            selectedNumber = number;
                            isPhoneNumberValid = true; // Valid input
                          }
                        });
                      },
                      validator: (value) {
                        // Validation logic for phone number
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is empty';
                        }
                        if (!isPhoneNumberValid) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onInputValidated: (bool value) {
                        setState(() {
                          isPhoneNumberValid =
                              value; // Update boolean based on validity
                        });
                      },
                      selectorConfig: const SelectorConfig(
                        useEmoji: true,
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        leadingPadding: 10,
                        useBottomSheetSafeArea: true,
                        setSelectorButtonAsPrefixIcon: false,
                      ),
                      focusNode: _phoneNumberNode,
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      initialValue: initialNumber,
                      spaceBetweenSelectorAndTextField: 0,
                      textFieldController: phoneNumberController,
                      formatInput: false,
                      cursorColor: AppConstants.primaryColor,
                      keyboardType: TextInputType.phone,
                      inputDecoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 17),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF8E8E8E),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
              ActionButton(
                onPressed: isPhoneNumberValid
                    ? () {
                        // Handle valid phone number submission
                        context.go(
                          '/auth/otp',
                          extra: true,
                        );
                      }
                    : null, // Disable button if invalid
                text: 'Sign Up',
                isActionButton: true,
                bottomButtonText: 'Log in',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
