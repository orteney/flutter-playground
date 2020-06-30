import 'package:cubit/cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

import '../list_item_builder.dart';
import '../view_model.dart';

class ImplicitlyReorderableAnimatedListVariant extends StatelessWidget {
  const ImplicitlyReorderableAnimatedListVariant({
    Key key,
    @required this.cubit,
    @required this.listItemBuilder,
  }) : super(key: key);

  final Cubit<List<ViewModel>> cubit;
  final ListItemBuilder<ViewModel> listItemBuilder;

  @override
  Widget build(BuildContext context) {
    return CubitBuilder(
      cubit: cubit,
      builder: (BuildContext context, List<ViewModel> state) {
        return ImplicitlyAnimatedList<ViewModel>(
          // The current items in the list.
          items: state,
          // Called by the DiffUtil to decide whether two object represent the same item.
          // For example, if your items have unique ids, this method should check their id equality.
          areItemsTheSame: (a, b) => a.id == b.id,
          // Called, as needed, to build list item widgets.
          // List items are only built when they're scrolled into view.
          itemBuilder: (context, animation, item, index) {
            // Specifiy a transition to be used by the ImplicitlyAnimatedList.
            // See the Transitions section on how to import this transition.
            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: listItemBuilder(context, item),
            );
          },
          // An optional builder when an item was removed from the list.
          // If not specified, the List uses the itemBuilder with
          // the animation reversed.
          removeItemBuilder: (context, animation, oldItem) {
            return FadeTransition(
              opacity: animation,
              child: listItemBuilder(context, oldItem),
            );
          },
        );
      },
    );
  }
}
