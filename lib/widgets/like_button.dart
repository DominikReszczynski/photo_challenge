import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final int likeCount;
  final VoidCallback onTap;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likeCount,
    required this.onTap,
  });

  @override
  State<LikeButton> createState() => _LikeInfoBoxState();
}

class _LikeInfoBoxState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  final bool _wasLiked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border,
              key: ValueKey<bool>(widget.isLiked),
              color: widget.isLiked ? Colors.red : Colors.grey,
            ),
          ),
          const SizedBox(width: 4),
          Text('${widget.likeCount}'),
        ],
      ),
    );
  }
}
