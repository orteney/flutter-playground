import 'dart:convert';

import 'package:meta/meta.dart';

class ViewModel {
  final int id;
  final String title;
  final String subTitle;

  const ViewModel({
    @required this.id,
    @required this.title,
    @required this.subTitle,
  });

  ViewModel copyWith({
    int id,
    String title,
    String subTitle,
  }) {
    return ViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
    };
  }

  static ViewModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ViewModel(
      id: map['id'],
      title: map['title'],
      subTitle: map['subTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  static ViewModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'ViewModel(id: $id, title: $title, subTitle: $subTitle)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ViewModel && o.id == id && o.title == title && o.subTitle == subTitle;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ subTitle.hashCode;
}
