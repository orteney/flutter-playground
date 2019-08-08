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
    return Container(
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ClipPath(
            clipper: CircularRevealClipper(
              fraction: calcClipperFraction(),
              xOffset: 44,
            ),
            child: Container(color: const Color(0xFF0058AC)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Icon(
              Icons.flag,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
    );
  }

  double calcIconSize() {
    return Curves.elasticOut.transform(_animationTween?.evaluate(animation) ?? 1) * 36;
  }

  double calcClipperFraction() {
    return Curves.easeInOutQuart.transform(_animationTween?.evaluate(animation) ?? 0);
  }

  @override
  void forEachTween(visitor) {
    _animationTween =
        visitor(_animationTween, widget.isToggled ? 1.0 : 0.0, (dynamic value) => Tween<double>(begin: value));
  }
}
