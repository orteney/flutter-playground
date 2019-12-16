import 'package:flutter/material.dart';
import 'package:playground/ui/routes.dart';
import 'package:playground/ui/screens/cardtansition/card_details.dart';
import 'package:playground/ui/screens/cardtansition/cards.dart';
import 'package:playground/ui/screens/home.dart';
import 'package:playground/ui/screens/swipes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        Routes.SWIPES: (context) => SwipesScreen(),
        Routes.CARDS: (context) => CardsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.CARD_DETAILS) {
          final String id = settings.arguments;
          return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return CardDetailsScreen(id: id);
            },
          );
        }
      },
    );
  }
}
