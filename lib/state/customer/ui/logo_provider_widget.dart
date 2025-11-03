
import 'package:flutter/cupertino.dart';

import '../model/logo_model.dart';

class LogoProvierWidget extends InheritedWidget {
  final LogoModel model;
  const LogoProvierWidget({super.key, required this.model, required super.child});

  static LogoProvierWidget? of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LogoProvierWidget>();
  }

  @override
  bool updateShouldNotify(covariant LogoProvierWidget oldWidget) {
    return model != oldWidget.model;
  }
}