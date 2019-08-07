import 'package:flutter/material.dart';
import 'package:playground/ui/clippers/circular_reveal_clipper.dart';

class AnimatedToggle extends ImplicitlyAnimatedWidget {
  AnimatedToggle({
    Key key,
    @required this.isToggled,
  }) : super(
          key: key,
          duration: Duration(milliseconds: 250),
        );

  final bool isToggled;

  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends AnimatedWidgetBaseState<AnimatedToggle> {
  Tween<double> _animationTween;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        ClipPath(
          clipper: CircularRevealClipper(
            fraction: _animationTween?.evaluate(animation),
            xOffset: 44,
          ),
          child: Container(color: Colors.blueAccent),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Icon(
            Icons.flag,
            color: Colors.black,
            size: calcIconSize(),
          ),
        )
      ],
    );
  }

  double calcIconSize() {
    return Curves.elasticOut.transform(_animationTween?.evaluate(animation) ?? 1) * 24;
  }

  @override
  void forEachTween(visitor) {
    _animationTween = visitor(_animationTween, widget.isToggled ? 1.0 : 0.0, (dynamic value) => Tween<double>(begin: value));
  }
}