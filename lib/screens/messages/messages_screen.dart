import 'package:dh/constants/app_constants.dart';
import 'package:dh/constants/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

int notificationCount = 3;

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeH = size.height;
    final sizeW = size.width;

    return Scaffold(
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
                        style: TextStyle(
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
                  icon:
                      const Icon(Icons.more_horiz, color: AppConstants.grey700),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                suffixIcon: const Icon(
                  Icons.search,
                  size: 30,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppTheme.gray.shade200,
                    width: AppConstants.small,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundColor: AppConstants.primaryAlternativeColor,
                    child: Icon(Icons.bookmark_outline, color: Colors.white),
                  ),
                  title: 'Saved Messages',
                  subtitle: 'Send Document by 11:00 pm thursday.',
                  time: 'Oct 11',
                ),
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text('DT', style: TextStyle(color: Colors.white)),
                  ),
                  title: 'Development Team',
                  subtitle: 'Samuel: Thankyou. Upload it then.',
                  time: '30 min',
                  hasNotification: true,
                  notificationCount: 2,
                ),
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://placeholder.com/150'),
                  ),
                  title: 'Saron Kifle',
                  subtitle: 'Tomorrow 8 am works.',
                  time: 'Oct 11',
                ),
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('SD', style: TextStyle(color: Colors.white)),
                  ),
                  title: 'Shift Design',
                  subtitle: 'Daniel: The file is not responding. Can yo...',
                  time: 'Oct 11',
                  hasNotification: true,
                  notificationCount: 1,
                ),
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://placeholder.com/150'),
                  ),
                  title: 'Lemma Solomon',
                  subtitle: 'Can you refer the document?',
                  time: 'Oct 10',
                ),
                ChatListItem(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text('AIG', style: TextStyle(color: Colors.white)),
                  ),
                  title: 'AIG Study Team',
                  subtitle: 'Theo: Hey @niko, how did it go?',
                  time: 'Oct 8',
                  isMute: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final Widget avatar;
  final String title;
  final String subtitle;
  final String time;
  final bool hasNotification;
  final bool isMute;
  final int notificationCount;

  const ChatListItem(
      {Key? key,
      required this.avatar,
      required this.title,
      required this.subtitle,
      required this.time,
      this.hasNotification = false,
      this.isMute = false,
      this.notificationCount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: avatar,
        title: IntrinsicWidth(
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isMute)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.volume_off,
                    color: AppTheme.gray.shade200,
                  ),
                )
            ],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            if (hasNotification)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$notificationCount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          print("vvvvvvvvvvvv");
          context.go("/mesages/group-chat");
        });
  }
}
