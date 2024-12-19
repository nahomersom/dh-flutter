import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/messages/group_chat_screen.dart';
import 'package:dh_flutter_v2/widgets/stacked-avatar.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PopupItem {
  final IconData icon;
  final String title;
  final bool isDestructive;
  final VoidCallback onTap;

  const PopupItem({
    Key? key,
    required this.icon,
    required this.title,
    this.isDestructive = false,
    required this.onTap,
  });
}

class PopupOption extends StatefulWidget {
  final List<PopupItem> popupItems;
  final bool hasEmoji;
  final ChatMessage? message;
  final Offset position;
  final double popupWidth;
  final Function(ChatMessage message, String emoji) handleReaction;

  const PopupOption({
    super.key,
    required this.popupItems,
    this.hasEmoji = false,
    this.message,
    required this.position,
    required this.popupWidth,
    required this.handleReaction,
  });

  @override
  State<PopupOption> createState() => _PopupOptionState();
}

class _PopupOptionState extends State<PopupOption> {
  final List<String> quickEmojis = ['👍', '👎', '🙏'];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final double popupItemHeight = 44.0;
  final double containerSpacing = 8.0;
  bool _showingReactionDetails = false;

  @override
  void dispose() {
    _removeEmojiPicker();
    super.dispose();
  }

  void _removeEmojiPicker() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showEmojiPicker() {
    _removeEmojiPicker();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 280,
        child: CompositedTransformFollower(
          link: _layerLink,
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          offset: const Offset(0, -10),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  widget.handleReaction(widget.message!, emoji.emoji);
                  _removeEmojiPicker();
                },
                config: const Config(
                  height: 250,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    columns: 7,
                    emojiSizeMax: 32.0,
                  ),
                  categoryViewConfig: CategoryViewConfig(
                    initCategory: Category.SMILEYS,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Offset _getAdjustedPosition(
      BuildContext context, Offset original, double popupWidth) {
    final screenSize = MediaQuery.of(context).size;
    final totalHeight = widget.hasEmoji
        ? (widget.popupItems.length * popupItemHeight +
            popupItemHeight +
            containerSpacing)
        : (widget.popupItems.length * popupItemHeight);

    double dx = original.dx;
    double dy = original.dy;

    if (dx + popupWidth > screenSize.width) {
      dx = screenSize.width - popupWidth - 16;
    }
    if (dx < 16) dx = 16;

    if (dy + totalHeight > screenSize.height) {
      dy = screenSize.height - totalHeight - 16;
    }
    if (dy < 16) dy = 16;

    if (dx + popupWidth > screenSize.width ||
        dx < 0 ||
        dy + totalHeight > screenSize.height ||
        dy < 0) {
      dx = (screenSize.width - popupWidth) / 2;
      dy = (screenSize.height - totalHeight) / 2;
    }

    return Offset(dx, dy);
  }

  void _toggleReactionDetails() {
    setState(() {
      _showingReactionDetails = !_showingReactionDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final adjustedPosition =
        _getAdjustedPosition(context, widget.position, widget.popupWidth);
    bool hasReaction =
        widget.message != null && widget.message!.reactions.isNotEmpty;
    final reactedUsers = widget.message!.reactions.entries
        .toList()
        .expand((r) => r.value)
        .toList();

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _removeEmojiPicker();
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: adjustedPosition.dx,
            top: adjustedPosition.dy,
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.hasEmoji)
                    Container(
                      width: widget.popupWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...quickEmojis
                                  .map((emoji) => _buildReactionEmoji(emoji)),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.add_reaction_outlined,
                                    size: 20),
                                onPressed: _showEmojiPicker,
                              ),
                            ],
                          ),
                          if (hasReaction)
                            InkWell(
                              onTap: _toggleReactionDetails,
                              child: Container(
                                height: popupItemHeight,
                                width: widget.popupWidth,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  border: Border(
                                    top: BorderSide(
                                        color: AppTheme.gray.shade200),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${reactedUsers.length} Reactions"),
                                    StackedAvatars(
                                      users: reactedUsers,
                                      bgColors: const [
                                        Colors.blue,
                                        Colors.green,
                                        Colors.orange
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (_showingReactionDetails)
                    _buildReactionDetails()
                  else
                    Container(
                      width: widget.popupWidth,
                      margin: EdgeInsets.only(top: containerSpacing),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.popupItems
                            .map((item) => _buildOptionTile(item))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionDetails() {
    return Container(
      width: widget.popupWidth,
      margin: EdgeInsets.only(top: containerSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 18),
              onPressed: _toggleReactionDetails,
            ),
            title: Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          Divider(height: 1),
          ...widget.message!.reactions.entries.expand((entry) {
            return entry.value.map((user) {
              final initial =
                  user["name"].split(' ').map((e) => e[0]).take(2).join();
              final dateStr = user["timestamp"] != null
                  ? DateFormat('MMM dd, hh:mm a').format(user["timestamp"])
                  : "";

              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300))),
                child: ListTile(
                  horizontalTitleGap: 2,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.green,
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  title: Text(
                    user["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    dateStr,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    entry.key,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            });
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReactionEmoji(String emoji) {
    return InkWell(
      onTap: () {
        widget.handleReaction(widget.message!, emoji);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildOptionTile(PopupItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppConstants.grey300, width: 1),
        ),
      ),
      child: ListTile(
        onTap: () {
          _removeEmojiPicker();
          item.onTap();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          item.title,
          style: TextStyle(
            color: item.isDestructive ? Colors.red : Colors.grey[800],
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          item.icon,
          color: item.isDestructive ? Colors.red : Colors.grey[600],
          size: 20,
        ),
      ),
    );
  }
}
