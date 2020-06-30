import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart' hide AnimatedListItemBuilder;

import '../list_item_builder.dart';
import '../view_model.dart';

class AnimatedStreamListVariant extends StatelessWidget {
  const AnimatedStreamListVariant({
    Key key,
    @required this.cubit,
    @required this.listItemBuilder,
  }) : super(key: key);

  final Cubit<List<ViewModel>> cubit;
  final AnimatedListItemBuilder<ViewModel> listItemBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedStreamList<ViewModel>(
      //* Should be ModifiableList, so creating copy
      initialList: cubit.state.toList(),
      streamList: cubit,
      itemBuilder: _animatedListItemBuilder,
      itemRemovedBuilder: _animatedListItemBuilder,
    );
  }

  Widget _animatedListItemBuilder(ViewModel item, int index, BuildContext context, Animation<double> animation) {
    return listItemBuilder(context, item, animation);
  }
}
