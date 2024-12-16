import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/home/dashboard_screen.dart';
import 'package:dh_flutter_v2/screens/messages/messages_screen.dart';
import 'package:dh_flutter_v2/screens/settings/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

class Workspace extends StatefulWidget {
  const Workspace({super.key});

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  int _selectedIndex = 0;
  int notificationCount = 3;

  // Screens corresponding to BottomNavigationBar items
  final List<Widget> _screens = [
    DashboardScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _screens.length,
        child: Scaffold(
          backgroundColor: const Color(0xffFBFAFF),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: AppConstants.grey700,
                          size: AppConstants.xxxxLarge,
                        ),
                        onPressed: () {},
                      ),
                      if (notificationCount > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 4, right: 8),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$notificationCount",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        )
                    ],
                  ),
                  const Text(
                    'DH',
                    style: TextStyle(
                      color: AppTheme.baseBlack,
                      fontSize: AppConstants.xxxxLarge,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppConstants.grey300,
                    // radius: 50,
                    child: IconButton(
                      icon: const Icon(Icons.more_horiz,
                          color: AppConstants.grey700),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.white, // Background color of the tab bar
            height: 65, // Custom height for the bottom tab bar
            child: const TabBar(
              indicatorColor: Colors.transparent, // Removes the underline
              labelColor: Color(0xff4525A2), // Color for selected tab
              unselectedLabelColor:
                  Color(0xff7C7C7D), // Color for unselected tabs
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ), // Style for selected labels
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ), // Style for unselected labels
              tabs: [
                TabItem(
                  iconData: Icons.list,
                  title: 'Tasks',
                ),
                TabItem(
                  iconData: Icons.chat_bubble_outline_outlined,
                  title: 'Communication',
                ),
                TabItem(
                  iconData: Icons.account_circle_outlined,
                  title: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
    required this.iconData,
  });

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 2),
        child: Icon(iconData, size: 25), // Icon size
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 10), // Text size
      ),
    );
  }
}
