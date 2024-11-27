import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/bloc/groups/groups_bloc.dart';
import 'package:dh/bloc/organization/organization_bloc.dart';
import 'package:dh/model/models.dart';
import 'package:dh/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class AddExternalContactScreen extends StatefulWidget {
  final int? orgId;
  final int? groupId;
  const AddExternalContactScreen(
      {super.key, required this.orgId, required this.groupId});

  @override
  State<AddExternalContactScreen> createState() =>
      _AddExternalContactScreenState();
}

class _AddExternalContactScreenState extends State<AddExternalContactScreen> {
  TextEditingController searchController = TextEditingController();
  List<User> users = [];
  List<MemberDetails> memberDetails = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      users = [];
    });
    widget.orgId != null ? _getAllOrganizationMembers() : null;
  }

  _searchUsers() {
    BlocProvider.of<AuthBloc>(context)
        .add(SearchUserEvent(searchController.text));
  }

  _getAllOrganizationMembers() {
    BlocProvider.of<OrganizationBloc>(context)
        .add(GetAllOrganizationMembersEvent(orgId: widget.orgId!));
  }

  _addMember(int memberId) {
    BlocProvider.of<OrganizationBloc>(context).add(AddMemberEvent(
        orgId: widget.orgId!, memberId: memberId, role: "Member"));
  }

  _addGroupMember(int memberId) {
    BlocProvider.of<GroupsBloc>(context).add(AddOrgMemberToGroup(
      groupId: widget.groupId!,
      memberId: memberId,
    ));
  }

  Future<void> _askLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, proceed with your app logic
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, direct the user to the app settings
      await openAppSettings();
    }
  }

  Future<void> _askPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      // Permissions granted, proceed with your app logic
    } else if (cameraStatus.isDenied || microphoneStatus.isDenied) {
      // Permission denied, show a message to the user
    } else if (cameraStatus.isPermanentlyDenied ||
        microphoneStatus.isPermanentlyDenied) {
      // Permission permanently denied, direct the user to the app settings
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          margin:
              const EdgeInsets.symmetric(vertical: AppConstants.mediumMargin),
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.largeMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.grey700,
                    ),
                  ),
                  const CustomText(
                    title: "Add External Contact",
                    fontSize: AppConstants.xLarge,
                    textColor: AppConstants.black,
                  ),
                  Container(
                    width: 30,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      _searchUsers();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      _searchUsers();
                    },
                    onTapOutside: (val) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(AppAssets.search,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.iconColor,
                              BlendMode.srcATop,
                            )),
                      ),
                      hintText: "Contacts, departments",
                      hintStyle: const TextStyle(
                        color: AppConstants.grey400,
                        fontWeight: FontWeight.normal,
                        fontSize: AppConstants.large,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: AppConstants.grey300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: AppConstants.primaryColor),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                            height: 450,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppConstants.largeMargin,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .2),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 55,
                                        width: 55,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.primaryColor,
                                        ),
                                        child: const Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppConstants.xxxLarge),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "DH UX/UI",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: AppConstants.large,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "DH",
                                            style: TextStyle(
                                                color: AppConstants.grey500,
                                                fontSize: AppConstants.medium,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppConstants.grey500,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .23),
                                  child: PrettyQrView.data(
                                    data: 'lorem ipsum dolor sit amet',
                                    decoration: const PrettyQrDecoration(
                                      image: PrettyQrDecorationImage(
                                        image: AssetImage('images/flutter.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .2),
                                  child: const Text(
                                    "Scan the QR code to add me to your contact",
                                    style: TextStyle(
                                        color: AppConstants.grey600,
                                        fontSize: AppConstants.medium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ));
                      });
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    title: "My QR code",
                    textColor: AppConstants.black,
                    fontSize: AppConstants.large,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset(
                    AppAssets.qr,
                    height: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeMargin,
                  vertical: AppConstants.mediumMargin),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _askLocationPermission();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.nearby,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "Join nearby group",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      _askPermissions();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.qr,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "Scan QR Code",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, userSate) {
                      if (userSate is SearchUserFailure) {
                        SnackBarWidget.showSnackBar(
                            context, userSate.errorMessage);
                      }
                      if (userSate is SearchUserSuccess) {
                        users = [];
                        for (var user in userSate.users) {
                          // Check if the user.id exists in any of the MemberDetails
                          bool userExistsInMemberDetails = memberDetails.any(
                              (memberDetail) =>
                                  memberDetail.memberId == user.id);

                          // If the user does not exist in any MemberDetails, add them to the 'users' list
                          if (!userExistsInMemberDetails &&
                              !users.contains(user)) {
                            users.add(user);
                          }
                        }
                      }
                      setState(() {});
                    },
                    builder: (context, userSate) {
                      return BlocConsumer<GroupsBloc, GroupsState>(
                        listener: (context, groupState) {},
                        builder: (context, groupState) {
                          return BlocConsumer<OrganizationBloc,
                              OrganizationState>(
                            listener: (context, state) {
                              if (state is AddMemberFailure) {
                                SnackBarWidget.showSnackBar(
                                    context, state.errorMessage);
                              }
                              if (groupState is AddOrgMemberToGroupError) {
                                SnackBarWidget.showSnackBar(
                                    context, groupState.errorMessage);
                              }
                              if (state is GetAllOrganizationMembersFailure) {
                                SnackBarWidget.showSnackBar(
                                    context, state.errorMessage);
                              }
                              if (state is AddMemberSuccess) {
                                SnackBarWidget.showSuccessSnackBar(context,
                                    "Member added to organization successfully");
                                _getAllOrganizationMembers();
                              }
                              if (groupState is AddOrgMemberToGroupSuccess) {
                                SnackBarWidget.showSuccessSnackBar(
                                    context, "Member added successfully");
                                // _getAllOrganizationMembers();
                              }
                            },
                            builder: (context, state) {
                              if (state is GetAllOrganizationMembersSuccess) {
                                memberDetails = state.members;
                              }
                              return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: users.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 10),
                                          margin: const EdgeInsets.only(
                                              top: 0, bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 0,
                                                blurRadius: 0,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppConstants
                                                          .primaryColor,
                                                    ),
                                                    child: Text(
                                                      users[index]
                                                              .firstName
                                                              ?.substring(0, 1)
                                                              .toUpperCase() ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: AppConstants
                                                              .large),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        toCamelCase(
                                                            '${users[index].firstName} ${users[index].lastName}'),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                AppConstants
                                                                    .medium,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "User ID: @${users[index].userName}",
                                                        style: const TextStyle(
                                                            color: AppConstants
                                                                .grey600,
                                                            fontSize:
                                                                AppConstants
                                                                    .small),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  widget.orgId != null
                                                      ? _addMember(
                                                          users[index].id!)
                                                      : _addGroupMember(
                                                          users[index].id!);
                                                },
                                                icon: const Icon(
                                                    Icons.add_circle),
                                                color:
                                                    AppConstants.primaryColor,
                                              )
                                            ],
                                          ),
                                        );
                                      }));
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
