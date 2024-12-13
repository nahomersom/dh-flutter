import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/group_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isOutgoing && message.avatar != null)
            CircleAvatar(
              backgroundColor:
                  message.isAnnouncement ? Colors.red : Colors.blue,
              radius: 20.r,
              child: Text(
                message.avatar!,
                style: TextStyle(color: AppConstants.white),
              ),
            ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: message.isOutgoing
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: message.isOutgoing
                          ? AppConstants.primaryAlternativeColor
                              .withOpacity(0.85)
                          : message.isAnnouncement
                              ? AppTheme.warning.shade50
                              : AppTheme.primary.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft:
                            Radius.circular(message.isOutgoing ? 16.r : 0),
                        bottomRight:
                            Radius.circular(message.isOutgoing ? 0 : 16.r),
                      ),
                      border: message.isAnnouncement
                          ? Border.all(color: AppTheme.warning.shade600)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.sender != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Text(
                              message.sender!,
                              style: AppConstants.bodySmallTextStyle
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (message.replyTo != null)
                          Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                                color: AppConstants.primaryAlternativeColor
                                    .withOpacity(0.5)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border(
                                    left: BorderSide(
                                        color: AppTheme.primary, width: 4))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.replyTo!.sender ?? 'You',
                                  style:
                                      AppConstants.bodySmallTextStyle.copyWith(
                                    color: AppConstants.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  message.replyTo!.message,
                                  style:
                                      AppConstants.bodySmallTextStyle.copyWith(
                                    color: AppConstants.grey600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        Text(
                          message.message,
                          style: AppConstants.bodyTextStyle.copyWith(
                            color: message.isOutgoing
                                ? AppConstants.white
                                : AppConstants.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message.time,
                            textAlign: TextAlign.right,
                            style: AppConstants.bodySmallTextStyle.copyWith(
                              color: message.isOutgoing
                                  ? AppConstants.white.withOpacity(0.7)
                                  : AppConstants.grey500,
                              fontSize: AppConstants.small.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 32.w),
        ],
      ),
    );
  }
}
