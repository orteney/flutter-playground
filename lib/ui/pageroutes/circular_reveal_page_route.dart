import 'package:flutter/material.dart';

import 'package:playground/ui/animations/circular_reveal_animation.dart';

class CircularRevealPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final Offset center;

  @override
  final bool fullscreenDialog;

  CircularRevealPageRoute({
    this.builder,
    this.center,
    this.fullscreenDialog = false,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return builder(context);
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return CircularRevealAnimation(
              animation: animation,
              center: center,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
        );
}
