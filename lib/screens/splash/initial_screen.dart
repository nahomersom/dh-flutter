// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:dh/main.dart';
import 'package:dh/model/models.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/routes/custom_page_route.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/utils/socket_connection.dart';
import 'package:dh/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';

class InitalScreen extends StatefulWidget {
  const InitalScreen({super.key});
  @override
  State<InitalScreen> createState() => _InitalScreenState();
}

class _InitalScreenState extends State<InitalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool isFirstLaunch = false;
  bool proLoaded = false;
  User? user;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 100),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          _loadProfile();
        });
      }
    });
    super.initState();
  }

  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.push(context, customPageRoute(const OnboardingScreen()));
    });
  }

  _loadProfile() async {
    var auth = AuthRepository();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    var token = await auth.getToken();
    await auth.getUserData().then((value) => {
          // setState(() {
          user = value,
          // proLoaded = true;
          user?.id != null ? connectAndListen(user!.id!) : null,

          if (isFirstLaunch)
            {
              Navigator.pushReplacement(
                  context, customPageRoute(const OnboardingScreen())),
            }
          else
            {
              if (user?.id != null && user?.firstName != null && token != null)
                {
                  Navigator.pushReplacement(
                      context, customPageRoute(const RootScreen())),
                }
              else
                {
                  Navigator.pushReplacement(
                      context,
                      customPageRoute(const SignInScreen(
                        newUser: false,
                      ))),
                }
            }
          // })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 120.sp, horizontal: 120.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers horizontally
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _animation.value,
                  child: Image.asset(AppAssets.dhLogoTwo),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
