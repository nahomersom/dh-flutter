import 'package:country_picker_pro/country_picker_pro.dart';
import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class PhoneEmailVerification extends StatefulWidget {
  final bool newUser;
  const PhoneEmailVerification({super.key, required this.newUser});

  @override
  State<PhoneEmailVerification> createState() => _PhoneEmailVerificationState();
}

class _PhoneEmailVerificationState extends State<PhoneEmailVerification> {
  String selectedCountry = "🇪🇹     Ethiopia";
  TextEditingController countryCode = TextEditingController(text: "+251");
  TextEditingController phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;

  @override
  void initState() {
    print("######################");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  _sendOtp() {
    print("************************************");
    BlocProvider.of<AuthBloc>(context)
        .add(SendOTPEvent("+251${phonenumberController.text}"));
  }

  _checkPhoneNumber() {
    print("###################### *signup");
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.black,
          ),
        ),
        title: const CustomText(
          title: "Sign Up",
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
                // const SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Icon(
                //       Icons.arrow_back_ios_new,
                //       color: AppConstants.primaryColor,
                //     ),
                //     const CustomText(
                //       title: "Sign Up",
                //       textColor: AppConstants.primaryColor,
                //       fontSize: AppConstants.xxLarge,
                //     ),
                //     Container(
                //       width: 20,
                //     )
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
                          if (state is CheckPhoneNumberFailure) {}
                          if (state is CheckPhoneNumberSuccess) {
                            if (widget.newUser) {
                              if (state.doesExist) {
                                SnackBarWidget.showSnackBar(context,
                                    "User already exists with this phone number.");
                              } else {
                                _sendOtp();
                              }
                            }
                            print("######################${state.doesExist}");
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
                                    from: "signup")));
                          }
                        },
                        builder: (context, state) {
                          print("######################$state");
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
                              title: "Sign Up");
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
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
}
