import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NestedNavigatorScreen extends StatefulWidget {
  NestedNavigatorScreen({Key key}) : super(key: key);

  @override
  _NestedNavigatorScreenState createState() => _NestedNavigatorScreenState();
}

class _NestedNavigatorScreenState extends State<NestedNavigatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Navigator(
        initialRoute: '/',
        onGenerateRoute: (routeSettings) {
          Widget screen;

          switch (routeSettings.name) {
            case '/':
              screen = _NestedScreen(title: '/');
              break;
            default:
              screen = _NestedScreen(title: routeSettings.name);
          }

          return CupertinoPageRoute(builder: (context) => screen);
        },
      ),
    );
  }
}

class _NestedScreen extends StatelessWidget {
  const _NestedScreen({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.navigate_before),
                label: Text('Back'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 16),
              RaisedButton.icon(
                icon: Icon(Icons.navigate_next),
                label: Text('Next'),
                onPressed: () => Navigator.of(context).pushNamed('${title}next/'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
