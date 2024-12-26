import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/delete_account_modal.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/password_add_modal.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/privacy_setting_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyAndSecurityScreen extends StatefulWidget {
  const PrivacyAndSecurityScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyAndSecurityScreen> createState() =>
      _PrivacyAndSecurityScreenState();
}

class _PrivacyAndSecurityScreenState extends State<PrivacyAndSecurityScreen> {
  bool twoStepVerification = false;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _deletePasswordController = TextEditingController();

  // Function to show the bottom sheet
  Future<String?> showModal(BuildContext context, String type) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return type == "password"
            ? PasswordAddModal(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                newPasswordController: _newPasswordController,
                isUpdate: true,
              )
            : type == "lastSeen" || type == "phone"
                ? PrivacySettingModal(isPhone: type == "phone")
                : type == "delete"
                    ? DeleteAccountModal(
                        passwordController: _deletePasswordController)
                    : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Privacy and Security',
          style: TextStyle(
            color: AppTheme.gray.shade500,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'Security',
              style: TextStyle(
                color: AppTheme.primary.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 80,
            width: 1.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.key_outlined,
                    color: AppTheme.gray.shade400,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: Text(
                      'Two-Step Verification',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.gray.shade600),
                    ),
                    value: twoStepVerification,
                    onChanged: (bool value) {
                      setState(() {
                        twoStepVerification = value;
                      });
                    },
                    activeColor: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            iconColor: AppTheme.gray.shade400,
            title: Text(
              'Email Address',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.vpn_key_outlined),
            title: Text(
              'Change Password',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              showModal(context, "password");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'Privacy',
              style: TextStyle(
                color: AppTheme.primary.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Phone Number',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Contacts',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary.shade500),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              showModal(context, "phone");
            },
          ),
          ListTile(
            title: Text(
              'Last Seen & Online',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.gray.shade600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nobody',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary.shade500),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              showModal(context, "lastSeen");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'Account',
              style: TextStyle(
                color: AppTheme.primary.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Delete Account',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.error.shade600),
            ),
            leading: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onTap: () {
              showModal(context, "delete");
            },
          ),
        ],
      ),
    );
  }
}
