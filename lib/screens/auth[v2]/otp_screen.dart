import 'package:dh/constants/app_constants.dart';
import 'package:dh/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class OTPVerificationScreen extends StatefulWidget {
  final bool isFromSignUp;

  const OTPVerificationScreen({Key? key, required this.isFromSignUp})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // GlobalKey to access OTPInputField state
  final GlobalKey<_OTPInputFieldState> _otpKey =
      GlobalKey<_OTPInputFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.bodyPadding.copyWith(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("6-Digit Verification Code",
                  style: AppConstants.largeTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                "Mobile verification has been successfully sent.",
                style: AppConstants.bodyTextStyle.copyWith(
                  color: const Color(0xff2B2B2C),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Insert Code",
                style: AppConstants.bodyTextStyle.copyWith(
                  color: const Color(0xff2C2B2B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              const OTPInputField(),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Handle Resend Code action
                },
                child: Text("Resend Code",
                    style: AppConstants.bodySmallTextStyle.copyWith(
                      color: AppConstants.primaryAlternativeColor,
                    )),
              ),
              const Spacer(),
              ActionButton(
                onPressed: () {
                  widget.isFromSignUp
                      ? context.go('/auth/setup-profile')
                      : context.go('/auth/new-password');

                  // Ensure the OTPInputField state is not null
                  final otpFieldState = _otpKey.currentState;
                  if (otpFieldState != null && otpFieldState.isOTPValid()) {
                    String otp = otpFieldState.getEnteredOTP();

                    // Proceed with OTP
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all OTP fields."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: 'Confirm',
                isActionButton: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPInputField extends StatefulWidget {
  const OTPInputField({Key? key}) : super(key: key);

  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String getEnteredOTP() {
    // Concatenate all the OTP fields into a single string
    return _controllers.map((controller) => controller.text).join();
  }

  bool isOTPValid() {
    // Check if all fields are filled
    for (var controller in _controllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 48,
          height: 48,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],

            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1, // Only one character per box
            decoration: InputDecoration(
              hintText: '-',
              counterText: "", // Hides counter
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFBDBDBD),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF4525A2),
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}
