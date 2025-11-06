
import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/ui/my_provider.dart';

extension MyContext on BuildContext {
  T? read<T>() {
    return MyProvider.of<T>(this);
  }

  T? watch<T>() {
    return MyProvider.of<T>(this, listen: true);
  }
}
