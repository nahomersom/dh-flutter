import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInputWidget extends StatefulWidget {
  final Function(PhoneNumber) onInputChanged;
  final Function(bool) onInputValidated;
  final TextEditingController textFieldController;
  final FocusNode focusNode;
  final PhoneNumber initialNumber;
  final String? Function(String?)? validator;

  const PhoneNumberInputWidget({
    Key? key,
    required this.onInputChanged,
    required this.onInputValidated,
    required this.textFieldController,
    required this.focusNode,
    required this.initialNumber,
    this.validator,
  }) : super(key: key);

  @override
  _PhoneNumberInputWidgetState createState() => _PhoneNumberInputWidgetState();
}

class _PhoneNumberInputWidgetState extends State<PhoneNumberInputWidget> {
  bool isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          setState(() {
            if (widget.textFieldController.text.isEmpty) {
              isPhoneNumberValid = false;
            } else {
              isPhoneNumberValid = true;
              widget.onInputChanged(number);
            }
          });
        },
        onInputValidated: (bool value) {
          setState(() {
            isPhoneNumberValid = value;
            widget.onInputValidated(value);
          });
        },
        validator: widget.validator,
        selectorConfig: const SelectorConfig(
          useEmoji: true,
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          leadingPadding: 10,
          useBottomSheetSafeArea: true,
          setSelectorButtonAsPrefixIcon: false,
        ),
        focusNode: widget.focusNode,
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        initialValue: widget.initialNumber,
        spaceBetweenSelectorAndTextField: 0,
        textFieldController: widget.textFieldController,
        formatInput: false,
        cursorColor: Colors.blue, // Replace with your theme color if needed
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
    );
  }
}
