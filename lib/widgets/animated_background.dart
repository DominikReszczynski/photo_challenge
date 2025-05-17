import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Circle> _circles = [];
  final Random _rand = Random();
  late Size _screenSize;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 365),
    )
      ..addListener(_updateCircles)
      ..repeat();

    // Wait for layout to get screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      _generateCircles();
      setState(() {});
    });
  }

  void _generateCircles() {
    const int count = 10;
    const double minRadius = 5, maxRadius = 30;
    const double maxSpeed = 0.0003;

    for (int i = 0; i < count; i++) {
      double dx, dy, r;
      bool overlaps;

      do {
        r = minRadius + _rand.nextDouble() * (maxRadius - minRadius);
        dx = _rand.nextDouble();
        dy = _rand.nextDouble();
        overlaps = false;

        final x1 = dx * _screenSize.width;
        final y1 = dy * _screenSize.height;

        for (var other in _circles) {
          final x2 = other.dx * _screenSize.width;
          final y2 = other.dy * _screenSize.height;
          final dist = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
          if (dist < r + other.radius) {
            overlaps = true;
            break;
          }
        }
      } while (overlaps);

      final angle = _rand.nextDouble() * 2 * pi;
      _circles.add(_Circle(
        dx: dx,
        dy: dy,
        radius: r,
        color: _rand.nextBool()
            ? const Color(0xFF926C20)
            : const Color(0xFFE6D3C0),
        vx: cos(angle) * maxSpeed,
        vy: sin(angle) * maxSpeed,
      ));
    }
  }

  void _updateCircles() {
    for (var c in _circles) {
      double nextDx = c.dx + c.vx;
      double nextDy = c.dy + c.vy;

// reflection on the X-axis
      if (nextDx <= 0 || nextDx >= 1) {
        c.vx = -c.vx;
        nextDx = c.dx + c.vx;
      }

// reflection on the Y-axis
      if (nextDy <= 0 || nextDy >= 1) {
        c.vy = -c.vy;
        nextDy = c.dy + c.vy;
      }

      c.dx = nextDx;
      c.dy = nextDy;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _CirclePainter(_circles),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _Circle {
  double dx, dy;
  final double radius;
  final Color color;
  double vx, vy;

  _Circle({
    required this.dx,
    required this.dy,
    required this.radius,
    required this.color,
    required this.vx,
    required this.vy,
  });
}

class _CirclePainter extends CustomPainter {
  final List<_Circle> circles;
  _CirclePainter(this.circles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var c in circles) {
      paint.color = c.color;
      final offset = Offset(c.dx * size.width, c.dy * size.height);
      canvas.drawCircle(offset, c.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) => true;
}
