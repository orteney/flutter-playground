import 'package:cubit/cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

import '../list_item_builder.dart';
import '../view_model.dart';

class ImplicitlyAnimatedListVariant extends StatelessWidget {
  const ImplicitlyAnimatedListVariant({
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
        return ImplicitlyAnimatedList(
          itemData: state,
          itemBuilder: listItemBuilder,
        );
      },
    );
  }
}
