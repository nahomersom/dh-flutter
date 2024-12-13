import 'package:dh_flutter_v2/bloc/notification/notification_bloc.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/utils/tools.dart';
import 'package:dh_flutter_v2/widgets/cutom_text.dart';
import 'package:dh_flutter_v2/widgets/search_widget.dart';
import 'package:dh_flutter_v2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popup_menu/popup_menu.dart';

import '../../constants/constants.dart';
import '../../widgets/shimmer_loadings/notification_shimmer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  PopupMenu? menu;
  GlobalKey btnKey = GlobalKey();
  bool active = true;
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _getMyNotifications();
    menu = initPopupMenu();
  }

  PopupMenu initPopupMenu() {
    return PopupMenu(
      config: const MenuConfig(
          lineColor: AppConstants.grey300,
          backgroundColor: Colors.white,
          itemWidth: 200,
          itemHeight: 50,
          type: MenuType.list),
      context: context,
      items: [
        MenuItem(
          title: 'Old to Latest',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.info_outline, color: Colors.black),
        ),
        MenuItem(
          title: 'Latest to Oldest',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.visibility_outlined, color: Colors.black),
        ),
        MenuItem(
          title: 'Select',
          textStyle: const TextStyle(
              color: AppConstants.black, fontSize: AppConstants.medium),
          image: const Icon(Icons.task_alt, color: Colors.black),
        ),
      ],
      onClickMenu: onClickMenu,
      // maxColumn: 2,
    );
  }

  void onClickMenu(MenuItemProvider item) {
    switch (item.menuTitle) {
      case 'Old to Latest':
        print('Show List Info');
        break;
      case 'Latest to Oldest':
        print('Show Completed');
        break;
      case 'Select':
        print('Select Task');
        break;
    }
  }

  _getMyNotifications() {
    BlocProvider.of<NotificationBloc>(context).add(GetMyNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<NotificationBloc, NotificationState>(
          listener: (context, notificationState) {
            if (notificationState is GetMyNotificationsFailure) {
              SnackBarWidget.showSnackBar(
                  context, notificationState.errorMessage);
            }
            if (notificationState is ChangeNotificationStatusFailure) {
              SnackBarWidget.showSnackBar(
                  context, notificationState.errorMessage);
            }
          },
          builder: (context, notificationState) {
            if (notificationState is GetMyNotificationsSuccess) {
              notifications = notificationState.notifications;
            }
            if (notificationState is GetMyNotificationsLoading) {
              return ShimmeNotificationLoader();
            }
            return Container(
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
                        title: "Notifications",
                        fontSize: AppConstants.xxLarge,
                        textColor: Colors.black,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //       padding: const EdgeInsets.all(5),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(color: AppConstants.grey300),
                      //           shape: BoxShape.circle),
                      //       child: const Icon(
                      //         Icons.close,
                      //         color: AppConstants.primaryColor,
                      //       )),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: sized_box_for_whitespace
                      Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width * .75,
                          child: searchWidget("Search")),
                      InkWell(
                        key: btnKey,
                        onTap: () {
                          menu?.show(widgetKey: btnKey);
                        },
                        child: SvgPicture.asset(AppAssets.filter,
                            height: 30,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.iconColor,
                              BlendMode.srcATop,
                            )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child:
                                notificationCard(context, notifications[index]),
                          );
                        }),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Stack notificationCard(BuildContext context, NotificationModel notification) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFD8F6FF),
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
          //  height: 100,
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Text(
                  notification.title!.substring(0, 1),
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
                    child:
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        Text(
                      toCamelCase(notification.title ?? ""),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppConstants.medium,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      notification.body ?? "",
                      style: const TextStyle(
                          color: AppConstants.grey600,
                          fontSize: AppConstants.small),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //     bottom: 30,
        //     right: 30,
        //     child: SvgPicture.asset(
        //       AppAssets.chat,
        //       height: 20,
        //     ))
      ],
    );
  }
}
