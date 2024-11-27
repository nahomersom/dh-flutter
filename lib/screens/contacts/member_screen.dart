import 'package:dh/bloc/groups/groups_bloc.dart';
import 'package:dh/bloc/organization/organization_bloc.dart';
import 'package:dh/constants/global_constants.dart';
import 'package:dh/model/member_model.dart';
import 'package:dh/screens/contacts/add_external_contact_screen.dart';
import 'package:dh/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';
import '../../widgets/widgets.dart';

class MemberScreen extends StatefulWidget {
  final int? orgId;
  final int? groupId;
  const MemberScreen({required this.orgId, this.groupId, super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List names = ["Tech", "Daniel", "Eden", "Natnael", "Natnael", "Natnael"];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<MemberDetails> memberDetails = [];
  List<MemberDetails> searchResults = [];
  @override
  void initState() {
    super.initState();
    if (widget.orgId != null) {
      _getAllOrganizationMembers();
    }
  }

  _getAllOrganizationMembers() {
    BlocProvider.of<OrganizationBloc>(context)
        .add(GetAllOrganizationMembersEvent(orgId: widget.orgId!));
  }

  _addOrganizationMembertoGroup(int memberId) {
    BlocProvider.of<GroupsBloc>(context)
        .add(AddOrgMemberToGroup(memberId: memberId, groupId: widget.groupId!));
  }

  _removeOrganizationMember(int memberId) {
    BlocProvider.of<OrganizationBloc>(context).add(
        RemoveMemberByOrgIdAndMemberIdEvent(
            orgId: widget.orgId!, memberId: memberId));
  }

  _getOrgGroups(int orgId) {
    BlocProvider.of<GroupsBloc>(context)
        .add(GetOrganizationGroups(orgId: orgId));
  }

  _getGroupById(int id) {
    BlocProvider.of<GroupsBloc>(context).add(GetGroupById(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.largeMargin),
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
                        title: "Organization Members",
                        fontSize: AppConstants.xLarge,
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
                                  isSearching = false;
                                  searchController.clear();
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            searchResults = [];

                            for (var memberDetail in memberDetails) {
                              final member = memberDetail.member;
                              if (member != null &&
                                  (member.firstName
                                              ?.toLowerCase()
                                              .contains(value.toLowerCase()) ==
                                          true ||
                                      member.lastName
                                              ?.toLowerCase()
                                              .contains(value.toLowerCase()) ==
                                          true)) {
                                // Only add if not already in searchResults
                                if (!searchResults.contains(memberDetail)) {
                                  searchResults.add(memberDetail);
                                }
                              }
                            }

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
            BlocConsumer<GroupsBloc, GroupsState>(
              listener: (context, groupState) {
                if (groupState is AddOrgMemberToGroupError) {
                  SnackBarWidget.showSnackBar(context, groupState.errorMessage);
                }
                if (groupState is AddOrgMemberToGroupSuccess) {
                  SnackBarWidget.showSuccessSnackBar(
                      context, "Member added susccessfully to the group.");
                  widget.orgId != null ? _getOrgGroups(widget.orgId!) : null;
                  widget.groupId != null
                      ? _getGroupById(widget.groupId!)
                      : null;
                }
              },
              builder: (context, groupState) {
                return BlocConsumer<OrganizationBloc, OrganizationState>(
                  listener: (context, state) {
                    if (state is GetAllOrganizationMembersFailure) {
                      SnackBarWidget.showSnackBar(context, state.errorMessage);
                    }
                    if (state is RemoveMemberByOrgIdAndMemberIdFailure) {
                      SnackBarWidget.showSnackBar(context, state.errorMessage);
                    }
                    if (state is RemoveMemberByOrgIdAndMemberIdSuccess) {
                      SnackBarWidget.showSuccessSnackBar(context,
                          "Member susccessfully removed from organization.");
                      _getAllOrganizationMembers();
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllOrganizationMembersSuccess) {
                      memberDetails = state.members;
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: isSearching
                              ? searchResults.length
                              : memberDetails.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: contactsCard(
                                  context,
                                  isSearching
                                      ? searchResults[index]
                                      : memberDetails[index]),
                            );
                          }),
                    );
                  },
                );
              },
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 40, 219, 106),
        onPressed: () {
          _showDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
                if (widget.orgId != null)
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          customPageRoute(AddExternalContactScreen(
                            orgId: widget.orgId!,
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
                                title: "External Contact",
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

  Stack contactsCard(BuildContext context, MemberDetails memberDetail) {
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
                      color: letterColors[
                          memberDetail.member!.firstName![0].toUpperCase()],
                    ),
                    child: Text(
                      memberDetail.member!.firstName != null
                          ? memberDetail.member!.firstName![0].toUpperCase()
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
                        toCamelCase(
                            '${memberDetail.member?.firstName} ${memberDetail.member?.lastName}'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: AppConstants.medium,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        memberDetail.member?.phone ?? "",
                        style: const TextStyle(
                            color: AppConstants.grey600,
                            fontSize: AppConstants.small),
                      ),
                    ],
                  )
                ],
              ),
              widget.groupId != null
                  ? InkWell(
                      onTap: () {
                        _addOrganizationMembertoGroup(memberDetail.memberId!);
                      },
                      child: const Icon(Icons.add))
                  : Container(),
              widget.groupId == null
                  ? InkWell(
                      onTap: () {
                        _removeOrganizationMember(memberDetail.memberId!);
                      },
                      child: const Icon(Icons.remove))
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
