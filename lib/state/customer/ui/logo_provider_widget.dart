
import 'package:flutter/cupertino.dart';

import '../model/logo_model.dart';

class LogoProviderWidget extends InheritedWidget {
  final LogoModel model;
  const LogoProviderWidget({super.key, required this.model, required super.child});

  static LogoProviderWidget? of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LogoProviderWidget>();
  }

  @override
  bool updateShouldNotify(covariant LogoProviderWidget oldWidget) {
    print('updateShouldNotify');
    return model != oldWidget.model;
  }
}