import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/model/models.dart';
import 'package:dh/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../screens.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  bool hasProfile = false;
  User? user;

  static final List<Widget> _screens = [
    const HomeScreen(),
    const TaskScreen(),
    const ProfileTabScreen(
      isPersonal: true,
    ),
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    _getMyProfile();
    super.initState();
  }

  _getMyProfile() {
    BlocProvider.of<AuthBloc>(context).add(const GetMyProfileEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GetMyProfileFailure) {
            SnackBarWidget.showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is GetMyProfileSuccess) {
            user = state.user;
          }
          return BottomNavigationBar(
            // backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(AppAssets.communication,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppConstants.iconColor,
                        BlendMode.srcATop,
                      )),
                ),
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(AppAssets.communication,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppConstants.primaryColor,
                        BlendMode.srcATop,
                      )),
                ),
                label: 'Communicate',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(AppAssets.task,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppConstants.iconColor,
                        BlendMode.srcATop,
                      )),
                ),
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(AppAssets.task,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppConstants.primaryColor,
                        BlendMode.srcATop,
                      )),
                ),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: user?.profileImage != null
                    ? Container(
                        height: 28,
                        decoration: BoxDecoration(
                            color: AppConstants.primaryColorVeryLight,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(user!.profileImage!))),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: SvgPicture.asset(AppAssets.profile,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.iconColor,
                              BlendMode.srcATop,
                            )),
                      ),
                activeIcon: user?.profileImage != null
                    ? Container(
                        height: 28,
                        decoration: BoxDecoration(
                            color: AppConstants.primaryColorVeryLight,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(user!.profileImage!))),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: SvgPicture.asset(AppAssets.profile,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.primaryColor,
                              BlendMode.srcATop,
                            )),
                      ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedIconTheme:
                const IconThemeData(color: AppConstants.primaryColor),
            selectedItemColor: AppConstants.primaryColor,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}
