import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class GeneralSettingsScreen extends StatefulWidget {
  final bool isPersonal;
  const GeneralSettingsScreen({super.key, required this.isPersonal});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  _logout() {
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.smallMargin,
              vertical: AppConstants.largeMargin),
          child: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  const SizedBox(
                      // height: 15,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppConstants.grey700,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const CustomText(
                        title: "General Settings",
                        fontSize: AppConstants.xxLarge,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  // const CustomText(
                  //   title: "Data privacy",
                  //   textColor: Colors.black,
                  //   fontSize: AppConstants.large,
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppConstants.grey200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                customPageRoute(const PrivacySecurityScreen()));
                          },
                          child: actionContainer(
                              AppAssets.privacy,
                              "Privacy and Security",
                              widget.isPersonal ? false : true),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  customPageRoute(const DataStorageScreen()));
                            },
                            child: actionContainer(
                                AppAssets.dataStorage, "Data Storage", false)),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, customPageRoute(DevicesScreen()));
                            },
                            child: actionContainer(
                                AppAssets.manage, "Manage devices", true)),
                        const SizedBox(
                          height: 10,
                        ),
                        actionContainer(
                            AppAssets.appreance, "Appearance", true),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                customPageRoute(
                                    const NotificationsAndSoundsScreen()));
                          },
                          child: actionContainer(AppAssets.notificationGreen,
                              "Notification and sound", true),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.isPersonal
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      customPageRoute(
                                          const SuiteAdminScreen()));
                                },
                                child: actionContainer(
                                    AppAssets.admin, "Administrators", true)),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppConstants.grey200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        actionContainerWithIcon(Icons.message_outlined,
                            Colors.deepPurple, "Ask a Question", ""),
                        const SizedBox(
                          height: 10,
                        ),
                        actionContainerWithIcon(Icons.question_mark_sharp,
                            Colors.red, "DH FAQ", ""),
                        const SizedBox(
                          height: 10,
                        ),
                        actionContainerWithIcon(Icons.lightbulb_outline,
                            Colors.amber, "DH Features", ""),
                      ],
                    ),
                  )
                ]),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LogoutFailure) {
                    SnackBarWidget.showSnackBar(context, state.errorMessage);
                  }
                  if (state is LogoutSuccess) {
                    gotoSignIn(context);
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      if (widget.isPersonal) {
                        gotoSignIn(context);
                        _logout();
                      } else {
                        const secureStorage = FlutterSecureStorage();
                        await secureStorage.write(key: "orgId", value: null);
                        Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            customPageRoute(const RootScreen()),
                            (route) => false);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: widget.isPersonal
                              ? "Log out from account"
                              : "Log out from organization",
                          fontSize: AppConstants.mediumMargin,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.red,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container actionContainer(String asset, String title, bool active) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: AppConstants.grey300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              height: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            CustomText(
                title: title,
                textColor: active ? Colors.black : AppConstants.grey500,
                fontWeight: active ? FontWeight.normal : FontWeight.w500,
                fontSize: AppConstants.medium),
          ],
        ));
  }

  Container actionContainerWithIcon(
      IconData icon, color, String title, String suffix) {
    return Container(
        margin: const EdgeInsets.only(top: 0),
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
