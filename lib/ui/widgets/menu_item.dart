import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    this.text,
    this.route,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: OutlineButton(
        child: Text(text),
        onPressed: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
