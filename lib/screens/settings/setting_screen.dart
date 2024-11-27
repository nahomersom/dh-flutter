import 'package:dh/bloc/groups/groups_bloc.dart';
import 'package:dh/model/group_model.dart';
import 'package:dh/model/models.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/routes/custom_page_route.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/utils/helper.dart';
import 'package:dh/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popup_menu/popup_menu.dart';

import '../../constants/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  final int groupId;
  const SettingScreen({super.key, required this.groupId});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  Group? group;
  User? user;
  int? orgId;
  @override
  void initState() {
    super.initState();
    menu = PopupMenu(
      config: const MenuConfig(
          lineColor: AppConstants.grey300,
          backgroundColor: Color.fromARGB(255, 238, 238, 238),
          itemWidth: 200,
          itemHeight: 50,
          type: MenuType.list),
      context: context,
      items: [
        MenuItem(
          title: 'Enable Auto Delete',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.timer_outlined, color: Colors.black),
        ),
        MenuItem(
          title: 'Clear Messages',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.clear, color: Colors.black),
        ),
        MenuItem(
          title: 'Leave Group',
          textStyle:
              const TextStyle(color: Colors.red, fontSize: AppConstants.medium),
          image: const Icon(Icons.logout, color: Colors.red),
        ),

        MenuItem(
          title: 'Delete Group',
          textStyle:
              const TextStyle(color: Colors.red, fontSize: AppConstants.medium),
          image: const Icon(Icons.cancel_outlined, color: Colors.red),
        ),
        // ],
      ],
      onClickMenu: onClickMenu,
      // maxColumn: 2,
    );
    _getGroupById(widget.groupId);
    _loadProfile();
  }

  _loadProfile() async {
    var auth = AuthRepository();
    var token = await auth.getToken();
    logger("$token", {});
    await auth.getUserData().then((value) => {
          user = value,
          if (user?.orgId != null)
            {
              orgId = int.parse(user!.orgId!),
              _getOrgGroups(int.parse(user!.orgId!))
            }
        });
  }

  _getOrgGroups(int orgId) {
    BlocProvider.of<GroupsBloc>(context)
        .add(GetOrganizationGroups(orgId: orgId));
  }

  void onClickMenu(MenuItemProvider item) {
    switch (item.menuTitle) {
      case 'Enable Auto Delete':
        print('Enable Auto Delete');
        break;
      case 'Clear Messages':
        print('Clear Messages');
        break;
      case 'Leave Group':
        print('Leave Group');
        break;
      case 'Delete Tasks':
        print('Delete Tasks');
        break;
      case 'Delete Group':
        _deleteGroupById(widget.groupId);
        break;
    }
  }

  _getGroupById(int id) {
    BlocProvider.of<GroupsBloc>(context).add(GetGroupById(id: id));
  }

  _deleteGroupById(int id) {
    BlocProvider.of<GroupsBloc>(context).add(DeleteGroup(id: id));
  }

  _updateGroup(int groupId, String name) {
    BlocProvider.of<GroupsBloc>(context)
        .add(UpdateGroup(groupId: groupId, name: name));
  }

  _removeMemberFromGroup(int groupId, int memberId) {
    BlocProvider.of<GroupsBloc>(context)
        .add(RemoveMemberFromOrgGroup(groupId: groupId, memberId: memberId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppConstants.grey700,
          ),
        ),
        title: const CustomText(
          title: "Settings",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
        child: BlocConsumer<GroupsBloc, GroupsState>(
          listener: (context, groupState) {
            if (groupState is RemoveMemberFromOrgGroupError) {
              SnackBarWidget.showSnackBar(context, groupState.errorMessage);
            }
            if (groupState is RemoveMemberFromOrgGroupSuccess) {
              SnackBarWidget.showSuccessSnackBar(
                  context, "Completed successfully.");
              _getGroupById(widget.groupId);
            }
            if (groupState is UpdateGroupError) {
              SnackBarWidget.showSnackBar(context, groupState.errorMessage);
              Navigator.pop(context);
            }
            if (groupState is UpdateGroupSuccess) {
              SnackBarWidget.showSuccessSnackBar(
                  context, "Group updated successfully.");
              _getGroupById(widget.groupId);
              Navigator.pop(context);
            }
            if (groupState is GetGroupByIdError) {
              SnackBarWidget.showSnackBar(context, groupState.errorMessage);
            }
            if (groupState is DeleteGroupError) {
              SnackBarWidget.showSnackBar(context, groupState.errorMessage);
            }
            if (groupState is DeleteGroupSuccess) {
              _getOrgGroups(orgId!);
              SnackBarWidget.showSuccessSnackBar(
                  context, "Group deleted successfully.");
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          builder: (context, groupState) {
            // logger("$groupState", {});
            if (groupState is GetGroupByIdSuccess) {
              group = groupState.group;
              logger("${group?.name}", {});
            }
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeMargin,
                  vertical: AppConstants.mediumMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: letterColors[
                                      group?.name?[0].toUpperCase()]),
                              child: Text(
                                group?.name?[0].toUpperCase() ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConstants.large),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              title: toCamelCase(group?.name ?? ""),
                              textColor: Colors.black,
                              fontSize: AppConstants.large,
                            ),
                            const Stack(
                              children: [
                                SizedBox(
                                  width: 47,
                                  height: 25,
                                ),
                                // Positioned(
                                //     top: 0,
                                //     right: 0,
                                //     child: Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 3, vertical: 2),
                                //       alignment: Alignment.center,
                                //       decoration: BoxDecoration(
                                //           color: AppConstants.primaryColor,
                                //           borderRadius: BorderRadius.circular(5)),
                                //       child: const Text(
                                //         "All staff",
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: AppConstants.xSmall),
                                //       ),
                                //     ))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              _updateGroupBottomSheet(context, group!);
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: AppConstants.primaryColor,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              title: "Members",
                              textColor: Colors.black,
                              fontSize: AppConstants.large,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  group?.orgGroupMembers?.length.toString() ??
                                      "0",
                                  style: const TextStyle(
                                      color: AppConstants.grey500),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        customPageRoute(GroupMembers(
                                          groupId: widget.groupId,
                                          orgId: orgId,
                                        )));
                                  },
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConstants.grey700,
                                    size: 18,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      group?.orgGroupMembers?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 45,
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.primaryColor),
                                      child: Text(
                                        group?.orgGroupMembers?[index].member
                                                ?.firstName?[0]
                                                .toUpperCase() ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppConstants.xLarge),
                                      ),
                                    );
                                  }),
                            ),
                            InkWell(
                              onTap: () {
                                orgId != null
                                    ? Navigator.push(
                                        context,
                                        customPageRoute(MemberScreen(
                                          groupId: widget.groupId,
                                          orgId: orgId,
                                        )))
                                    : Navigator.push(
                                        context,
                                        customPageRoute(
                                            AddExternalContactScreen(
                                          groupId: widget.groupId,
                                          orgId: orgId,
                                        )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 45,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppConstants.grey400)),
                                child: const Icon(Icons.add),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.grey300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildGridItem(AppAssets.call, "Call", Colors.red),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                customPageRoute(const VideoChatScreen()));
                          },
                          child: _buildGridItem(AppAssets.camera, "Video",
                              AppConstants.primaryColor),
                        ),
                        _buildGridItem(AppAssets.mute, "Mute",
                            AppConstants.primaryColorLight),
                        _buildGridItem(AppAssets.search, "Search", null),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.grey300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildGridItem(
                            AppAssets.tasks, "Tasks", AppConstants.iconColor),
                        _buildGridItem(
                            AppAssets.pin, "Pin", AppConstants.primaryColor),
                        _buildGridItem(AppAssets.calander, "Calendar", null),
                        InkWell(
                          key: btnKey,
                          onTap: () {
                            menu?.show(widgetKey: btnKey);
                          },
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppConstants.grey500,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.more_horiz,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "More",
                                style: TextStyle(
                                    color: AppConstants.grey500,
                                    fontSize: AppConstants.small),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TabBar(
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: false,
                      indicatorColor: AppConstants.primaryColor,
                      labelPadding: EdgeInsets.symmetric(horizontal: 0),
                      labelStyle: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          child: Text("Media"),
                        ),
                        Tab(
                          child: Text("Files"),
                        ),
                        Tab(
                          child: Text("Voice"),
                        ),
                        Tab(
                          child: Text("Links"),
                        )
                      ])
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          _removeMemberFromGroup(widget.groupId, user!.id!);
        },
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Leave group",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: AppConstants.medium,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String asset, String label, Color? color) {
    return Column(
      children: [
        SvgPicture.asset(
          asset,
          height: 25,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.srcATop) : null,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppConstants.grey500,
            fontSize: AppConstants.small,
          ),
        ),
      ],
    );
  }

  _updateGroupBottomSheet(BuildContext cxt, Group group) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController =
        TextEditingController(text: group.name);
    bool submitted = false;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                height: isKeyboardVisible
                    ? MediaQuery.of(context).size.height * .8
                    : 500,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.largeMargin, vertical: 30),
                child: Form(
                  key: formKey,
                  autovalidateMode: submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Update Organization Group",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.xxLarge),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                                isRequired: false,
                                hintText: "Finace",
                                controller: nameController,
                                name: "Group Name",
                                takeSpaceAlphabetsNumber: true,
                                validator: (value) => InputValidator()
                                    .isValidField(value!, "Group Name")),
                            const SizedBox(
                              height: 10,
                            ),
                          ]),
                      BlocConsumer<GroupsBloc, GroupsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return CustomButton(
                            backgroundColor: state is UpdateGroupLoading
                                ? AppConstants.grey500
                                : null,
                            isLoading: state is UpdateGroupLoading,
                            loadingText: "Updating...",
                            title: "Update",
                            onPressed: () {
                              setState(() {
                                submitted = true;
                              });
                              _updateGroup(group.id!, nameController.text);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          });
        });
  }
}
