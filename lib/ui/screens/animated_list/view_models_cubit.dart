import 'dart:math';

import 'package:cubit/cubit.dart';
import 'package:playground/ui/screens/animated_list/view_model.dart';

class ViewModelsCubit extends Cubit<List<ViewModel>> {
  ViewModelsCubit() : super(_initialViewModels);

  final Random _random = Random();

  void restoreToInitial() {
    emit(_initialViewModels);
  }

  void sortList() {
    final newList = state.toList();
    newList.sort((a, b) => a.id.compareTo(b.id));
    emit(newList);
  }

  void removeModel(ViewModel model) {
    final newList = state.toList();
    newList.remove(model);
    emit(newList);
  }

  void addNewModel() {
    int newId;

    do {
      newId = _random.nextInt(999);
    } while (state.firstWhere((element) => element.id == newId, orElse: () => null) != null);

    final newModel = ViewModel(
      id: newId,
      title: 'Generated Model',
      subTitle: 'SomeText',
    );

    final newList = state.toList();
    newList.insert(2, newModel);
    emit(newList);
  }
}

const List<ViewModel> _initialViewModels = [
  ViewModel(
    id: 5,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 2,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 3,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 4,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 1,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 6,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 7,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 8,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 9,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 10,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 11,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 12,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
  ViewModel(
    id: 13,
    title: 'SomeText',
    subTitle: 'SomeText',
  ),
];
