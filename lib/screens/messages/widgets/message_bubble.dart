import 'package:audioplayers/audioplayers.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/group_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatefulWidget {
  final ChatMessage message;
  final Function(ChatMessage, String) onReactionTap;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.onReactionTap,
  }) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  final String currentUserId = 'current_user_id';

  @override
  void initState() {
    super.initState();

    // Listen to the total duration of the audio file
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    // Listen to current playback position
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // Listen for completion to reset the UI
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero; // Reset playback time
      });
    });
  }

  Future<void> _playAudio(String audioPath) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    } else {
      await _audioPlayer.play(DeviceFileSource(audioPath));
      setState(() {
        _isPlaying = true;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!widget.message.isOutgoing && widget.message.avatar != null)
            CircleAvatar(
              backgroundColor:
                  widget.message.isAnnouncement ? Colors.red : Colors.blue,
              radius: 20.r,
              child: Text(
                widget.message.avatar!,
                style: TextStyle(color: AppConstants.white),
              ),
            ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: widget.message.isOutgoing
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: widget.message.isOutgoing
                          ? AppConstants.primaryAlternativeColor
                              .withOpacity(0.85)
                          : widget.message.isAnnouncement
                              ? AppTheme.warning.shade50
                              : AppTheme.primary.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(
                            widget.message.isOutgoing ? 16.r : 0),
                        bottomRight: Radius.circular(
                            widget.message.isOutgoing ? 0 : 16.r),
                      ),
                      border: widget.message.isAnnouncement
                          ? Border.all(color: AppTheme.warning.shade600)
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.message.audioPath != null)
                          Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    _playAudio(widget.message.audioPath!),
                                icon: Icon(
                                  _isPlaying ? Icons.stop : Icons.play_arrow,
                                  color: widget.message.isOutgoing
                                      ? AppConstants.white
                                      : AppConstants.primaryColor,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Audio Message",
                                      style:
                                          AppConstants.bodyTextStyle.copyWith(
                                        color: widget.message.isOutgoing
                                            ? AppConstants.white
                                            : AppConstants.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "${_formatDuration(_currentPosition)} / ${_formatDuration(_totalDuration)}",
                                      style: AppConstants.bodySmallTextStyle
                                          .copyWith(
                                        color: widget.message.isOutgoing
                                            ? AppConstants.white
                                                .withOpacity(0.7)
                                            : AppConstants.grey600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            widget.message.message ?? '',
                            style: AppConstants.bodyTextStyle.copyWith(
                              color: widget.message.isOutgoing
                                  ? AppConstants.white
                                  : AppConstants.black,
                            ),
                          ),
                        SizedBox(height: 4.h),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            widget.message.time,
                            textAlign: TextAlign.right,
                            style: AppConstants.bodySmallTextStyle.copyWith(
                              color: widget.message.isOutgoing
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
                if (widget.message.reactions.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      left: widget.message.isOutgoing ? 0 : 40.w,
                      right: widget.message.isOutgoing ? 0 : 40.w,
                      top: 4.h,
                    ),
                    child: Wrap(
                      spacing: 4.w,
                      children: widget.message.reactions.entries.map((entry) {
                        final hasReacted = entry.value.contains(currentUserId);
                        return ReactionBubble(
                          emoji: entry.key,
                          count: entry.value.length,
                          isSelected: hasReacted,
                          onTap: () =>
                              widget.onReactionTap(widget.message, entry.key),
                        );
                      }).toList(),
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
