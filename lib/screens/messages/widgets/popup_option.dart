import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/screens/messages/group_chat_screen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupItem {
  final IconData icon;
  final String title;
  final bool isDestructive;
  final VoidCallback onTap;

  const PopupItem(
      {Key? key,
      required this.icon,
      required this.title,
      this.isDestructive = false,
      required this.onTap});
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

  @override
  Widget build(BuildContext context) {
    final adjustedPosition =
        _getAdjustedPosition(context, widget.position, widget.popupWidth);

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
                      height: popupItemHeight,
                      margin: EdgeInsets.only(bottom: containerSpacing),
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
                      child: Row(
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
                    ),
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
