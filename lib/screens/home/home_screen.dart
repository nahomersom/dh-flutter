import 'package:dh/bloc/chat_bloc/chat_bloc.dart';
import 'package:dh/bloc/groups/groups_bloc.dart';
import 'package:dh/model/group_model.dart';
import 'package:dh/model/models.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/routes/custom_page_route.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/utils/helper.dart';
import 'package:dh/utils/tools.dart';
import 'package:dh/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  int? orgId;
  List<Group> groups = [];
  List<User> myChats = [];
  List<Map<String, dynamic>> items = [
    {
      'name': 'My',
      'pinned': true,
      'isGroup': false,
    },
    {
      'name': 'Tech',
      'pinned': false,
      'isGroup': false,
    },
    {
      'name': 'Stuff',
      'pinned': false,
      'isGroup': false,
    },
  ];
  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  _loadProfile() async {
    var auth = AuthRepository();
    var token = await auth.getToken();
    logger("$token", {});

    await auth.getUserData().then((value) => {
          user = value,
          if (user!.orgId != null)
            {
              orgId = int.parse(user!.orgId!),
              // _getOrgGroups(int.parse(user!.orgId!))
              _getMyGroups()
            }
        });
    _getMyPersonalChats();
  }

  // _getOrgGroups(int orgId) {
  //   BlocProvider.of<GroupsBloc>(context)
  //       .add(GetOrganizationGroups(orgId: orgId));
  // }
  _getMyGroups() {
    BlocProvider.of<GroupsBloc>(context).add(GetMyGroups());
  }

  _getMyPersonalChats() {
    BlocProvider.of<ChatBloc>(context).add(const GetMyPrivateChatsEvent());
  }
  // _createGroup(int orgId, String name, String color) {
  //   BlocProvider.of<GroupsBloc>(context)
  //       .add(CreateGroup(orgId: orgId, name: name, color: color));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, customPageRoute(const NotificationScreen()));
          },
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.small),
              child: Icon(
                Icons.notifications_outlined,
                color: AppConstants.grey600,
                size: 32,
              )
              //  SvgPicture.asset(AppAssets.notificationGreen,
              //     height: 25,
              //     colorFilter: const ColorFilter.mode(
              //       AppConstants.grey700,
              //       BlendMode.srcATop,
              //     )),
              ),
        ),
        actions: orgId != null && orgId != ""
            ? [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, customPageRoute(MemberScreen(orgId: orgId!)));
                    // _createGroupBottomSheet(context, orgId ?? 0);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppConstants.primaryColorVeryLight,
                        ),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.add,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                )
              ]
            : null,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, chatState) {
          if (chatState is GetMyPrivateChatsError) {
            SnackBarWidget.showSnackBar(context, chatState.errorMessage);
          }
        },
        builder: (context, chatState) {
          if (chatState is GetMyPrivateChatsSuccess) {
            myChats = chatState.peopleChatWithme;
          }
          return BlocConsumer<GroupsBloc, GroupsState>(
            listener: (context, groupState) {
              if (groupState is CreateGroupError) {
                Navigator.pop(context);
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is CreateGroupSuccess) {
                Navigator.pop(context);
                SnackBarWidget.showSuccessSnackBar(
                    context, "Group added to orginization successfully");
                // _getOrgGroups(orgId!);
                _getMyGroups();
              }
              if (groupState is GetOrganizationGroupsError) {
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is GetOrganizationGroupsSuccess) {
                groups = groupState.groups;
                setState(() {});
              }
              if (groupState is GetMyGroupsError) {
                SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              }
              if (groupState is GetMyGroupsSuccess) {
                groups = [];
                for (Group group in groupState.groups) {
                  if (group.orgId == orgId) {
                    if (!groups.contains(group)) {
                      groups.add(group);
                    }
                  }
                }
                setState(() {});
              }
            },
            builder: (context, groupState) {
              logger("$groupState", {});
              return Container(
                margin: const EdgeInsets.all(
                  AppConstants.mediumMargin,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, customPageRoute(const SearchWithFilter()));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppConstants.grey500),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SvgPicture.asset(AppAssets.search,
                                  height: 30,
                                  colorFilter: const ColorFilter.mode(
                                    AppConstants.iconColor,
                                    BlendMode.srcATop,
                                  )),
                            ),
                            const Text(
                              "Search",
                              style: TextStyle(
                                  color: AppConstants.grey500,
                                  fontSize: AppConstants.large,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.mediumMargin,
                          vertical: AppConstants.medium),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8F6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Join/Create an Organization",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConstants.xxLarge),
                              ),
                              Icon(
                                Icons.close,
                                size: 20,
                                color: AppConstants.iconColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Get members onboard and communicate\ntogether.",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: AppConstants.medium,
                                color: AppConstants.grey500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 80,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppConstants.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text(
                              "Invite",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppConstants.medium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: myChats.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    customPageRoute(MessageDetailSreen(
                                      groupId: myChats[index].id!,
                                      isGroup: true,
                                      reciverId: null,
                                    )));
                              },
                              child: messagesCard(context, myChats[index]),
                            );
                          }),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 40, 219, 106),
        onPressed: () {
          Navigator.push(context, customPageRoute(ContactsScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Stack messagesCard(BuildContext context, User user) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
          decoration: BoxDecoration(
            color:
                false ? const Color.fromARGB(255, 241, 250, 253) : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          height: 80,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: group.color != null && group.color != ""
                  //     ? getColorFromMaterialColorString(group.color!)
                  //     : AppConstants.primaryColor,
                ),
                child: Text(
                  user.firstName != ""
                      ? user.firstName?.substring(0, 1).toUpperCase() ?? ""
                      : "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.xxxLarge),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .66,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              toCamelCase(user.firstName ?? ""),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: AppConstants.large,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            false
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppConstants.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text(
                                      "All staff",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppConstants.medium),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        const Text(
                          "23 min",
                          style: TextStyle(
                              color: AppConstants.grey400,
                              fontSize: AppConstants.small,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Meeting.pdf",
                    style: TextStyle(
                        color: AppConstants.grey600,
                        fontSize: AppConstants.medium),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            right: 15,
            child: false
                ? SvgPicture.asset(AppAssets.pin,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppConstants.iconColor,
                      BlendMode.srcATop,
                    ))
                : false
                    ? Container(
                        // padding: const EdgeInsets.all(5),
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppConstants.primaryColor,
                            shape: BoxShape.circle),
                        child: const Text("1",
                            style: TextStyle(
                                color: AppConstants.white,
                                fontSize: AppConstants.xSmall,
                                fontWeight: FontWeight.bold)),
                      )
                    : Container()),
      ],
    );
  }
}
