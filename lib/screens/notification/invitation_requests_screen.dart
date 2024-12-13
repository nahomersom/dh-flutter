import 'package:dh_flutter_v2/bloc/organization/organization_bloc.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/utils/tools.dart';
import 'package:dh_flutter_v2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popup_menu/popup_menu.dart';

import '../../constants/constants.dart';

class InvitationRequestScreen extends StatefulWidget {
  const InvitationRequestScreen({super.key});

  @override
  State<InvitationRequestScreen> createState() =>
      _InvitationRequestScreenState();
}

class _InvitationRequestScreenState extends State<InvitationRequestScreen> {
  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  bool active = true;
  List<Organization> invitations = [];
  @override
  void initState() {
    super.initState();
    _getOrgInvitations();
  }

  _getOrgInvitations() {
    BlocProvider.of<OrganizationBloc>(context).add(GetMyOrgInvitesEvent());
  }

  _changeOrgInvitationStatus(String status, int id) {
    BlocProvider.of<OrganizationBloc>(context)
        .add(ChangeRequestStatusEvent(status: status, id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.grey200,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(
            children: [
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
                    width: 25,
                  ),
                  const CustomText(
                    title: "Invitation Requests",
                    fontSize: AppConstants.xLarge,
                    textColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<OrganizationBloc, OrganizationState>(
                listener: (context, state) {
                  if (state is GetMyOrgInvitesFailure) {
                    SnackBarWidget.showSnackBar(context, state.errorMessage);
                  }
                  if (state is GetMyOrgInvitesSuccess) {
                    // invitations = state.invitations;
                    invitations = [];
                    for (var invitation in state.invitations) {
                      // for (Invite invite in invitation.invites ?? []) {
                      // if (invite.status?.toLowerCase() == "pending") {
                      if (!invitations.contains(invitation)) {
                        invitations.add(invitation);
                        // }
                        // }
                      }
                    }
                    setState(() {});
                  }
                  if (state is ChangeRequestStatusFailure) {
                    SnackBarWidget.showSnackBar(context, state.errorMessage);
                  }

                  if (state is ChangeRequestStatusSuccess) {
                    SnackBarWidget.showSuccessSnackBar(
                        context, "Invitation status changed successfully");
                    _getOrgInvitations();
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      children: invitations.map((invitation) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            invitation.invites?.isEmpty == true
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: CustomText(
                                      title:
                                          "To join ${toCamelCase(invitation.name ?? "")}",
                                      fontSize: AppConstants.large,
                                    ),
                                  ),
                            ...invitation.invites!.map((invite) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                margin: const EdgeInsets.only(
                                    top: 0, left: 2, right: 2, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppConstants
                                                .primaryColorVeryLight,
                                          ),
                                          child: Text(
                                            invite.invitee != null &&
                                                    invite.invitee?.firstName !=
                                                        null &&
                                                    invite.invitee?.firstName !=
                                                        ""
                                                ? invite.invitee!.firstName![0]
                                                    .toUpperCase()
                                                : "",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppConstants.medium),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              toCamelCase(
                                                  '${invite.invitee?.firstName} ${invite.invitee?.lastName}'),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: AppConstants.medium,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              formatDate(DateTime.parse(invite
                                                      .createdAt ??
                                                  DateTime.now().toString())),
                                              style: const TextStyle(
                                                  color: AppConstants.grey600,
                                                  fontSize: AppConstants.small),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    invite.status?.toLowerCase() != "pending"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                borderRadius: 5,
                                                backgroundColor:
                                                    AppConstants.grey500,
                                                width: 100,
                                                height: 30,
                                                onPressed: () {},
                                                title: invite.status ?? '',
                                                textSize: AppConstants.small,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                borderRadius: 5,
                                                width: 80,
                                                height: 30,
                                                onPressed: () {
                                                  _changeOrgInvitationStatus(
                                                      "Approved", invite.id!);
                                                },
                                                title: "Accept",
                                                textSize: AppConstants.small,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomButton(
                                                backgroundColor: Colors.red,
                                                borderRadius: 5,
                                                width: 80,
                                                height: 30,
                                                onPressed: () {
                                                  _changeOrgInvitationStatus(
                                                      "Rejected", invite.id!);
                                                },
                                                title: "Reject",
                                                textSize: AppConstants.small,
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  invitationRequestCard(BuildContext context, List<Invite> invitation) {
    return ListView.builder(
        itemCount: invitation.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            margin:
                const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            // height: 100,s
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppConstants.primaryColorVeryLight,
                      ),
                      child: Text(
                        invitation[index].invitee != null &&
                                invitation[index].invitee?.firstName != null &&
                                invitation[index].invitee?.firstName != ""
                            ? invitation[index]
                                .invitee!
                                .firstName![0]
                                .toUpperCase()
                            : "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.medium),
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
                          width: MediaQuery.of(context).size.width * .65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    toCamelCase(
                                        '${invitation[index].invitee?.firstName} ${invitation[index].invitee?.lastName}'),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: AppConstants.medium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              // const Text(
                              //   "Just now",
                              //   style: TextStyle(
                              //       color: AppConstants.grey600,
                              //       fontSize: AppConstants.xSmall,
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatDate(DateTime.parse(
                              invitation[index].createdAt ??
                                  DateTime.now().toString())),
                          style: const TextStyle(
                              color: AppConstants.grey600,
                              fontSize: AppConstants.small),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      borderRadius: 5,
                      width: 80,
                      height: 30,
                      onPressed: () {
                        _changeOrgInvitationStatus(
                            "Approved", invitation[index].id!);
                      },
                      title: "Accept",
                      textSize: AppConstants.small,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomButton(
                      backgroundColor: Colors.red,
                      borderRadius: 5,
                      width: 80,
                      height: 30,
                      onPressed: () {
                        _changeOrgInvitationStatus(
                            "Rejected", invitation[index].id!);
                      },
                      title: "Reject",
                      textSize: AppConstants.small,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
