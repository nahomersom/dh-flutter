import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReactionBubble extends StatelessWidget {
  final String emoji;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const ReactionBubble({
    Key? key,
    required this.emoji,
    required this.count,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? AppConstants.primaryColor : AppConstants.grey300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 14.sp)),
            if (count > 1) ...[
              SizedBox(width: 4.w),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isSelected
                      ? AppConstants.primaryColor
                      : AppConstants.grey600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
