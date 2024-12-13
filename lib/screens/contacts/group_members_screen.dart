import 'package:dh_flutter_v2/bloc/groups/groups_bloc.dart';
import 'package:dh_flutter_v2/model/group_model.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/contacts/member_screen.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class GroupMembers extends StatefulWidget {
  final int groupId;
  final int? orgId;
  const GroupMembers({super.key, required this.groupId, required this.orgId});

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  List names = ["Tech", "Daniel", "Eden", "Natnael", "Natnael", "Natnael"];
  Group? group;
  List<Member?> groupMembers = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<Member?> searchResults = [];
  @override
  void initState() {
    super.initState();
    _getGroupMembers(widget.groupId);
  }

  _getGroupMembers(int groupId) {
    groupMembers = [];
    BlocProvider.of<GroupsBloc>(context).add(GetGroupById(id: groupId));
  }

  _removeGroupMember(int memberId) {
    BlocProvider.of<GroupsBloc>(context).add(
        RemoveMemberFromOrgGroup(memberId: memberId, groupId: widget.groupId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                !isSearching
                    ? const CustomText(
                        title: "Members",
                        fontSize: AppConstants.xxLarge,
                        textColor: Colors.black,
                      )
                    : Container(
                        width: 20,
                      ),
                isSearching
                    ? Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchResults = [];
                                  isSearching = false;
                                  searchController.clear();
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            searchResults = [];

                            for (var member in groupMembers) {
                              if (member != null) {
                                final firstName =
                                    member.firstName?.toLowerCase() ?? '';
                                final lastName =
                                    member.lastName?.toLowerCase() ?? '';
                                final searchValue = value.toLowerCase();

                                if (firstName.contains(searchValue) ||
                                    lastName.contains(searchValue)) {
                                  if (!searchResults.contains(member)) {
                                    searchResults.add(member);
                                  }
                                }
                              }
                            }
                            print("$searchResults");
                            print("$value");

                            setState(() {});
                          },
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            searchResults = [];
                            isSearching = true;
                          });
                        },
                        child: SvgPicture.asset(
                          AppAssets.search,
                          height: 25,
                          colorFilter: const ColorFilter.mode(
                            AppConstants.iconColor,
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const CustomText(
            //       title: "Contacts",
            //       fontSize: AppConstants.xxxLarge,
            //       textColor: Colors.black,
            //     ),
            //     SvgPicture.asset(AppAssets.search,
            //         height: 30,
            //         colorFilter: const ColorFilter.mode(
            //           AppConstants.iconColor,
            //           BlendMode.srcATop,
            //         )),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocConsumer<GroupsBloc, GroupsState>(
                listener: (context, groupState) {
                  if (groupState is GetGroupByIdError) {
                    SnackBarWidget.showSnackBar(
                        context, groupState.errorMessage);
                  }
                  if (groupState is RemoveMemberFromOrgGroupError) {
                    SnackBarWidget.showSnackBar(
                        context, groupState.errorMessage);
                  }
                  if (groupState is RemoveMemberFromOrgGroupSuccess) {
                    SnackBarWidget.showSuccessSnackBar(
                        context, "Member Removed from Org Group successfully");
                    _getGroupMembers(widget.groupId);
                  }
                  if (groupState is GetGroupByIdSuccess) {
                    group = groupState.group;

                    for (GroupMember groupMember
                        in group?.orgGroupMembers ?? []) {
                      if (!groupMembers.contains(groupMember.member)) {
                        groupMembers.add(groupMember.member);
                      }
                    }
                    setState(() {});
                  }
                },
                builder: (context, groupState) {
                  return ListView.builder(
                      itemCount: isSearching
                          ? searchResults.length
                          : groupMembers.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: contactsCard(
                              context,
                              isSearching
                                  ? groupMembers[index]
                                  : groupMembers[index]),
                        );
                      });
                },
              ),
            )
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 40, 219, 106),
      //   onPressed: () {
      //     _showDialog(context);
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
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
                    Navigator.push(
                        context,
                        customPageRoute(MemberScreen(
                          orgId: widget.orgId,
                          groupId: widget.groupId,
                        )));
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
                              title: "Organization Contact",
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                            title: "New Contact",
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

  Stack contactsCard(BuildContext context, Member? member) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: letterColors[member!.firstName![0].toUpperCase()],
                    ),
                    child: Text(
                      member.firstName != null
                          ? member.firstName![0].toUpperCase()
                          : "N",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.large),
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
                      Text(
                        toCamelCase('${member.firstName} ${member.lastName}'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: AppConstants.medium,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        member.phone ?? "",
                        style: const TextStyle(
                            color: AppConstants.grey600,
                            fontSize: AppConstants.small),
                      ),
                    ],
                  )
                ],
              ),
              InkWell(
                  onTap: () {
                    _removeGroupMember(member.id!);
                  },
                  child: const Icon(Icons.remove))
            ],
          ),
        ),
      ],
    );
  }
}
