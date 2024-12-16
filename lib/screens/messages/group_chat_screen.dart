import 'dart:async';

import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/widgets/message_bubble.dart';
import 'package:dh_flutter_v2/screens/messages/widgets/message_input.dart';
import 'package:dh_flutter_v2/screens/messages/widgets/pinned_missages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String? sender;
  final String? message;
  final String time;
  final bool isOutgoing;
  final bool isAnnouncement;
  final String? avatar;
  final ChatMessage? replyTo;
  final String? audioPath; // Optional field for audio messages

  ChatMessage({
    this.sender,
    this.message,
    required this.time,
    this.isOutgoing = false,
    this.isAnnouncement = false,
    this.avatar,
    this.replyTo,
    this.audioPath,
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
    _addMessage(message: audioPath, isAudio: true);
  }

  String _formatDuration(int duration) {
    final minutes = (duration / 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _addMessage({String? message, isAudio = false}) {
    setState(() {
      _messages.add(ChatMessage(
          message: isAudio ? '' : message,
          time: _getCurrentTime(),
          isOutgoing: true,
          replyTo: _replyingTo,
          audioPath: isAudio ? message : null));
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

  void _showMessageOptions(
      BuildContext context, ChatMessage message, Offset globalPosition) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          _buildOptionTile(
            icon: Icons.reply,
            title: 'Reply',
            onTap: () {
              Navigator.pop(context);
              _handleReply(message);
            },
          ),
          _buildOptionTile(
            icon: Icons.copy,
            title: 'Copy',
            onTap: () {
              // Add copy functionality
              Navigator.pop(context);
            },
          ),
          _buildOptionTile(
            icon: Icons.forward,
            title: 'Forward',
            onTap: () {
              // Add forward functionality
              Navigator.pop(context);
            },
          ),
          _buildOptionTile(
            icon: Icons.push_pin,
            title: 'Pin',
            onTap: () {
              // Add pin functionality
              Navigator.pop(context);
            },
          ),
          _buildOptionTile(
            icon: Icons.delete,
            title: 'Delete',
            onTap: () {
              // Add delete functionality
              Navigator.pop(context);
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppConstants.grey600,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppConstants.grey800,
          fontSize: 16.sp,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _timer?.cancel();
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
                  _replyingTo!.message ?? '',
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
          PinnedMessages(),
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
                return GestureDetector(
                  onLongPressStart: (LongPressStartDetails details) {
                    _showMessageOptions(
                        context, message, details.globalPosition);
                  },
                  child: MessageBubble(message: message),
                );
              },
            ),
          ),
          _buildReplyPreview(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: !_isRecording
                  ? Border.all(color: Colors.grey.shade300)
                  : null,
            ),
            child: Row(
              children: [
                if (!_isRecording) ...[
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.grey.shade600),
                    onPressed: () {},
                    padding: EdgeInsets.all(12.w),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode,
                      maxLines: _isExpanded ? 9 : 1,
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _hasText = value.isNotEmpty;
                        });
                      },
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _addMessage(message: value);
                          _textController.clear();
                          setState(() {
                            _hasText = false;
                          });
                        }
                      },
                    ),
                  ),
                  if (_hasText)
                    IconButton(
                      icon: Icon(
                        _isExpanded
                            ? Icons.close_fullscreen
                            : Icons.open_in_full,
                        color: AppConstants.grey500,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                ] else ...[
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDuration(_recordingDuration),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back,
                              size: 20.sp, color: Colors.grey[600]),
                          SizedBox(width: 8.w),
                          Text(
                            'Slide to cancel',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                GestureDetector(
                  onLongPressStart: (_) => _startRecording(),
                  onLongPressEnd: (_) => _stopRecording(),
                  onLongPressMoveUpdate: (_) {
                    setState(() {
                      _isCancelled = true;
                      _stopRecording();
                    });
                  },
                  onTap: () {
                    if (!_isRecording && _textController.text.isNotEmpty) {
                      _addMessage(message: _textController.text);
                      _textController.clear();
                      setState(() {
                        _hasText = false;
                      });
                    }
                  },
                  child: ScaleTransition(
                    scale: _animation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isRecording ? 50.w : 40.w,
                      height: _isRecording ? 50.w : 40.w,
                      decoration: BoxDecoration(
                        color: _isRecording
                            ? AppTheme.primary
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: _isRecording
                            ? [
                                BoxShadow(
                                    color: AppTheme.gray.shade100,
                                    blurRadius: 12,
                                    spreadRadius: 20,
                                    blurStyle: BlurStyle.solid)
                              ]
                            : null,
                      ),
                      child: Icon(
                        _hasText ? Icons.send : Icons.mic,
                        color:
                            _isRecording ? Colors.white : Colors.grey.shade600,
                        size: _isRecording ? 24.sp : 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
