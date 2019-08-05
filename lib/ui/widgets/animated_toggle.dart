import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  AnimatedToggle({
    Key key,
    @required this.isToggled,
  }) : super(key: key);

  final bool isToggled;

  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isToggled,
      onChanged: null,
    );
  }
}
