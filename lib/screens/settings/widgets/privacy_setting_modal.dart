import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacySettingModal extends StatefulWidget {
  final bool isPhone;

  const PrivacySettingModal({Key? key, required this.isPhone})
      : super(key: key);

  @override
  State<PrivacySettingModal> createState() => _PrivacySettingModalState();
}

class _PrivacySettingModalState extends State<PrivacySettingModal> {
  String selectedValue = 'My Contacts';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      height: 0.5.sh,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isPhone ? 'Phone Number' : 'Last Seen & Online',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.gray.shade600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Who can see your ${widget.isPhone ? "phone number" : "last seen time"}?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurple.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurple.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.deepPurple.shade400),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            items: const [
              DropdownMenuItem(
                value: 'Everybody',
                child: Text('Everybody'),
              ),
              DropdownMenuItem(
                value: 'My Contacts',
                child: Text('My Contacts'),
              ),
              DropdownMenuItem(
                value: 'Nobody',
                child: Text('Nobody'),
              ),
            ],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedValue = newValue;
                });
              }
            },
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              showConfirmationDialog(
                  context: context,
                  title: "Are you sure you want to update the setting?",
                  content: "changes will be applied",
                  onConfirm: () {
                    Navigator.pop(context);
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary.shade600,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.baseWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
