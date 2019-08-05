import 'package:flutter/material.dart';
import 'package:playground/ui/widgets/animated_toggle.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFavorited = false;

  void _toggleFavorites() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 150,
          child: AnimatedToggle(
            isToggled: _isFavorited,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFavorites,
        tooltip: 'Toggle',
        child: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
