import 'package:dh/bloc/task_bloc/task_bloc.dart';
import 'package:dh/model/models.dart';
import 'package:dh/model/task_model.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/routes/custom_page_route.dart';
import 'package:dh/screens/screens.dart';
import 'package:dh/utils/utils.dart';
import 'package:dh/widgets/search_widget.dart';
import 'package:dh/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/groups/groups_bloc.dart';
import '../../constants/constants.dart';
import '../../model/group_model.dart';

class PersonalGroupsScreen extends StatefulWidget {
  const PersonalGroupsScreen({super.key});

  @override
  State<PersonalGroupsScreen> createState() => _PersonalGroupsScreenState();
}

class _PersonalGroupsScreenState extends State<PersonalGroupsScreen> {
  User? user;
  int? orgId;
  List<Group> groups = [];
  List<Task> allTasks = [];
  List<Task> scheduledTasks = [];
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
          // if (user!.orgId != null)
          //   {orgId = int.parse(user!.orgId!), _getMyAssignedTasks()},
          _getMyPersonalGroups(),
        });
  }

  // _getMyAssignedTasks() {
  //   BlocProvider.of<TaskBloc>(context).add(GetMyAssignedTasks());
  // }

  _getMyPersonalGroups() {
    BlocProvider.of<GroupsBloc>(context).add(GetMyPersonalGroups());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, taskState) {
            if (taskState is GetMyAssignedTasksError) {
              SnackBarWidget.showSnackBar(context, taskState.errorMessage);
            }
            if (taskState is GetMyAssignedTasksSuccess) {
              allTasks = taskState.tasks;
              for (var task in allTasks) {
                if (task.deadline != "" ||
                    task.deadline != null ||
                    task.deadline != "null") {
                  if (!scheduledTasks.contains(task)) {
                    scheduledTasks.add(task);
                  }
                }
              }
            }
          },
          builder: (context, taskState) {
            return BlocConsumer<GroupsBloc, GroupsState>(
              listener: (context, groupState) {
                if (groupState is GetMyPersonalGroupsError) {
                  SnackBarWidget.showSnackBar(context, groupState.errorMessage);
                }
                if (groupState is GetMyPersonalGroupsSuccess) {
                  groups = [];
                  for (Group group in groupState.groups) {
                    if (group.orgId == null) {
                      if (!groups.contains(group)) {
                        groups.add(group);
                      }
                    }
                  }
                  setState(() {});
                  // groups = groupState.groups;
                }
              },
              builder: (context, groupState) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppConstants.largeMargin,
                      vertical: AppConstants.mediumMargin),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width * .88,
                            child: searchWidget("Search")),
                        // SvgPicture.asset(
                        //   AppAssets.date,
                        //   height: 30,
                        // ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     actionContainer(context, AppAssets.phCalendar, "77", "Today",
                    //         Colors.deepPurple[200]),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    // actionContainer(context, AppAssets.phCalendar, "77",
                    //     "Scheduled", Colors.green[200]),
                    // ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     actionContainer(context, AppAssets.actionReview,
                    //         "${allTasks.length}", "All", Colors.blue[500]),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     actionContainer(
                    //         context,
                    //         AppAssets.phCalendar,
                    //         "${scheduledTasks.length}",
                    //         "Scheduled",
                    //         Colors.green[200]),
                    //     // actionContainer(context, AppAssets.flag, "367", "Flagged",
                    //     //     Colors.blue[200]),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // Stack(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 15.0, vertical: 10),
                    //       margin: const EdgeInsets.only(
                    //           top: 0, left: 2, right: 2, bottom: 10),
                    //       decoration: BoxDecoration(
                    //         color: const Color.fromARGB(255, 215, 242, 250),
                    //         borderRadius: BorderRadius.circular(5),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withOpacity(0.1),
                    //             spreadRadius: 0,
                    //             blurRadius: 0,
                    //             offset: const Offset(0, 1),
                    //           ),
                    //         ],
                    //       ),
                    //       height: 80,
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //             height: 45,
                    //             width: 45,
                    //             alignment: Alignment.center,
                    //             decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: letterColors['M'],
                    //             ),
                    //             child: const Text(
                    //               'M',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: AppConstants.xxxLarge),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container(
                    //                 height: 10,
                    //               ),
                    //               SizedBox(
                    //                 width: MediaQuery.of(context).size.width * .65,
                    //                 child: const Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Row(
                    //                       children: [
                    //                         Text(
                    //                           "My ",
                    //                           style: TextStyle(
                    //                               color: Colors.black,
                    //                               fontSize: AppConstants.large,
                    //                               fontWeight: FontWeight.bold),
                    //                         ),
                    //                         SizedBox(
                    //                           width: 5,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Text(
                    //                       "23 min",
                    //                       style: TextStyle(
                    //                           color: AppConstants.grey400,
                    //                           fontSize: AppConstants.small,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 4,
                    //               ),
                    //               const Text(
                    //                 "Meeting.pdf",
                    //                 style: TextStyle(
                    //                     color: AppConstants.grey600,
                    //                     fontSize: AppConstants.medium),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     Positioned(
                    //         bottom: 20,
                    //         right: 15,
                    //         child: SvgPicture.asset(AppAssets.pin,
                    //             height: 20,
                    //             colorFilter: const ColorFilter.mode(
                    //               AppConstants.iconColor,
                    //               BlendMode.srcATop,
                    //             ))),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          title: "My Personal Groups",
                          textColor: Colors.black,
                          fontSize: AppConstants.xLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                customPageRoute(const AddListScreen()));
                          },
                          child: const CustomText(
                            title: "Add List",
                            textColor: AppConstants.primaryColor,
                            fontSize: AppConstants.medium,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         customPageRoute(AddListItemsScreen(
                    //           isPersonal: true,
                    //           userId: user!.id!,
                    //         )));
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 15, horizontal: 0),
                    //     decoration:
                    //         BoxDecoration(color: Colors.white, boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.1),
                    //         spreadRadius: 0,
                    //         blurRadius: 0,
                    //         offset: const Offset(0, 1),
                    //       ),
                    //     ]),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SvgPicture.asset(
                    //               AppAssets.person,
                    //               height: 30,
                    //             ),
                    //             const SizedBox(
                    //               width: 15,
                    //             ),
                    //             const CustomText(
                    //               title: "My",
                    //               textColor: Colors.black,
                    //               fontSize: AppConstants.medium,
                    //             ),
                    //           ],
                    //         ),
                    //         const Icon(
                    //           Icons.arrow_forward_ios_rounded,
                    //           color: AppConstants.iconColor,
                    //           size: 20,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    customPageRoute(AddListItemsScreen(
                                        isPersonal: true,
                                        userId: user!.id!,
                                        groupId: groups[index].id)));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // SvgPicture.asset(
                                        //   AppAssets.app,
                                        //   height: 25,
                                        // ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: groups[index].color !=
                                                        null &&
                                                    groups[index].color != ""
                                                ? getColorFromMaterialColorString(
                                                    groups[index].color!)
                                                : AppConstants.primaryColor,
                                          ),
                                          child: Text(
                                            groups[index].name != ""
                                                ? groups[index]
                                                    .name!
                                                    .substring(0, 1)
                                                    .toUpperCase()
                                                : "",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    AppConstants.xxxLarge),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        CustomText(
                                          title: toCamelCase(
                                              groups[index].name ?? ""),
                                          textColor: Colors.black,
                                          fontSize: AppConstants.medium,
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppConstants.grey600,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    //   margin: const EdgeInsets.only(
                    //     left: 45,
                    //   ),
                    //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.1),
                    //       spreadRadius: 0,
                    //       blurRadius: 0,
                    //       offset: const Offset(0, 1),
                    //     ),
                    //   ]),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           SvgPicture.asset(
                    //             AppAssets.meet,
                    //             height: 25,
                    //           ),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           const CustomText(
                    //             title: "Meeting",
                    //             textColor: Colors.black,
                    //             fontSize: AppConstants.medium,
                    //           ),
                    //         ],
                    //       ),
                    //       const Row(
                    //         children: [
                    //           CustomText(
                    //             title: "7",
                    //             fontSize: AppConstants.medium,
                    //             textColor: AppConstants.black,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward_ios_rounded,
                    //             color: AppConstants.iconColor,
                    //             size: 20,
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    //   margin: const EdgeInsets.only(
                    //     left: 45,
                    //   ),
                    //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.1),
                    //       spreadRadius: 0,
                    //       blurRadius: 0,
                    //       offset: const Offset(0, 1),
                    //     ),
                    //   ]),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           SvgPicture.asset(
                    //             AppAssets.review,
                    //             height: 25,
                    //           ),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           const CustomText(
                    //             title: "Review",
                    //             textColor: Colors.black,
                    //             fontSize: AppConstants.medium,
                    //           ),
                    //         ],
                    //       ),
                    //       const Row(
                    //         children: [
                    //           CustomText(
                    //             title: "8",
                    //             fontSize: AppConstants.medium,
                    //             textColor: AppConstants.black,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward_ios_rounded,
                    //             color: AppConstants.iconColor,
                    //             size: 20,
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ]),
                );
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     Navigator.push(context, customPageRoute(const CalendarScreen()));
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Container actionContainer(
      BuildContext context, String asset, String count, String title, color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width * .42,
      height: 70,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(asset,
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                    AppConstants.white,
                    BlendMode.srcATop,
                  )),
              CustomText(
                title: count,
                fontSize: AppConstants.large,
                textColor: Colors.white,
              ),
            ],
          ),
          CustomText(
            title: toCamelCase(title),
            fontSize: AppConstants.large,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
