import 'dart:async';

import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String? sender;
  final String message;
  final String time;
  final bool isOutgoing;
  final bool isAnnouncement;
  final String? avatar;
  final ChatMessage? replyTo;

  ChatMessage({
    this.sender,
    required this.message,
    required this.time,
    this.isOutgoing = false,
    this.isAnnouncement = false,
    this.avatar,
    this.replyTo,
  });
}

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen>
    with SingleTickerProviderStateMixin {
  late List<ChatMessage> _messages;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasText = false;
  final FocusNode _focusNode = FocusNode();
  ChatMessage? _replyingTo;

  // Recording vars
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String _recordingPath = '';
  Timer? _timer;
  int _recordingDuration = 0;
  bool _isExpanded = false;
  double _cancelSlidePosition = 0;
  bool _isCancelled = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showPinnedMessage = true;

  @override
  void initState() {
    super.initState();
    _messages = [
      ChatMessage(
        sender: 'Saron Kifle',
        message:
            'Hello Team! We\'ve set the deadline day for the project at October 28th, 2024. Please make sure to review your assigned tasks.',
        time: '2:55 PM',
        isAnnouncement: true,
        avatar: 'SK',
      ),
      ChatMessage(
        message:
            'Hey @lemmasolomon, hope all is well. I just sent request to the questionnaire you sent, let me in when you can.',
        time: '3:02 PM',
        isOutgoing: true,
        // sender: 'John Alexander',
      ),
      ChatMessage(
        sender: 'Lemma Solomon',
        message: 'Of course @johnalexander, I have granted you access.',
        time: '4:05 PM',
        avatar: 'LS',
        replyTo: ChatMessage(
          sender: 'John Alexander',
          message: 'Hey @lemmasolomon, hope all is well. I j...',
          time: '3:02 PM',
        ),
      ),
    ];
    _initializeRecorder();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 1, end: 1.2).animate(_animationController);
  }

  Future<void> _initializeRecorder() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      // Handle permission not granted
      print('Microphone permission not granted');
    }
  }

  void _startRecording() async {
    final directory = await getTemporaryDirectory();
    _recordingPath =
        '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _audioRecorder.start(const RecordConfig(), path: _recordingPath);

    setState(() {
      _isRecording = true;
      _recordingDuration = 0;
      _cancelSlidePosition = 0;
      _isCancelled = false;
    });

    _animationController.repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopRecording() async {
    _timer?.cancel();
    _animationController.stop();
    _animationController.reset();
    if (!_isCancelled) {
      await _audioRecorder.stop();
      _addMessageToChat(_recordingPath);
    }
    setState(() {
      _isRecording = false;
      _recordingDuration = 0;
    });
  }

  void _addMessageToChat(String audioPath) {
    _addMessage("audio sample");
  }

  String _formatDuration(int duration) {
    final minutes = (duration / 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _addMessage(String message) {
    setState(() {
      _messages.add(ChatMessage(
        message: message,
        time: _getCurrentTime(),
        isOutgoing: true,
        replyTo: _replyingTo,
      ));
      _replyingTo = null;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _handleReply(ChatMessage message) {
    setState(() {
      _replyingTo = message;
    });
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget _buildReplyPreview() {
    if (_replyingTo == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppConstants.grey100,
        border: Border(
          top: BorderSide(color: AppConstants.grey200),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppConstants.primaryAlternativeColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _replyingTo!.sender ?? 'You',
                  style: AppConstants.bodySmallTextStyle.copyWith(
                    color: AppConstants.primaryAlternativeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _replyingTo!.message,
                  style: AppConstants.bodySmallTextStyle.copyWith(
                    color: AppConstants.grey600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => setState(() => _replyingTo = null),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedMessage() {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 4.h),
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
                    onPressed: () => setState(() => _showPinnedMessage = false),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 4.h),
              child: Text(
                'Announcement:',
                style: AppConstants.bodySmallTextStyle.copyWith(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: Text(
                'Hello Team! We\'ve set the deadline day for the project at O...',
                style: AppConstants.bodySmallTextStyle.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('SD', style: TextStyle(color: AppConstants.white)),
            ),
            SizedBox(width: 10.w),
            Text(
              'Shift Design',
              style: AppConstants.titleTextStyle.copyWith(
                  fontSize: AppConstants.large, color: AppConstants.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppConstants.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showPinnedMessage) _buildPinnedMessage(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: AppConstants.mediumPadding,
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        'Oct 11',
                        style: AppConstants.bodySmallTextStyle.copyWith(
                            color: const Color.fromARGB(255, 171, 156, 156)),
                      ),
                    ),
                  );
                }
                final message = _messages[index - 1];
                return Dismissible(
                  key: Key(message.time),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    _handleReply(message);
                    return false;
                  },
                  child: MessageBubble(message: message),
                );
              },
            ),
          ),
          _buildReplyPreview(),
          // Container(
          //   padding: EdgeInsets.all(8.w),
          //   margin: EdgeInsets.symmetric(horizontal: 8),
          //   decoration: BoxDecoration(
          //     color: AppConstants.white,
          //     borderRadius: BorderRadius.circular(8.h),
          //     border: Border(
          //       top: BorderSide(color: AppTheme.gray.shade200),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       if (_isRecording) ...[
          //         Expanded(
          //           child: GestureDetector(
          //             onHorizontalDragUpdate: (details) {
          //               setState(() {
          //                 _cancelSlidePosition += details.delta.dx;
          //                 if (_cancelSlidePosition < -100) {
          //                   _isCancelled = true;
          //                   _stopRecording();
          //                 }
          //               });
          //             },
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //               child: Text(
          //                 'Slide to cancel',
          //                 style: TextStyle(
          //                   color: Colors.grey[600],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Text(_formatDuration(_recordingDuration)),
          //       ] else ...[
          //         IconButton(
          //           icon: const Icon(Icons.add, color: AppConstants.grey500),
          //           onPressed: () {},
          //         ),
          //         Expanded(
          //           child: TextField(
          //             controller: _textController,
          //             focusNode: _focusNode,
          //             decoration: InputDecoration(
          //               hintText: 'Write a message...',
          //               hintStyle: AppConstants.bodyTextStyle
          //                   .copyWith(color: AppConstants.grey500),
          //               border: InputBorder.none,
          //             ),
          //             onChanged: (value) {
          //               setState(() {
          //                 _hasText = value.isNotEmpty;
          //               });
          //             },
          //             onSubmitted: (value) {
          //               if (value.isNotEmpty) {
          //                 _addMessage(value);
          //                 _textController.clear();
          //                 setState(() {
          //                   _hasText = false;
          //                 });
          //               }
          //             },
          //           ),
          //         ),
          //       ],
          //       GestureDetector(
          //         onLongPressStart: (_) => _startRecording(),
          //         onLongPressEnd: (_) => _stopRecording(),
          //         onHorizontalDragUpdate: (details) {
          //           setState(() {
          //             _cancelSlidePosition += details.delta.dx;
          //             if (_cancelSlidePosition < -100) {
          //               _isCancelled = true;
          //               _stopRecording();
          //             }
          //           });
          //         },
          //         child: ScaleTransition(
          //           scale: _animation,
          //           child: IconButton(
          //             icon: Icon(
          //                 _focusNode.hasFocus || _hasText
          //                     ? Icons.send
          //                     : Icons.mic,
          //                 color: AppConstants.grey500),
          //             onPressed: () {
          //               if (_focusNode.hasFocus &&
          //                   _textController.text.isNotEmpty) {
          //                 _addMessage(_textController.text);
          //                 _textController.clear();
          //                 setState(() {
          //                   _hasText = false;
          //                 });
          //               }
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
            padding: EdgeInsets.all(_isExpanded ? 12 : 8),
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppConstants.white,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                top: BorderSide(color: AppTheme.gray.shade200),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (_isRecording) ...[
                      Expanded(
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            setState(() {
                              _cancelSlidePosition += details.delta.dx;
                              if (_cancelSlidePosition < -100) {
                                _isCancelled = true;
                                _stopRecording();
                              }
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Slide to cancel',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(_formatDuration(_recordingDuration)),
                    ] else ...[
                      IconButton(
                        icon:
                            const Icon(Icons.add, color: AppConstants.grey500),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          maxLines: _isExpanded ? null : 5,
                          decoration: InputDecoration(
                            hintText: 'Write a message...',
                            hintStyle: AppConstants.bodyTextStyle
                                .copyWith(color: AppConstants.grey500),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _hasText = value.isNotEmpty;
                            });
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              _addMessage(value);
                              _textController.clear();
                              setState(() {
                                _hasText = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                    IconButton(
                      icon: Icon(
                        _isExpanded ? Icons.compress : Icons.expand,
                        color: AppConstants.grey500,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                    GestureDetector(
                      onLongPressStart: (_) => _startRecording(),
                      onLongPressEnd: (_) => _stopRecording(),
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _cancelSlidePosition += details.delta.dx;
                          if (_cancelSlidePosition < -100) {
                            _isCancelled = true;
                            _stopRecording();
                          }
                        });
                      },
                      child: ScaleTransition(
                        scale: _animation,
                        child: IconButton(
                          icon: Icon(
                              _focusNode.hasFocus || _hasText
                                  ? Icons.send
                                  : Icons.mic,
                              color: AppConstants.grey500),
                          onPressed: () {
                            if (_focusNode.hasFocus &&
                                _textController.text.isNotEmpty) {
                              _addMessage(_textController.text);
                              _textController.clear();
                              setState(() {
                                _hasText = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
