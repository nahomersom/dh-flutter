import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/home/dashboard_screen.dart';
import 'package:dh_flutter_v2/screens/messages/messages_screen.dart';
import 'package:dh_flutter_v2/screens/settings/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Builder(builder: (context) {
          TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                _selectedIndex = tabController.index;
              });
            }
          });
          return Scaffold(
            backgroundColor: const Color(0xffFBFAFF),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: _screens,
            ),
            appBar: _selectedIndex == 2
                ? null // Hide AppBar if the selected screen index is 2
                : AppBar(
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
                                  margin:
                                      const EdgeInsets.only(top: 4, right: 8),
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
                            backgroundColor: const Color(
                                0xFFF2F2F2), // Light grey background
                            child: PopupMenuButton<int>(
                              color: const Color(
                                  0xFFF2F2F2), // Popup background color
                              icon: const Icon(Icons.more_horiz,
                                  color: Colors.grey), // Icon color
                              offset: const Offset(
                                  0, 50), // Position the popup below the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              itemBuilder: (BuildContext context) => [
                                // Item 1: New Messages
                                _buildPopupMenuItem(
                                  value: 1,
                                  icon: Icons.message_outlined,
                                  text: 'New Messages',
                                ),
                                const PopupMenuDivider(), // Divider

                                // Item 2: New Groups
                                _buildPopupMenuItem(
                                  value: 2,
                                  icon: Icons.group_add_outlined,
                                  text: 'New Group',
                                ),
                                const PopupMenuDivider(), // Divider

                                // Item 3: Add Contacts
                                _buildPopupMenuItem(
                                  value: 3,
                                  icon: Icons.person_add_outlined,
                                  text: 'Add Contacts',
                                ),
                                const PopupMenuDivider(), // Divider

                                // Item 4: Scan
                                _buildPopupMenuItem(
                                  value: 4,
                                  icon: Icons.qr_code_scanner_outlined,
                                  text: 'Scan',
                                ),
                              ],
                              onSelected: (value) {
                                // Handle the selected value
                                switch (value) {
                                  case 1:
                                    context
                                        .go('/workspace/messages/new-message');
                                    break;
                                  case 2:
                                    print('New Groups Selected');
                                    break;
                                  case 3:
                                    print('Add Contacts Selected');
                                    break;
                                  case 4:
                                    print('Scan Selected');
                                    break;
                                }
                              },
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
          );
        }));
  }

  /// Helper method to create a PopupMenuItem
  PopupMenuItem<int> _buildPopupMenuItem({
    required int value,
    required IconData icon,
    required String text,
  }) {
    return PopupMenuItem<int>(
      value: value,
      child: SizedBox(
        width: 160.sp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: AppConstants.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppConstants.grey800,
                )),
            Icon(icon, color: Colors.grey[700], size: 20), // Icon
          ],
        ),
      ),
    );
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
