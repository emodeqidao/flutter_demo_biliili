import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/extension_context.dart';

import '../../customer_provider/model/logo_model.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogoModel>();

    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("flipX"),
                Switch(
                    value: model?.flipX ?? false,
                    onChanged: (value) {
                      model?.flipX = value;
                    }),
                const SizedBox(
                  width: 10,
                ),
                const Text("flipY"),
                Switch(
                    value: model?.flipY ?? false,
                    onChanged: (value) {
                      model?.flipY = value;
                    }),
              ],
            ),
            Slider(
                value: model?.size ?? 100.0,
                min: 50,
                max: 300,
                onChanged: (value) {
                  model?.size = value;
                }),
          ],
        ),
      ),
    );
  }
}
