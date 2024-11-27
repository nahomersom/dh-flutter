// ignore_for_file: use_build_context_synchronously, must_be_immutable, library_private_types_in_public_api
import 'dart:async';

import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/model/user_model.dart';
import 'package:dh/repository/auth_repository.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String from;
  OtpScreen({super.key, required this.phoneNumber, required this.from});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> _otpDigits = List.generate(4, (_) => '');
  String code = "";
  bool resending = false;
  bool isFirstTime = true;
  bool resendCode = false;
  int resendToken = 0;
  int currentSeconds = 0;
  final int timerMaxSeconds = 120;
  int _animatedIndex = -1;
  int selectedIndex = -1;
  final interval = const Duration(seconds: 1);

  User? user;
  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  startTimeout([milliseconds]) {
    setState(() {
      resendCode = false;
    });
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) {
            timer.cancel();
            setState(() {
              resendCode = true;
            });
          }
        });
      }
    });
  }

  void _addNumberToOtp(String number) {
    if (_otpDigits.any((digit) => digit.isEmpty)) {
      setState(() {
        int emptyIndex = _otpDigits.indexWhere((digit) => digit.isEmpty);
        _otpDigits[emptyIndex] = number;
        if (number == "0") {
          selectedIndex = 0;
        } else {
          _animatedIndex = int.parse(number) - 1;
        }
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _animatedIndex = -1;
          selectedIndex = -1;
        });
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_otpDigits[3] != "") {
          code = _otpDigits[0] + _otpDigits[1] + _otpDigits[2] + _otpDigits[3];
          _verifyOtp();
          // Navigator.push(context, customPageRoute(const RootScreen()));
        }
      });
    }
  }

  void _removeLastNumber() {
    setState(() {
      int lastIndex = _otpDigits.lastIndexWhere((digit) => digit.isNotEmpty);
      if (lastIndex >= 0) {
        _otpDigits[lastIndex] = '';
        selectedIndex = 1;
      }
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  void _clearPassword() {
    setState(() {
      _otpDigits = List.generate(4, (_) => '');
      selectedIndex = 3;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  _verifyOtp() {
    print(code);
    BlocProvider.of<AuthBloc>(context)
        .add(VerifyOTPEvent("+251${widget.phoneNumber}", code));
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
    startTimeout();
  }

  _loadData() async {
    await AuthRepository().getUserData().then((value) {
      user = value;
    });
    widget.from == "signup"
        ? Navigator.pushReplacement(
            context, customPageRoute(const CreateOrganizationScreen()))
        : user?.firstName != null &&
                user?.firstName != "null" &&
                user?.firstName != ""
            ? Navigator.pushReplacement(
                context, customPageRoute(const RootScreen()))
            : Navigator.pushReplacement(
                context, customPageRoute(const CreateOrganizationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is VerifyOTPFailure) {
              SnackBarWidget.showSnackBar(context, state.errorMessage);
            }
            if (state is VerifyOTPSuccess) {
              _loadData();
            }
          },
          builder: (context, state) {
            print(state);
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeMargin),
              child: ListView(
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.4,
                  //       child: LinearPercentIndicator(
                  //         alignment: MainAxisAlignment.start,
                  //         animation: false,
                  //         lineHeight: 6.0,
                  //         animationDuration: 2500,
                  //         percent: 0.8,
                  //         progressColor: Colors.green,
                  //         barRadius: const Radius.circular(3),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          // padding: const EdgeInsets.all(5),
                          // height: 50,
                          // width: 50,
                          // alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: AppConstants.grey400),
                          //     borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppConstants.grey700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          timerText,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Please enter the verification code \nwe have sent you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < _otpDigits.length; i++)
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: _otpDigits[i] == ""
                                            ? Colors.white
                                            : AppConstants.primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                        border: _otpDigits[i] == ""
                                            ? Border.all(
                                                color:
                                                    AppConstants.primaryColor,
                                                width: 2)
                                            : null),
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                            scale: animation, child: child);
                                      },
                                      child: Text(
                                        _otpDigits[i] == ""
                                            ? "0"
                                            : _otpDigits[i],
                                        key: ValueKey<String>(_otpDigits[i]),
                                        style: TextStyle(
                                          color: _otpDigits[i] == ""
                                              ? Colors.grey
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 100.0),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 0.0,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 16.0, 16.0, 10.0),
                                child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                  onNotification: (notification) {
                                    notification.disallowIndicator();
                                    return true;
                                  },
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 3,
                                      padding: EdgeInsets.zero,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      childAspectRatio: 2,
                                      children: List.generate(
                                        9,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            _addNumberToOtp(
                                                (index + 1).toString());
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              color: _animatedIndex == index
                                                  ? Colors.grey
                                                  : Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                                style: const TextStyle(
                                                  fontSize: 24.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0, 16.0, 16.0),
                                child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                  onNotification: (notification) {
                                    notification.disallowIndicator();
                                    return true;
                                  },
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    padding: EdgeInsets.zero,
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    childAspectRatio: 2,
                                    children: [
                                      Container(),
                                      // GestureDetector(
                                      //   onTap: _removeLastNumber,
                                      //   child: AnimatedContainer(
                                      //       duration:
                                      //           const Duration(milliseconds: 500),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius:
                                      //             BorderRadius.circular(50.0),
                                      //         color: selectedIndex == 1
                                      //             ? Colors.grey
                                      //             : Colors.white,
                                      //       ),
                                      //       child: const Icon(Icons.backspace)),
                                      // ),
                                      GestureDetector(
                                        onTap: () => _addNumberToOtp('0'),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: selectedIndex == 0
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _clearPassword,
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              color: selectedIndex == 3
                                                  ? Colors.grey
                                                  : Colors.white,
                                            ),
                                            child: const Icon(
                                                Icons.backspace_outlined)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Send again",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !resendCode
                                      ? AppConstants.primaryColor
                                          .withOpacity(.5)
                                      : AppConstants.primaryColor),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
