import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/auth/sign_in_screen.dart';
import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../widgets/custom_botton.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/OnboardingScreen";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark));
    setKey();
    super.initState();
  }

  void setKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .12),
                      const CustomText(
                        title: "Get Started",
                        fontSize: AppConstants.xxxxLarge,
                        textColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.realtime,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "Live Video Collaboration",
                                textColor: Colors.black,
                                fontSize: AppConstants.large,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: const Text(
                                  "Enables real-time video collaboration with colleagues.",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(color: AppConstants.grey500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.smoothComunication,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "Effortless Communication",
                                textColor: Colors.black,
                                fontSize: AppConstants.large,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: const Text(
                                  "Facilitates group chatting, video calls, and file sharing.",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(color: AppConstants.grey500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.phCalendar,
                            height: 45,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.primaryColorLight,
                              BlendMode.srcIn,
                            ),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: "Task Management",
                                textColor: Colors.black,
                                fontSize: AppConstants.large,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: const Text(
                                  "Enables task management across the organization and different departments.",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(color: AppConstants.grey500),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    // if (_currentSlide == onboardingItems.length - 1) {
                    // LocalStorage.setFirstTimeOpeningApp();
                    //  Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
                    Navigator.push(
                        context,
                        customPageRoute(const SignInScreen(
                          newUser: false,
                        )));
                    // } else {
                    //   _currentSlide++;
                    //   setState(() {});
                    // }
                  },
                  title: "Continue",
                ),
                const SizedBox(
                  height: 60,
                )
              ]),
        ),
      ),
    );
  }
}
