import 'package:flutter/material.dart';
import 'package:playground/ui/clippers/circular_reveal_clipper.dart';

class AnimatedToggle extends StatefulWidget {
  AnimatedToggle({
    Key key,
    @required this.isToggled,
    @required this.duration,
  }) : super(key: key);

  final bool isToggled;
  final Duration duration;

  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> with SingleTickerProviderStateMixin<AnimatedToggle> {
  AnimationController _controller;

  CurvedAnimation _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      value: widget.isToggled ? 1 : 0,
    );

    _backgroundAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  void didUpdateWidget(AnimatedToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;

    if (widget.isToggled != oldWidget.isToggled) {
      if (widget.isToggled) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CircularAnimatedWidget(
          animation: _backgroundAnimation,
          xOffset: 50,
          child: Container(color: const Color(0xFF0058AC)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            size: 36,
            progress: _controller,
          ),
        )
      ],
    );
  }
}

class CircularAnimatedWidget extends AnimatedWidget {
  CircularAnimatedWidget({
    this.child,
    this.animation,
    this.xOffset,
    this.yOffset,
  }) : super(listenable: animation);

  final Widget child;
  final Animation<double> animation;
  final double xOffset;
  final double yOffset;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CircularRevealClipper(
        fraction: animation.value,
        xOffset: xOffset,
      ),
      child: child,
    );
  }
}
