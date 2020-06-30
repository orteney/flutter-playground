import 'package:flutter/material.dart';

import 'package:playground/ui/screens/animated_list/list_variants/animated_stream_list.dart';
import 'package:playground/ui/screens/animated_list/list_variants/implicitly_animated_list.dart';
import 'package:playground/ui/screens/animated_list/list_variants/implicitly_reorderable_animated_list.dart';
import 'package:playground/ui/screens/animated_list/list_variants/listview.dart';
import 'package:playground/ui/screens/animated_list/view_models_cubit.dart';

import 'view_model.dart';

class AnimatedListScreen extends StatefulWidget {
  AnimatedListScreen({Key key}) : super(key: key);

  @override
  _AnimatedListScreenState createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final _pageStorageBucket = PageStorageBucket();

  ViewModelsCubit _cubit;
  List<_ListVariant> _variants;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = ViewModelsCubit();

    _variants = [
      _ListVariant(
        shortName: 'VLV',
        name: 'Vanila List View',
        widget: ListViewVariant(
          key: PageStorageKey('list_view'),
          cubit: _cubit,
          listItemBuilder: _listItemBuilder,
        ),
      ),
      _ListVariant(
        shortName: 'ASL',
        name: 'Animated Stream List',
        widget: AnimatedStreamListVariant(
          key: PageStorageKey('animated_stream_list'),
          cubit: _cubit,
          listItemBuilder: _listItemBuilder,
        ),
      ),
      _ListVariant(
        shortName: 'IRAL',
        name: 'Implicitly Reorderable Animated List',
        widget: ImplicitlyReorderableAnimatedListVariant(
          key: PageStorageKey('implicitly_reorderable_animated_list'),
          cubit: _cubit,
          listItemBuilder: _listItemBuilder,
        ),
      ),
      _ListVariant(
        shortName: 'IAL',
        name: 'Implicitly Animated List (broken)',
        widget: ImplicitlyAnimatedListVariant(
          key: PageStorageKey('implicitly_animated_list'),
          cubit: _cubit,
          listItemBuilder: _listItemBuilder,
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<int>(
          isExpanded: true,
          isDense: true,
          iconEnabledColor: Theme.of(context).primaryIconTheme.color,
          value: _currentIndex,
          items: _variants.mapIndexed(
            (index, item) => DropdownMenuItem(
              child: Text(item.name),
              value: index,
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            final textStyle = Theme.of(context).primaryTextTheme.headline6;
            return _variants.map<Widget>((_ListVariant item) {
              return Text(
                item.shortName,
                style: textStyle,
              );
            }).toList();
          },
          onChanged: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: _cubit.restoreToInitial,
            tooltip: 'Restore to default',
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _cubit.sortList,
            tooltip: 'Sort by ID',
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _cubit.addNewModel,
            tooltip: 'Add new item',
          ),
        ],
      ),
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: _variants[_currentIndex].widget,
      ),
    );
  }

  Widget _listItemBuilder(BuildContext context, ViewModel item) {
    return Card(
      key: ValueKey(item.id),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(item.id.toString()),
        ),
        title: Text(item.title),
        subtitle: Text(item.subTitle),
        trailing: FlatButton(
          child: Text('REMOVE'),
          textColor: Colors.red,
          onPressed: () => _cubit.removeModel(item),
        ),
      ),
    );
  }
}

class _ListVariant {
  final String name;
  final String shortName;
  final Widget widget;

  _ListVariant({@required this.name, @required this.shortName, @required this.widget});
}

extension _Map<T> on List<T> {
  List<R> mapIndexed<R>(R Function(int index, T item) mapper) {
    final newList = <R>[];
    for (var i = 0; i < length; i++) {
      newList.add(mapper(i, this[i]));
    }
    return newList;
  }
}
