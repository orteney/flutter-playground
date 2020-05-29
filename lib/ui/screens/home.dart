import 'package:flutter/material.dart';
import 'package:playground/ui/routes.dart';
import 'package:playground/ui/widgets/menu_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Playground")),
      body: ListView(
        children: [
          MenuItem(text: "Swipes Room", route: Routes.swipes),
          MenuItem(text: "Cards Room", route: Routes.cards),
          MenuItem(text: "Sliver Pull To Refres", route: Routes.sliverPullToRefresh),
          MenuItem(text: "Nested Navigator", route: Routes.nestedNavigator),
        ],
      ),
    );
  }
}
