import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? textStyle;

  const TypewriterText({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: 2),
    this.textStyle,
  });

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final visibleText = widget.text.substring(0, _animation.value);
        return Text(
          visibleText,
          style: widget.textStyle ??
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        );
      },
    );
  }
}
