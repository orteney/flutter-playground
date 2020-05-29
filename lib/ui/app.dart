import 'package:flutter/material.dart';
import 'package:playground/ui/routes.dart';
import 'package:playground/ui/screens/cardtansition/cards.dart';
import 'package:playground/ui/screens/home.dart';
import 'package:playground/ui/screens/swipes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(colorScheme: _lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: _darkColorScheme),
      home: HomeScreen(),
      routes: {
        Routes.SWIPES: (context) => SwipesScreen(),
        Routes.CARDS: (context) => CardsScreen(),
      },
    );
  }
}

const ColorScheme _lightColorScheme = ColorScheme.light();
const ColorScheme _darkColorScheme = ColorScheme.dark();
