// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dh/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh/bloc/chat_bloc/chat_bloc.dart';
import 'package:dh/bloc/groups/groups_bloc.dart';
import 'package:dh/bloc/notification/notification_bloc.dart';
import 'package:dh/bloc/organization/organization_bloc.dart';
import 'package:dh/bloc/task_bloc/task_bloc.dart';
import 'package:dh/firebase_options.dart';
import 'package:dh/repository/chat_repositor.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/screens/auth/forget_password.dart';
import 'package:dh/screens/on_boarding/on_boarding_screen.dart';
import 'package:dh/utils/config.dart';
import 'package:dh/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constants.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  AuthRepository authRepository = AuthRepository();
  OrganizationRepository organizationRepository = OrganizationRepository();
  GroupRepository groupRepository = GroupRepository();
  TaskRepository taskRepository = TaskRepository();
  NotificationRepository notificationRepository = NotificationRepository();
  ChatRepository chatRepository = ChatRepository();

  requestPermissions();
  configureFirebaseMessaging();
  configureLocalNotifications();

  runApp(MyApp(
    authRepository: authRepository,
    organizationRepository: organizationRepository,
    groupRepository: groupRepository,
    taskRepository: taskRepository,
    notificationRepository: notificationRepository,
    chatRepository: chatRepository,
  ));
}

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future initApn() async {
  try {
    String? apnsToken = await firebaseMessaging.getAPNSToken();
    if (apnsToken == null) {
      await Future<void>.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      await firebaseMessaging.getAPNSToken();
    }
    return;
  } catch (e) {
    // print(e);
  }
}

Future<void> requestPermissions() async {
  try {
    String? fcmId = await FirebaseMessaging.instance.getToken();
    myFcmId = fcmId ?? "";
    logger("$myFcmId", {});

    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  } catch (e) {
    //
  }

  if (Platform.isIOS) {
    await initApn();
  }
}

Future<void> configureFirebaseMessaging() async {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      // message.notification!.title.toString() == "Logout"
      //     ? _logOut()
      //     : showNotification(
      //         message.notification?.title, message.notification?.body);
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // message.notification!.title.toString() == "Logout" ? _logOut() : null;
}

Future<void> configureLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings());
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('channel_id', 'channel_name',
          importance: Importance.high,
          priority: Priority.high,
          fullScreenIntent: true);
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails());
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final OrganizationRepository organizationRepository;
  final GroupRepository groupRepository;
  final TaskRepository taskRepository;
  final NotificationRepository notificationRepository;
  final ChatRepository chatRepository;
  const MyApp({
    super.key,
    required this.authRepository,
    required this.organizationRepository,
    required this.groupRepository,
    required this.taskRepository,
    required this.notificationRepository,
    required this.chatRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider(
            create: (context) => OrganizationBloc(
                organizationRepository: organizationRepository),
          ),
          BlocProvider(
            create: (context) => GroupsBloc(groupRepository: groupRepository),
          ),
          BlocProvider(
            create: (context) => TaskBloc(taskRepository: taskRepository),
          ),
          BlocProvider(
            create: (context) => NotificationBloc(
                notificationRepository: notificationRepository),
          ),
          BlocProvider(
            create: (context) => ChatBloc(chatRepository: chatRepository),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(Config.uiW, Config.uiH),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'DH',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: AppConstants.primaryColor,
                  scaffoldBackgroundColor: AppConstants.backgroundColor,
                  primarySwatch: Colors.green,
                  // brightness: Brightness.dark,
                  useMaterial3: false,
                  fontFamily: 'CabinetGrotesk',

                  appBarTheme: const AppBarTheme(
                      titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.large),
                      elevation: 0),
                  // textTheme: GoogleFonts.interTextTheme(),
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                ),
                home: const InitalScreen(),
              );
            }));
  }
}
