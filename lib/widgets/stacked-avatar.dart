import 'package:flutter/material.dart';

class StackedAvatars extends StatelessWidget {
  final List<Color> bgColors; // List of background colors for each avatar
  final List<Map<String, dynamic>?> users;

  StackedAvatars({
    Key? key,
    required this.users,
    required this.bgColors,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasExtra = users.length > 2; // Check if more than 2 items exist
    final displayUsers =
        hasExtra ? users.take(2).toList() : users; // Limit to 2

    const double avatarSize = 34; // Full diameter of avatar (17 radius * 2)
    const double overlap = 14; // Overlap between avatars

    // Dynamically calculate width based on number of avatars and overlap
    final int totalVisibleAvatars = displayUsers.length + (hasExtra ? 1 : 0);
    final double calculatedWidth = totalVisibleAvatars > 1
        ? avatarSize + (totalVisibleAvatars - 1) * (avatarSize - overlap)
        : avatarSize;
    return SizedBox(
      height: 40, // Adjust height for proper avatar display
      width: calculatedWidth,
      child: Stack(
        children:
            List.generate(displayUsers.length + (hasExtra ? 1 : 0), (index) {
          if (index < displayUsers.length) {
            return Positioned(
              left: index * 20.0, // Adjust overlap
              child: CircleAvatar(
                radius: 17, // Outer ring radius
                backgroundColor: Colors.white, // Ring color
                child: CircleAvatar(
                  radius: 15, // Inner avatar radius
                  backgroundColor: bgColors[index], // Dynamic background color
                  child: users[index]?["hasProfileImage"]
                      ? ClipOval(
                          child: Image.asset(
                            users[index]?["profileUrl"],
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                        )
                      : Text(
                          users[index]?["name"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
              ),
            );
          } else {
            return Positioned(
              left: index * 20.0, // Adjust overlap
              child: CircleAvatar(
                radius: 17, // Outer ring radius
                backgroundColor: Colors.white, // Ring color
                child: CircleAvatar(
                  radius: 15, // Inner avatar radius
                  backgroundColor:
                      Color(0xffFABD03), // Dynamic background color
                  child: Text(
                    "2+",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
