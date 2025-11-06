import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/extension_context.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/model/logo_model.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();

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
