import 'package:flutter/material.dart';
import 'my_inherited_widget.dart';

class MyProvider<T extends Listenable> extends StatefulWidget {
  final T Function() create;
  final Widget child;
  const MyProvider({super.key, required this.child, required this.create});

  @override
  State<MyProvider<T>> createState() => _MyProviderState<T>();

  static T? of<T> (BuildContext context, {bool listen = false}) {
    if (listen) {
      // 这个会产生依赖
      return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget<T>>()?.model;
    } else {
      // 这个不会产生依赖
      return context.getInheritedWidgetOfExactType<MyInheritedWidget<T>>()?.model;
    }
  }
}

class _MyProviderState<T extends Listenable> extends State<MyProvider<T>> {

  late T model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (BuildContext context, Widget? child) {
        return MyInheritedWidget(
        model: model,
        child: widget.child,
      );
      },
    );
  }
}
