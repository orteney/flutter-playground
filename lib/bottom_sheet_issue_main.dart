import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _themeMode,
      theme: _applyBottomSheetTheme(ThemeData.light()),
      darkTheme: _applyBottomSheetTheme(ThemeData.dark()),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: RaisedButton(
                child: Text("Show Theme sheet"),
                onPressed: () => _showThemeBottomSheet(context),
              ),
            );
          },
        ),
      ),
    );
  }

  ThemeData _applyBottomSheetTheme(ThemeData theme) {
    return theme.copyWith(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeBottomSheet(
          themeMode: _themeMode,
          onThemeModeChanged: (mode) {
            setState(() {
              _themeMode = mode;
            });
          },
        );
      },
    );
  }
}

class ThemeBottomSheet extends StatefulWidget {
  ThemeBottomSheet({
    Key key,
    this.themeMode,
    this.onThemeModeChanged,
  }) : super(key: key);

  final ThemeMode themeMode;
  final Function(ThemeMode themeMode) onThemeModeChanged;

  _ThemeBottomSheetState createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  ThemeMode _themeMode;

  @override
  void initState() {
    _themeMode = widget.themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(
              label: Text('System'),
              selected: _themeMode == ThemeMode.system,
              onSelected: (selected) => _selectThemeMode(ThemeMode.system),
            ),
            ChoiceChip(
              label: Text('Light'),
              selected: _themeMode == ThemeMode.light,
              onSelected: (selected) => _selectThemeMode(ThemeMode.light),
            ),
            ChoiceChip(
              label: Text('Dark'),
              selected: _themeMode == ThemeMode.dark,
              onSelected: (selected) => _selectThemeMode(ThemeMode.dark),
            ),
          ],
        ),
      ],
    );
  }

  void _selectThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
      widget.onThemeModeChanged(mode);
    });
  }
}
