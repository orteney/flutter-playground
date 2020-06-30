import 'package:flutter/widgets.dart';

typedef Widget ListItemBuilder<T>(
  BuildContext context,
  T item,
);

typedef Widget AnimatedListItemBuilder<T>(
  BuildContext context,
  T item,
  Animation<double> animation,
);
