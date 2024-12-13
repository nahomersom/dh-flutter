import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dh_flutter_v2/bloc/organization/organization_bloc.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:dh_flutter_v2/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agree = false;
  TextEditingController nameController = TextEditingController();
  int? industry;
  int? region;
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  List industries = [];
  List regions = [];
  List<String> industryName = [];
  List<String> regionsName = [];

  _createOrganization() {
    BlocProvider.of<OrganizationBloc>(context)
        .add(CreateOrganizationEvent(nameController.text, industry!, region!));
  }

  _getMyOrganizations() {
    BlocProvider.of<OrganizationBloc>(context).add(GetMyOrganizationsEvent());
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    _getData();
    super.initState();
  }

  _getData() async {
    BlocProvider.of<OrganizationBloc>(context).add(GetIndustriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
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
              //         percent: 0.9,
              //         progressColor: Colors.green,
              //         barRadius: const Radius.circular(3),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
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
                  const CustomText(
                    title: "Sign Up",
                    textColor: AppConstants.primaryColor,
                    fontSize: AppConstants.xxLarge,
                  ),
                  Container(
                    width: 60,
                  )
                ],
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: isSubmitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const CustomText(
                        title: "Create your organization",
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxxLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur",
                        style: TextStyle(
                          color: AppConstants.grey600,
                          fontSize: AppConstants.medium,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        title: "Your Organization",
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppConstants.primaryColorVeryLight,
                                    borderRadius: BorderRadius.circular(15),
                                    // image: DecorationImage(
                                    //   image: AssetImage(AppAssets.logo),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  child: const CustomText(
                                    title: "LOGO",
                                    fontSize: AppConstants.xLarge,
                                  )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    height: 34,
                                    width: 34,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        shape: BoxShape.circle,
                                        color: AppConstants.primaryColor),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          isRequired: false,
                          hintText: "DH",
                          controller: nameController,
                          name: "Organization name",
                          validator: (value) => InputValidator()
                              .isValidField(value!, "Organization name")),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Industry",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppConstants.grey500,
                        ),
                      ),
                      selectIndustry("Tech", industry, industryName),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Region",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppConstants.grey500,
                        ),
                      ),
                      selectJob("Select", region, regionsName),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Checkbox(
                                  activeColor: AppConstants.primaryColor,
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value!;
                                    });
                                  },
                                ),
                                // const Text(""),
                              ],
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: const Text(
                                  "I confirm that I have read the terms and conditions and agree to the privacy policy of Communicate.",
                                  style: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: AppConstants.grey600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppConstants.small),
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 25,
                      ),
                      BlocConsumer<OrganizationBloc, OrganizationState>(
                        listener: (context, state) {
                          if (state is GetIndustriesFailure) {
                            SnackBarWidget.showSnackBar(
                                context, state.errorMessage);
                          }
                          if (state is GetIndustriesSuccess) {
                            regions = state.regions;
                            industries = state.industries;
                            for (var region in state.regions) {
                              regionsName.add(region["name"]);
                            }
                            for (var industrie in state.industries) {
                              industryName.add(industrie["name"]);
                            }
                            setState(() {});
                          }
                          if (state is CreateOrganizationFailure) {
                            SnackBarWidget.showSnackBar(
                                context, state.errorMessage);
                          }
                          if (state is CreateOrganizationSuccess) {
                            _getMyOrganizations();
                            Navigator.pop(context);
                            SnackBarWidget.showSuccessSnackBar(
                                context, "Organization created successfully.");
                          }
                        },
                        builder: (context, state) {
                          logger("$industries $regions", {});
                          return !agree
                              ? CustomButton(
                                  isLoading: state is CreateOrganizationLoading,
                                  title: "Create Organization",
                                  backgroundColor: AppConstants.grey500,
                                  onPressed: () {})
                              : CustomButton(
                                  isLoading: state is CreateOrganizationLoading,
                                  loadingText: "Creating...",
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      isSubmitted = true;
                                    });
                                    print(industry);
                                    if (_formKey.currentState!.validate()) {
                                      _createOrganization();
                                      // Navigator.pop(context);
                                      // Navigator.push(
                                      //     context, customPageRoute(const RootScreen()));
                                    }
                                  },
                                  title: "Create Organization");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomDropdown selectJob(String hint, int? value, List<String> items) {
    return CustomDropdown<String>(
      onChanged: (value) {
        FocusScope.of(context).unfocus();

        for (var reg in regions) {
          if (reg["name"] == value) {
            region = reg["id"];
          }
        }
      },
      validateOnChange: true,
      validator: (val) {
        if (val == "") {
          return "Select $hint";
        }
        return null;
      },
      hintText: hint,
      decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: AppConstants.grey300),
          closedFillColor: AppConstants.backgroundColor,
          hintStyle: const TextStyle(
            color: AppConstants.grey700,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.medium,
          ),
          closedSuffixIcon: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: AppConstants.primaryColorVeryLight,
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppConstants.grey600,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.small,
          ),
          closedErrorBorder: Border.all(color: Colors.red)),
      items: items,
    );
  }

  CustomDropdown selectIndustry(String hint, int? value, List<String> items) {
    return CustomDropdown<String>(
      onChanged: (value) {
        FocusScope.of(context).unfocus();
        print('@@@@@@@@@@@@@@@');
        for (var ind in industries) {
          if (ind["name"].toString().toLowerCase() == value?.toLowerCase()) {
            industry = ind["id"];
          }
        }
      },
      validateOnChange: true,
      validator: (val) {
        if (val == "") {
          return "Select $hint";
        }
        return null;
      },
      hintText: hint,
      decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: AppConstants.grey300),
          closedFillColor: AppConstants.backgroundColor,
          hintStyle: const TextStyle(
            color: AppConstants.grey700,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.medium,
          ),
          closedSuffixIcon: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: AppConstants.primaryColorVeryLight,
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppConstants.grey600,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.small,
          ),
          closedErrorBorder: Border.all(color: Colors.red)),
      items: items,
    );
  }
}
