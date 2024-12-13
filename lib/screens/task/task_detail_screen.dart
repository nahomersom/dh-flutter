import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isPersonal;
  final int? groupId;
  const TaskDetailScreen({super.key, required this.isPersonal, this.groupId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

enum MenuOption {
  showListInfo,
  showCompleted,
  selectTask,
  deleteTasks,
  deleteGroup
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final bool isAdmin = true; // Change this based on user role
  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  bool active = true;

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
          title: 'Show List Info',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.info_outline, color: Colors.black),
        ),
        MenuItem(
          title: 'Show Completed',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.visibility_outlined, color: Colors.black),
        ),
        MenuItem(
          title: 'Select Task',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.task_alt, color: Colors.black),
        ),
        if (isAdmin) ...[
          // MenuItem(
          //   title: 'Delete Tasks',
          //   textStyle: const TextStyle(
          //       color: AppConstants.black, fontSize: AppConstants.medium),
          //   image: const Icon(Icons.delete, color: Colors.black),
          // ),
          MenuItem(
            title: 'Delete List',
            textStyle: const TextStyle(
                color: Colors.red, fontSize: AppConstants.medium),
            image: const Icon(Icons.cancel_outlined, color: Colors.red),
          ),
        ],
      ],
      onClickMenu: onClickMenu,
      // maxColumn: 2,
    );
  }

  void onClickMenu(MenuItemProvider item) {
    switch (item.menuTitle) {
      case 'Show List Info':
        print('Show List Info');
        break;
      case 'Show Completed':
        print('Show Completed');
        break;
      case 'Select Task':
        print('Select Task');
        break;
      case 'Delete Tasks':
        print('Delete Tasks');
        break;
      case 'Delete Group':
        print('Delete Group');
        break;
    }
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
          child: ListView(children: [
            const SizedBox(
              height: 15,
            ),
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
                  title: "",
                  fontSize: AppConstants.xxLarge,
                  textColor: Colors.black,
                ),
                InkWell(
                  key: btnKey,
                  onTap: () {
                    menu?.show(widgetKey: btnKey);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppConstants.grey500,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.more_horiz,
                    ),
                  ),
                ),
                // PopupMenuButton<MenuOption>(

                //   onSelected: _onMenuSelected,
                //   itemBuilder: (BuildContext context) {
                //     return <PopupMenuEntry<MenuOption>>[
                //       const PopupMenuItem<MenuOption>(
                //         value: MenuOption.showListInfo,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Text(
                //               'Show List Info',
                //               style: TextStyle(
                //                   color: AppConstants.black,
                //                   fontSize: AppConstants.medium),
                //             ),
                //             SizedBox(width: 10),
                //             Icon(
                //               Icons.info_outline,
                //               color: AppConstants.black,
                //             ),
                //           ],
                //         ),
                //       ),
                //       const PopupMenuDivider(),
                //       const PopupMenuItem<MenuOption>(
                //         value: MenuOption.showCompleted,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Text(
                //               'Show Completed',
                //               style: TextStyle(
                //                   color: AppConstants.black,
                //                   fontSize: AppConstants.medium),
                //             ),
                //             SizedBox(width: 10),
                //             Icon(
                //               Icons.visibility_outlined,
                //               color: AppConstants.black,
                //             ),
                //           ],
                //         ),
                //       ),
                //       const PopupMenuDivider(),
                //       const PopupMenuItem<MenuOption>(
                //         value: MenuOption.selectTask,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Text(
                //               'Select Task',
                //               style: TextStyle(
                //                   color: AppConstants.black,
                //                   fontSize: AppConstants.medium),
                //             ),
                //             SizedBox(width: 10),
                //             Icon(
                //               Icons.task_alt_sharp,
                //               color: AppConstants.black,
                //             ),
                //           ],
                //         ),
                //       ),
                //       if (isAdmin) ...[
                //         const PopupMenuDivider(),
                //         // const PopupMenuItem<MenuOption>(
                //         //   value: MenuOption.deleteTasks,
                //         //   child: Row(
                //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //     children: <Widget>[
                //         //       Text(
                //         //         'Delete Tasks',
                //         //         style: TextStyle(
                //         //             color: AppConstants.black,
                //         //             fontSize: AppConstants.medium),
                //         //       ),
                //         //       SizedBox(width: 10),
                //         //       Icon(
                //         //         Icons.delete_outline,
                //         //         color: AppConstants.black,
                //         //       ),
                //         //     ],
                //         //   ),
                //         // ),
                //         const PopupMenuItem<MenuOption>(
                //           value: MenuOption.deleteGroup,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: <Widget>[
                //               Text(
                //                 'Delete Group',
                //                 style: TextStyle(
                //                     color: AppConstants.black,
                //                     fontSize: AppConstants.medium),
                //               ),
                //               SizedBox(width: 10),
                //               Icon(
                //                 Icons.group_off_outlined,
                //                 color: AppConstants.black,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ];
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 2),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //           color: AppConstants.grey500,
                //         ),
                //         borderRadius: BorderRadius.circular(20)),
                //     child: const Icon(
                //       Icons.more_horiz,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const CustomText(
              title: "My",
              textColor: Colors.black,
              fontSize: AppConstants.xxLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                active = !active;
                setState(() {});
              },
              child: taskContainer("Task 1", active),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: taskContainer("Task 2", false),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: taskContainer("Task 3", false),
            ),
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
      ),
    );
  }

  taskContainer(String title, bool active) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   color: Colors.white,
            //   border: Border.all(color: AppConstants.grey300),
            // ),
            child: Row(
              children: [
                // Checkbox(value: false, onChanged: (val) {}),
                // const SizedBox(
                //   width: 15,
                // ),
                Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color:
                      //     active ? AppConstants.primaryColor : Colors.white,
                      border: Border.all(
                          color: active
                              ? AppConstants.primaryColor
                              : AppConstants.grey500)),
                  child: active
                      ? const Icon(
                          Icons.check,
                          color: AppConstants.primaryColor,
                          size: 15,
                        )
                      : null,
                ),

                const SizedBox(
                  width: 15,
                ),
                CustomText(
                    title: title,
                    textColor: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: AppConstants.large),
              ],
            )),
        const SizedBox(
          height: 5,
        ),
        const Divider()
      ],
    );
  }
}
