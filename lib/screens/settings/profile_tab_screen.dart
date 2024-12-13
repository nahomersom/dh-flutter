// ignore_for_file: deprecated_member_use

import 'package:dh_flutter_v2/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh_flutter_v2/bloc/organization/organization_bloc.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:dh_flutter_v2/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/groups/groups_bloc.dart';
import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class ProfileTabScreen extends StatefulWidget {
  final bool isPersonal;
  const ProfileTabScreen({super.key, required this.isPersonal});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  User? user;
  List<Organization> myOrganizations = [];
  @override
  void initState() {
    _getMyProfile();
    _getMyOrganizations();

    _loadProfile();
    super.initState();
  }

  _loadProfile() async {
    var auth = AuthRepository();
    var token = await auth.getToken();
    logger("$token", {});
    await auth.getUserData().then((value) => {
          user = value,
        });
  }

  _getMyProfile() {
    BlocProvider.of<AuthBloc>(context).add(const GetMyProfileEvent());
  }

  _getMyOrganizations() {
    BlocProvider.of<OrganizationBloc>(context).add(GetMyOrganizationsEvent());
  }

  _getOrgGroups(int id) async {
    const secureStorage = FlutterSecureStorage();
    print("#########$id");
    BlocProvider.of<GroupsBloc>(context).add(GetOrganizationGroups(orgId: id));
    await secureStorage.write(key: "orgId", value: id.toString());
    await secureStorage.write(key: "orgName", value: id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: BlocConsumer<GroupsBloc, GroupsState>(
            listener: (context, groupState) {
              if (groupState is GetOrganizationGroupsError) {
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is GetOrganizationGroupsSuccess) {
                SnackBarWidget.showSuccessSnackBar(
                    context, "Switched to organization");
              }
            },
            builder: (context, groupState) {
              logger(" $groupState", {});
              return BlocConsumer<OrganizationBloc, OrganizationState>(
                listener: (context, organizationState) {
                  if (organizationState is GetMyOrganizationsFailure) {
                    SnackBarWidget.showSnackBar(
                        context, organizationState.errorMessage);
                  }
                },
                builder: (context, organizationState) {
                  logger("my org $organizationState", {});
                  if (organizationState is GetMyOrganizationsSuccess) {
                    myOrganizations = organizationState.organizations;
                  }
                  return BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is GetMyProfileFailure) {
                        SnackBarWidget.showSnackBar(
                            context, state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetMyProfileSuccess) {
                        user = state.user;
                        logger("${state.user.firstName}", {});
                      }
                      return ListView(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  alignment: Alignment.center,
                                  decoration: widget.isPersonal &&
                                          user?.profileImage != null
                                      ? BoxDecoration(
                                          color: AppConstants
                                              .primaryColorVeryLight,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  user!.profileImage!),
                                              fit: BoxFit.cover))
                                      : const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.primaryColor),
                                  child: Text(
                                    widget.isPersonal &&
                                            user!.profileImage != null
                                        ? ''
                                        : "DH",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: AppConstants.xLarge),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: widget.isPersonal
                                          ? toCamelCase(
                                              '${user?.firstName} ${user?.lastName ?? ""}')
                                          : "DH GROUPS",
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConstants.large,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "User ID: @${user?.userName}",
                                      style: const TextStyle(
                                          fontSize: AppConstants.small),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    customPageRoute(GeneralSettingsScreen(
                                      isPersonal: user?.orgId == null ||
                                              user?.orgId == ""
                                          ? true
                                          : false,
                                    )));
                              },
                              child: SvgPicture.asset(AppAssets.setting,
                                  height: 22,
                                  colorFilter: const ColorFilter.mode(
                                    AppConstants.iconColor,
                                    BlendMode.srcATop,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: AppConstants.grey300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.userIcon,
                                    color: AppConstants.primaryColorLight,
                                    height: 25,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const CustomText(
                                    title: "Personal",
                                    textColor:
                                        // widget.isPersonal
                                        //     ?
                                        Colors.black,
                                    // : AppConstants.grey500,
                                    fontSize: AppConstants.medium,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text(
                                      "Organizations",
                                      style: TextStyle(
                                          fontSize: AppConstants.small,
                                          color: AppConstants.grey500),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: myOrganizations.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _getOrgGroups(
                                                myOrganizations[index].id!);

                                            // Navigator.push(
                                            //     context,
                                            //     customPageRoute(MemberScreen(
                                            //       orgId: myOrganizations[index].id!,
                                            //     )));
                                          },
                                          child: Container(
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.green),
                                                      child: Text(
                                                        myOrganizations[index]
                                                            .name!
                                                            .substring(0, 2)
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                AppConstants
                                                                    .medium),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    CustomText(
                                                      title: toCamelCase(
                                                          myOrganizations[index]
                                                              .name!),
                                                      textColor: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize:
                                                          AppConstants.medium,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              AppConstants
                                                                  .primaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Text("1",
                                                      style: TextStyle(
                                                          color: AppConstants
                                                              .white,
                                                          fontSize: AppConstants
                                                              .small,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  _showDialog(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      child: const CustomText(
                                        title: "Add Organization",
                                        textColor: AppConstants.primaryColor,
                                        fontSize: AppConstants.medium,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.add_circle,
                                      color: AppConstants.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                customPageRoute(
                                    const InvitationRequestScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 15, top: 15, bottom: 15),
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
                                    SvgPicture.asset(
                                      AppAssets.notificationGreen,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const CustomText(
                                        title: "Requests",
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: AppConstants.medium),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 15, top: 15, bottom: 15),
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
                                  SvgPicture.asset(
                                    AppAssets.saved,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const CustomText(
                                      title: "Saved",
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppConstants.medium),
                                ],
                              ),
                              widget.isPersonal
                                  ? Container()
                                  : const Icon(
                                      Icons.add_circle,
                                      color: AppConstants.primaryColor,
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const CustomText(
                          title: "Calls and Contacts",
                          textColor: Colors.black,
                          fontSize: AppConstants.large,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: AppConstants.mediumMargin,
                          //     vertical: AppConstants.smallMargin),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppConstants.grey300),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const CustomText(
                                //   title: "Group applications",
                                //   textColor: Colors.black,
                                //   fontSize: AppConstants.large,
                                // ),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            customPageRoute(
                                                const RecordingsScreen()));
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.record,
                                            height: 25,
                                            // colorFilter: const ColorFilter.mode(
                                            //   AppConstants.iconColor,
                                            //   BlendMode.srcATop,
                                            // )
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Recorded calls",
                                            style: TextStyle(
                                                color: AppConstants.grey500,
                                                fontSize: AppConstants.small),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            customPageRoute(
                                                const ContactsScreen()));
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.contact,
                                            height: 25,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Contacts",
                                            style: TextStyle(
                                                color: AppConstants.grey500,
                                                fontSize: AppConstants.small),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     customPageRoute(const ContactsScreen()));
                                      },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.recentCalls,
                                            height: 25,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Recent Calls",
                                            style: TextStyle(
                                                color: AppConstants.grey500,
                                                fontSize: AppConstants.small),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        // const CustomText(
                        //   title: "Data privacy",
                        //   textColor: Colors.black,
                        //   fontSize: AppConstants.large,
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // actionContainer(AppAssets.privacy, "Privacy and Security",
                        //     widget.isPersonal ? false : true),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // actionContainer(AppAssets.dataStorage, "Data Storage", false),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // actionContainer(AppAssets.manage, "Manage device", true),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // actionContainer(AppAssets.appreance, "Appearance", true),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // actionContainer(
                        //     AppAssets.notificationGreen, "Notification and sound", true),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context, customPageRoute(const SuiteAdminScreen()));
                        //     },
                        //     child:
                        //         actionContainer(AppAssets.admin, "Administrators", true)),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // const CustomText(
                        //   title: "Call and contact",
                        //   textColor: Colors.black,
                        //   fontSize: AppConstants.large,
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context, customPageRoute(const RecordingsScreen()));
                        //     },
                        //     child:
                        //         actionContainer(AppAssets.record, "Recorded call", true)),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context, customPageRoute(const ContactsScreen()));
                        //     },
                        //     child: actionContainer(AppAssets.contact, "Contacts", true)),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // actionContainer(AppAssets.recentCalls, "Recent calls", true),
                        // const SizedBox(
                        //   height: 35,
                        // ),

                        // const SizedBox(
                        //   height: 25,
                        // ),
                      ]);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        customPageRoute(const JoinOrganizationScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.people,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "Join Organization",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context, customPageRoute(const SignUpScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.newContact,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "Create Organization",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      },
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
}
