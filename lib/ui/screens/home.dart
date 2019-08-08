import 'package:flutter/material.dart';
import 'package:playground/ui/screens/swipes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Playground")),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: OutlineButton(
              child: Text("Swipes Room"),
              onPressed: () => navigateToSwipes(context) ,
            ),
          )
        ],
      ),
    );
  }

  void navigateToSwipes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SwipesScreen();
        }
      )
    );
  }
}