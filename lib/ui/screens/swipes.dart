import 'package:flutter/material.dart';
import 'package:playground/ui/widgets/animated_toggle.dart';
import 'package:playground/ui/widgets/swipeable.dart';

class SwipesScreen extends StatefulWidget {
  SwipesScreen({Key key}) : super(key: key);

  _SwipesScreenState createState() => _SwipesScreenState();
}

class _SwipesScreenState extends State<SwipesScreen> {
  
  final items = List<bool>.from([false, false, false, false, false,false,false]);

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
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) => listItem(context, index),
        separatorBuilder: (context, index) => Divider(
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
          isToggled: items[position],
        ),
        child: Container(
          color: Colors.white70,
          child: Center(
            child: Text("Swipe Me :D"),
          ),
        ),
        onSwiped: () => _toggleFavorites(position),
        direction: SwipeDirection.startToEnd,
        swipeThreshold: 0.6,
      ),
    );
  }
}