import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isRecording = false;
  bool _hasText = false;
  Duration _recordingDuration = Duration.zero;
  double _cancelSlidePosition = 0;
  bool _isCancelled = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  Timer? _recordingTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _isCancelled = false;
      _cancelSlidePosition = 0;
      _recordingDuration = Duration.zero;
    });
    _animationController.forward();

    // Start timer for recording duration
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopRecording() {
    _recordingTimer?.cancel();
    _animationController.reverse();

    if (!_isCancelled) {
      // Handle sending the recording
      print('Sending recording of ${_formatDuration(_recordingDuration)}');
    }

    setState(() {
      _isRecording = false;
      _recordingDuration = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: _isRecording ? Color(0xFFF3F0F7) : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        border: !_isRecording ? Border.all(color: Colors.grey.shade300) : null,
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
              ),
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isRecording ? 56.w : 40.w,
              height: _isRecording ? 56.w : 40.w,
              decoration: BoxDecoration(
                color: _isRecording ? Color(0xFF9747FF) : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: _isRecording
                    ? [
                        BoxShadow(
                          color: Color(0xFF9747FF).withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  _hasText ? Icons.send : Icons.mic,
                  color: _isRecording ? Colors.white : Colors.grey.shade600,
                  size: _isRecording ? 24.sp : 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
