import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinnedMessages extends StatefulWidget {
  @override
  _PinnedMessagesState createState() => _PinnedMessagesState();
}

class _PinnedMessagesState extends State<PinnedMessages> {
  bool _showPinnedMessages = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pinnedMessages = [
    {
      'title': 'Announcement:',
      'message':
          'Hello Team! We\'ve set the deadline day for the project at October 15th...'
    },
    {
      'title': 'Important Update:',
      'message': 'Team meeting scheduled for tomorrow at 10 AM...'
    },
    {
      'title': 'Reminder:',
      'message': 'Don\'t forget to submit your weekly reports by Friday...'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return Container(
          width: 2.w,
          height: 16.h,
          decoration: BoxDecoration(
            color:
                _currentPage == index ? AppTheme.primary : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(1.r),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showPinnedMessages) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppTheme.gray.shade50,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Custom vertical line indicator
              Container(
                width: 16.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: _buildPageIndicator(),
              ),
              // Vertical divider
              Container(
                width: 1.w,
                color: Colors.grey.shade200,
              ),
              // Message content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 4.h),
                      child: Row(
                        children: [
                          Text(
                            'Pinned Message',
                            style: AppConstants.bodySmallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.close, size: 20.sp),
                            onPressed: () =>
                                setState(() => _showPinnedMessages = false),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    // Scrollable content section
                    SizedBox(
                      height: 54.h,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: pinnedMessages.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(8.w, 0, 16.w, 4.h),
                                child: Text(
                                  pinnedMessages[index]['title']!,
                                  style:
                                      AppConstants.bodySmallTextStyle.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(8.w, 0, 16.w, 12.h),
                                child: Text(
                                  pinnedMessages[index]['message']!,
                                  style:
                                      AppConstants.bodySmallTextStyle.copyWith(
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
