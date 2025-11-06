import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/model/logo_model.dart';
import 'my_inherited_widget.dart';
import 'my_provider.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MyProvider.of<LogoModel>(context);
    // 添加调试
    print('ControlPanelWidget - Model: $model');
    print('Context: $context');

    final inherited = context.dependOnInheritedWidgetOfExactType<MyInheritedWidget<LogoModel>>();
    // 添加调试
    print('ControlPanelWidget - InheritedWidget: $inherited');

    return Card(

      child: Transform.flip(
        flipX: model?.flipX ?? false,
        flipY: model?.flipY ?? false,
        child: FlutterLogo(
          size: model?.size ?? 100.0,
        ),
      ),
    );
  }
}
