import 'package:flutter/material.dart';
import 'my_inherited_widget.dart';

class MyProvider<T extends Listenable> extends StatefulWidget {
  final T Function() create;
  final Widget child;
  const MyProvider({super.key, required this.child, required this.create});

  @override
  State<MyProvider> createState() => _MyProviderState();

  // static T? of<T> (BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget<T>>()?.model;
  // }

  static T? of<T>(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<MyInheritedWidget<T>>();
    if (inherited != null) {
      return inherited.model;
    }

    // 如果直接找不到，尝试在祖先中查找
    final ancestor = context.getElementForInheritedWidgetOfExactType<MyInheritedWidget<T>>()?.widget;
    if (ancestor is MyInheritedWidget<T>) {
      return ancestor.model;
    }

    // 最后尝试：遍历查找任何 MyInheritedWidget
    context.visitAncestorElements((element) {
      final widget = element.widget;
      if (widget is MyInheritedWidget && widget.model is T) {
        return false; // 停止遍历
      }
      return true; // 继续遍历
    });

    print('❌ MyProvider.of<$T>: No MyInheritedWidget found in ancestors');
    return null;
  }
}

class _MyProviderState<T extends Listenable> extends State<MyProvider<T>> {

  late T model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.create();
    print("12: $model");
  }

  @override
  Widget build(BuildContext context) {
    print('build MyProvider');
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
