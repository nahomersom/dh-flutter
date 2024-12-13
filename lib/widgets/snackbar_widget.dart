import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SnackBarWidget {
  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Okay',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppConstants.primaryColor,
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  static void showPersistentSnackbar(
      BuildContext context, String message, dynamic function) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Expanded(
            child: Text(message),
          ),
          TextButton(
            onPressed: () {
              // Perform the action to try again
              ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
              // Add your logic for retrying here
              function();
            },
            child: const Text('Try Again'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
      duration:
          const Duration(days: 1), // Set a long duration to make it persistent
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}

void showRightToLeftSnackBar(String message, scaffoldKey) {
  final overlay = Overlay.of(scaffoldKey.currentContext!);

  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(5, 0),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 2),
            vsync: overlay,
          )..forward(),
          curve: Curves.easeInOut,
        )),
        child: Material(
          color: Colors.red,
          child: Container(
            width: 300,
            // margin: EdgeInsets.only(left: 50),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 4,
                    offset: const Offset(0,
                        3), // This is the key to having a shadow at the bottom
                  ),
                ],
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.white,
                        fontSize: AppConstants.small),
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Delay removal of SnackBar
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
