import 'package:flutter/material.dart';
import 'package:playground/ui/routes.dart';
import 'package:playground/ui/screens/cardtansition/cards.dart';
import 'package:playground/ui/screens/complex_pull_to_refresh/pull_to_refersh.dart';
import 'package:playground/ui/screens/home.dart';
import 'package:playground/ui/screens/inner_navigator/nested_navigator.dart';
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
        Routes.swipes: (context) => SwipesScreen(),
        Routes.cards: (context) => CardsScreen(),
        Routes.sliverPullToRefresh: (context) => SliverPullToRefresh(),
        Routes.nestedNavigator: (context) => NestedNavigatorScreen(),
      },
    );
  }
}

const ColorScheme _lightColorScheme = ColorScheme.light();
const ColorScheme _darkColorScheme = ColorScheme.dark();
