import 'package:flutter/cupertino.dart';

class MyInheritedWidget<T> extends InheritedWidget {
  final T model;
  const MyInheritedWidget({super.key, required this.model, required super.child});

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    print('updateShouldNotify');
    return oldWidget.model != model;
  }
}