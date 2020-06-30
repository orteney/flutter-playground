import 'package:cubit/cubit.dart';
import 'package:flutter/widgets.dart' hide AnimatedListItemBuilder;
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import '../list_item_builder.dart';
import '../view_model.dart';

class ImplicitlyReorderableAnimatedListVariant extends StatelessWidget {
  const ImplicitlyReorderableAnimatedListVariant({
    Key key,
    @required this.cubit,
    @required this.listItemBuilder,
  }) : super(key: key);

  final Cubit<List<ViewModel>> cubit;
  final AnimatedListItemBuilder<ViewModel> listItemBuilder;

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
            return listItemBuilder(context, item, animation);
          },
        );
      },
    );
  }
}
