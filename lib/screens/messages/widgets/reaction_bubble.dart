import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/widgets/stacked-avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReactionBubble extends StatelessWidget {
  final List<MapEntry<String, List<Map<String, dynamic>>>> reactions;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Color> bgColors;

  const ReactionBubble({
    Key? key,
    required this.reactions,
    this.isSelected = false,
    this.color,
    required this.onTap,
    required this.bgColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastEmoji = reactions.last.key;
    final allUsers = reactions.expand((r) => r.value).toList();

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.only(left: 8.w, top: 4.h),
          decoration: BoxDecoration(
            color: color ?? AppTheme.gray.shade200,
            borderRadius: BorderRadius.circular(60.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(lastEmoji, style: TextStyle(fontSize: 14.sp)),
              ),
              SizedBox(width: 4.w),
              StackedAvatars(
                users: allUsers,
                bgColors: bgColors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
