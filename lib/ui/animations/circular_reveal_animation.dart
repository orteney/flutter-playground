import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularRevealAnimation extends StatelessWidget {
  final Offset center;
  final double minRadius;
  final double maxRadius;
  final Widget child;
  final Animation<double> animation;

  /// Creates [CircularRevealAnimation] with given params.
  /// For open animation [animation] should run forward: [AnimationController.forward].
  /// For close animation [animation] should run reverse: [AnimationController.reverse].
  ///
  /// [center] center of circular reveal. Child's center if not specified.
  /// [minRadius] minimum radius of circular reveal. 0 if not if not specified.
  /// [maxRadius] maximum radius of circular reveal. Distance from center to further child's corner if not specified.
  CircularRevealAnimation({
    @required this.child,
    @required this.animation,
    this.center,
    this.minRadius,
    this.maxRadius,
  })  : assert(child != null),
        assert(animation != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget _) {
        return ClipPath(
          clipper: _CircularRevealClipper(
            fraction: animation.value,
            center: center,
            minRadius: minRadius,
            maxRadius: maxRadius,
          ),
          child: this.child,
        );
      },
    );
  }
}

class _CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;
  final double minRadius;
  final double maxRadius;

  _CircularRevealClipper({
    @required this.fraction,
    this.center,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    final center = this.center ?? Offset(size.width / 2, size.height / 2);
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
