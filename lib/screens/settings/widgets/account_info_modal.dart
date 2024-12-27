import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountInfoModal extends StatefulWidget {
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? newPasswordController;
  final TextEditingController? emailController;
  final bool isUpdate;
  final bool isEmail;

  const AccountInfoModal(
      {Key? key,
      required this.passwordController,
      required this.confirmPasswordController,
      this.newPasswordController,
      this.emailController,
      this.isUpdate = false,
      this.isEmail = false})
      : super(key: key);

  @override
  State<AccountInfoModal> createState() => _AccountInfoModalState();
}

class _AccountInfoModalState extends State<AccountInfoModal> {
  void _savePassword() {
    if ((widget.isUpdate
            ? widget.newPasswordController!.text
            : widget.passwordController!.text) ==
        widget.confirmPasswordController!.text) {
      context.go(
        "/workspace/profile/setting/privacy-security/verify-otp/",
        extra: {
          'phone': "09898787989",
          'from': "setting",
        },
      );
      // Navigator.pop(context, widget.passwordController!.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.99,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isUpdate
                            ? 'Change ${widget.isEmail ? "Email" : "Password"}'
                            : 'Create ${widget.isEmail ? "Email" : "Verification Password"}',
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
                  if (widget.isEmail) ...[
                    SharedTextFormField(
                      controller: widget.emailController!,
                      isPassword: false,
                      label: 'Email',
                    ),
                  ] else ...[
                    SharedTextFormField(
                      controller: widget.passwordController!,
                      isPassword: true,
                      label: widget.isUpdate
                          ? 'Insert Old Password'
                          : 'Verification Password',
                    ),
                    SizedBox(height: 8.h),
                    if (widget.isUpdate)
                      SharedTextFormField(
                        controller: widget.newPasswordController!,
                        isPassword: true,
                        label: 'New Password',
                      ),
                    SizedBox(height: 8.h),
                    SharedTextFormField(
                      controller: widget.confirmPasswordController!,
                      isPassword: true,
                      label: widget.isUpdate
                          ? 'Confirm New Password'
                          : 'Confirm Password',
                    ),
                  ],
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      showConfirmationDialog(
                          context: context,
                          title: "Are you sure you want to Change Password?",
                          content:
                              "A confirmation code will be sent to you to change your password.",
                          onConfirm: _savePassword);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary.shade600,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '${widget.isUpdate ? "Update" : "create"} ${widget.isEmail ? "Email" : "password"}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.baseWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
