import 'package:flutter/material.dart';
import 'package:playground/ui/widgets/animated_toggle.dart';
import 'package:playground/ui/widgets/swipeable.dart';

class SwipesScreen extends StatefulWidget {
  SwipesScreen({Key key}) : super(key: key);

  _SwipesScreenState createState() => _SwipesScreenState();
}

class _SwipesScreenState extends State<SwipesScreen> {
  final items = List<bool>.from([false, false, false, false, false, false, false]);

  void _toggleFavorites(int index) {
    setState(() {
      items[index] = !items[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipes Room"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) => listItem(context, index),
        separatorBuilder: (context, index) => Divider(
          color: Colors.transparent,
          height: 1,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listItem(BuildContext context, int position) {
    return Container(
      height: 150,
      child: Swipeable(
        background: AnimatedToggle(
          duration: Duration(milliseconds: 250),
          isToggled: items[position],
        ),
        child: Material(
          elevation: 1,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Swipe Me :D"),
                FlatButton(
                  child: Text("Click Me :D"),
                  onPressed: () => _toggleFavorites(position),
                )
              ],
            ),
          ),
        ),
        onSwiped: () => _toggleFavorites(position),
        direction: SwipeDirection.startToEnd,
        swipeThreshold: 0.5,
      ),
    );
  }
}
