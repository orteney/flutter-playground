import 'package:cubit/cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../list_item_builder.dart';
import '../view_model.dart';

class ListViewVariant extends StatelessWidget {
  const ListViewVariant({
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
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (BuildContext context, int index) {
            return listItemBuilder(context, state[index]);
          },
        );
      },
    );
  }
}
