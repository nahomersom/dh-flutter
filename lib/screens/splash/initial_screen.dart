// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/utils/socket_connection.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void initState() {
    super.initState();

    // Initialize the animation
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

    // Navigate to `/introduction` after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context
            .go('/introduction'); // Make sure to use `context.go` for GoRouter
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 120.sp, horizontal: 120.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
