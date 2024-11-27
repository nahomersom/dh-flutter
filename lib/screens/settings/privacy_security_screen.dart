import 'package:dh/constants/app_constants.dart';
import 'package:dh/widgets/cutom_text.dart';
import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          title: "Privacy and Security",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.grey700,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.largeMargin,
            vertical: AppConstants.mediumMargin),
        child: ListView(
          children: [
            const Text(
              "Security",
              style: TextStyle(
                  color: AppConstants.grey500, fontSize: AppConstants.medium),
            ),
            const SizedBox(
              height: 10,
            ),
            actionContainer(Icons.key_outlined, Colors.amber,
                "Two-Step Verification", "On"),
            actionContainer(Icons.watch_later_outlined, Colors.red,
                "Auto-Delete Messages", "Off"),
            actionContainer(
                Icons.lock_outline, Colors.blue, "Passcode Lock", "On"),
            actionContainer(Icons.devices, Colors.green, "Devices", "2"),
          ],
        ),
      ),
    );
  }

  Container actionContainer(IconData icon, color, String title, String suffix) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppConstants.grey300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                const SizedBox(
                  width: 15,
                ),
                CustomText(
                    title: title,
                    textColor: AppConstants.black,
                    fontWeight: FontWeight.normal,
                    fontSize: AppConstants.medium),
              ],
            ),
            CustomText(
                title: suffix,
                textColor: AppConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: AppConstants.medium),
          ],
        ));
  }
}
