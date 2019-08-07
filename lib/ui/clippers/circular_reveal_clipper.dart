import 'dart:math';
import 'dart:ui';
import 'package:flutter/widgets.dart';

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final double xOffset;
  final double yOffset;
  final double minRadius;
  final double maxRadius;

  CircularRevealClipper({
    @required this.fraction,
    this.xOffset,
    this.yOffset,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    final center = Offset(xOffset ?? size.width / 2, yOffset ?? size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction),
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
