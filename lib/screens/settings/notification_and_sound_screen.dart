import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class NotificationsAndSoundsScreen extends StatefulWidget {
  const NotificationsAndSoundsScreen({super.key});

  @override
  _NotificationsAndSoundsScreenState createState() =>
      _NotificationsAndSoundsScreenState();
}

class _NotificationsAndSoundsScreenState
    extends State<NotificationsAndSoundsScreen> {
  bool privateChats = true;
  bool groups = true;
  bool channels = true;
  bool stories = false;
  bool reactions = true;
  bool showBadgeIcon = true;
  bool includeMutedChats = false;
  bool countUnreadMessages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          title: "Notifications and Sounds",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.grey700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.mediumMargin),
        children: [
          const SectionTitle(title: "Notifications for chats"),
          CustomSwitchTile(
            title: "Private Chats",
            subtitle: "Tap to change",
            value: privateChats,
            onChanged: (value) {
              setState(() {
                privateChats = value;
              });
            },
          ),
          CustomSwitchTile(
            title: "Groups",
            subtitle: "On, 9 exceptions",
            value: groups,
            onChanged: (value) {
              setState(() {
                groups = value;
              });
            },
          ),
          // CustomSwitchTile(
          //   title: "Channels",
          //   subtitle: "On, 14 exceptions",
          //   value: channels,
          //   onChanged: (value) {
          //     setState(() {
          //       channels = value;
          //     });
          //   },
          // ),
          // CustomSwitchTile(
          //   title: "Stories",
          //   subtitle: "Off, 5 automatic exceptions",
          //   value: stories,
          //   onChanged: (value) {
          //     setState(() {
          //       stories = value;
          //     });
          //   },
          // ),
          // CustomSwitchTile(
          //   title: "Reactions",
          //   subtitle: "Messages, Stories",
          //   value: reactions,
          //   onChanged: (value) {
          //     setState(() {
          //       reactions = value;
          //     });
          //   },
          // ),
          const Divider(),
          const SectionTitle(title: "Calls"),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            title: const Text(
              "Vibrate",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: AppConstants.medium,
                  fontWeight: FontWeight.bold),
            ),
            trailing:
                const Text("Default", style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Handle tap for Vibrate option
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            title: const Text(
              "Ringtone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: AppConstants.medium,
                  fontWeight: FontWeight.bold),
            ),
            trailing:
                const Text("Default", style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Handle tap for Ringtone option
            },
          ),
          const Divider(),
          const SectionTitle(title: "Badge Counter"),
          CustomSwitchTile(
            title: "Show Badge Icon",
            value: showBadgeIcon,
            onChanged: (value) {
              setState(() {
                showBadgeIcon = value;
              });
            },
          ),
          CustomSwitchTile(
            title: "Include Muted Chats",
            value: includeMutedChats,
            onChanged: (value) {
              setState(() {
                includeMutedChats = value;
              });
            },
          ),
          CustomSwitchTile(
            title: "Count Unread Messages",
            value: countUnreadMessages,
            onChanged: (value) {
              setState(() {
                countUnreadMessages = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppConstants.large,
          fontWeight: FontWeight.bold,
          color: AppConstants.primaryColor,
        ),
      ),
    );
  }
}

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppConstants.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: AppConstants.medium,
            fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: const TextStyle(
                  color: Colors.grey, fontSize: AppConstants.small))
          : null,
      trailing: Switch(
        activeColor: AppConstants.primaryColor,
        value: value,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(!value),
    );
  }
}
