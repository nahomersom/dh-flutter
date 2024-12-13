import 'package:country_picker_pro/country_picker_pro.dart';
import 'package:dh_flutter_v2/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/screens/auth/otp_screen.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  final bool newUser;
  const SignInScreen({super.key, required this.newUser});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String selectedCountry = "🇪🇹     Ethiopia";
  TextEditingController countryCode = TextEditingController(text: "+251");
  TextEditingController phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    // isSignin = true;
    super.initState();
  }

  _sendOtp() {
    BlocProvider.of<AuthBloc>(context)
        .add(SendOTPEvent("+251${phonenumberController.text}"));
  }

  _checkPhoneNumber() {
    BlocProvider.of<AuthBloc>(context)
        .add(CheckPhoneNumberEvent("+251${phonenumberController.text}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const CustomText(
          title: "Sign In",
          textColor: AppConstants.primaryColor,
          fontSize: AppConstants.xxLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Form(
            key: _formKey,
            autovalidateMode: isSubmitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                const SizedBox(
                    // height: 30,
                    ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // Container(
                //     //   padding: const EdgeInsets.all(5),
                //     //   height: 50,
                //     //   width: 50,
                //     //   alignment: Alignment.center,
                //     //   decoration: BoxDecoration(
                //     //       border: Border.all(color: AppConstants.grey400),
                //     //       borderRadius: BorderRadius.circular(15)),
                //     //   child: const Icon(
                //     //     Icons.arrow_back_ios_new,
                //     //     color: AppConstants.primaryColor,
                //     //   ),
                //     // ),
                //     CustomText(
                //       title: "Sign In",
                //       textColor: AppConstants.primaryColor,
                //       fontSize: AppConstants.xxLarge,
                //     ),
                //   ],
                // ),
                Expanded(
                  child: ListView(
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * .1,
                      // ),
                      const CustomText(
                        title: "Enter Phone Number",
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxxLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Please enter your valid phone number. We will send you a 4-digit code to verify your account. ",
                        style: TextStyle(
                          color: AppConstants.grey600,
                          fontSize: AppConstants.medium,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          CountrySelector(
                              context: context,
                              viewType: ViewType.screen,
                              countryPreferred: <String>['US'],
                              appBarTitle: "Select Country",
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountry =
                                      '${country.flagEmojiText}     ${country.name}';
                                  countryCode.text =
                                      country.callingCode.toString();
                                });
                              },
                              listType: ListType.list,
                              appBarBackgroundColour: Colors.white,
                              appBarFontSize: 20,
                              appBarFontStyle: FontStyle.normal,
                              appBarFontWeight: FontWeight.bold,
                              appBarTextColour: Colors.black,
                              appBarTextCenterAlign: true,
                              backgroundColour: Colors.white,
                              backIcon: Icons.arrow_back_ios,
                              backIconColour: Colors.black,
                              countryFontStyle: FontStyle.normal,
                              countryFontWeight: FontWeight.bold,
                              countryTextColour: Colors.black,
                              countryTitleSize: 16,
                              dividerColour: Colors.black12,
                              searchBarAutofocus: true,
                              searchBarIcon: Icons.search,
                              searchBarBackgroundColor: Colors.white,
                              searchBarBorderColor: AppConstants.grey500,
                              searchBarBorderWidth: 2,
                              searchBarOuterBackgroundColor: Colors.white,
                              searchBarTextColor: Colors.black,
                              searchBarHintColor: Colors.black,
                              countryTheme: const CountryThemeData(
                                appBarBorderRadius: 10,
                              ),
                              alphabetScrollEnabledWidget: true,
                              showSearchBox: true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppConstants.grey500,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Text(
                                selectedCountry,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: AppConstants.medium,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phonenumberController,
                        keyboardType: TextInputType.phone,
                        maxLength: 9,
                        onTap: () {},
                        style: const TextStyle(
                          color: AppConstants.grey700,
                          fontSize: AppConstants.medium,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: '000 000 000',
                          labelStyle: const TextStyle(
                            color: AppConstants.grey500,
                            fontSize: AppConstants.medium,
                          ),
                          prefixIcon: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text(
                                countryCode.text,
                                style: const TextStyle(
                                  color: AppConstants.black,
                                  fontSize: AppConstants.medium,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppConstants.grey200),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onChanged: (phone) {},
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isSubmitted = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            _checkPhoneNumber();
                          }
                        },
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return "Please Enter Phone Number";
                          }
                          if (phone.length < 9) {
                            return "Phone Number length must be 9";
                          }
                          if (!(phone.startsWith('9') ||
                              phone.startsWith('7'))) {
                            return "Phone number can only start with 9 or 7";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
                            return 'Please remove any special characters';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // IntlPhoneField(
                      //   controller: countryCode,
                      //   decoration: InputDecoration(
                      //     counterText: "",
                      //     labelText: '331 623 8413',
                      //     labelStyle:
                      //         const TextStyle(color: AppConstants.grey700),
                      //     border: OutlineInputBorder(
                      //         borderSide:
                      //             const BorderSide(color: AppConstants.grey200),
                      //         borderRadius: BorderRadius.circular(15)),
                      //   ),
                      //   initialCountryCode: 'US',
                      //   onChanged: (phone) {},
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is CheckPhoneNumberFailure) {
                            SnackBarWidget.showSnackBar(
                                context, state.errorMessage);
                          }
                          if (state is CheckPhoneNumberSuccess) {
                            if (widget.newUser) {
                            } else {
                              // if (state.doesExist) {
                              _sendOtp();
                              print("00000000000000000000000000000000 ");
                              // } else {
                              //   SnackBarWidget.showSnackBar(context,
                              //       "User does not exists with this phone number.");
                              // }
                            }
                          }
                          if (state is SendOTPFailure) {
                            SnackBarWidget.showSnackBar(
                                context, state.errorMessage);
                          }
                          if (state is SendOTPSuccess) {
                            SnackBarWidget.showSuccessSnackBar(
                                context, "Code successfully sent!");
                            Navigator.push(
                                context,
                                customPageRoute(OtpScreen(
                                  phoneNumber: phonenumberController.text,
                                  from: "login",
                                )));
                          }
                        },
                        builder: (context, state) {
                          logger("$state", {});
                          if (state is SendOTPLoading ||
                              state is CheckPhoneNumberLoading) {
                            return CustomButton(
                                backgroundColor: AppConstants.grey500,
                                loadingText: "Sending code ...",
                                isLoading: true,
                                onPressed: () {},
                                title: "Sign In");
                          }
                          return CustomButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isSubmitted = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  _checkPhoneNumber();
                                }
                              },
                              title: "Sign In");
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Don’t have an account?",
                      //       style: TextStyle(
                      //         color: AppConstants.grey500,
                      //         fontSize: AppConstants.large,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             customPageRoute(const PhoneEmailVerification(
                      //               newUser: true,
                      //             )));
                      //       },
                      //       child: const CustomText(
                      //         title: " Sign Up",
                      //         textColor: AppConstants.primaryColor,
                      //         fontSize: AppConstants.large,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * .18,
                            decoration: const BoxDecoration(
                              color: AppConstants.grey300,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Or Sign In with",
                              style: TextStyle(
                                color: AppConstants.grey500,
                                fontSize: AppConstants.medium,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * .18,
                            decoration: const BoxDecoration(
                              color: AppConstants.grey300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          roundedIcons(AppAssets.google),
                          const SizedBox(
                            width: 25,
                          ),
                          roundedIcons(AppAssets.apple),
                          const SizedBox(
                            width: 25,
                          ),
                          roundedIcons(AppAssets.outlook),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container roundedIcons(String path) {
    return Container(
      height: 48,
      width: 48,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppConstants.primaryColorVeryLight),
      child: SvgPicture.asset(
        path,
        height: 30,
      ),
    );
  }
}
