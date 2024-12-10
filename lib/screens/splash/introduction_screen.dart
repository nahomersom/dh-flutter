import 'package:dh/constants/app_constants.dart';
import 'package:dh/routes/app_router.dart';
import 'package:dh/widgets/action_button.dart';
import 'package:dh/widgets/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Language Selector
              const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: LanguageSelector()),
              const SizedBox(height: 40),
              Text.rich(
                TextSpan(
                  text: "Getting Started in\n", // First part of the text
                  style: AppConstants.largeTitleTextStyle
                      .copyWith(fontSize: 36, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: "DH", // Second part of the text (centered)
                      style: AppConstants.largeTitleTextStyle.copyWith(
                          height: 1.5,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                textAlign: TextAlign.center, // Center the entire text block
              ),

              // Title

              SizedBox(height: 45.sp),

              // Feature List
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FeatureCard(
                      icon: Icons.task_alt_outlined,
                      title: "Effortless Task Management",
                      description:
                          "Simplify task management with intuitive features.",
                    ),
                    SizedBox(height: 45.sp),
                    const FeatureCard(
                      icon: Icons.groups_outlined,
                      title: "Seamless Team Collaboration",
                      description:
                          "A unified space to streamline your workflow.",
                    ),
                    SizedBox(height: 45.sp),
                    const FeatureCard(
                      icon: Icons.forum_outlined,
                      title: "Effective Communication",
                      description:
                          "Robust tools to keep teams connected and in sync.",
                    ),
                  ],
                ),
              ),

              // Continue Button
              SizedBox(
                  width: double.infinity,
                  child: ActionButton(
                    onPressed: () => context.go('/auth/sign-in'),
                    text: 'Continue',
                    isActionButton: true,
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Icon(icon, color: AppConstants.primaryAlternativeColor, size: 24),

        const SizedBox(width: 16),

        // Title and Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppConstants.bodyTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppConstants.primaryAlternativeColor,
                  )),
              const SizedBox(height: 4),
              Text(description,
                  style: AppConstants.bodyTextStyle.copyWith(
                    color: AppConstants.primaryAlternativeColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
