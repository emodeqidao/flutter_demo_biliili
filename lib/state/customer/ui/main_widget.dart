import 'package:flutter/material.dart';

import 'logo_provider_widget.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = LogoProviderWidget.of(context);

    return Card(
      child: ListenableBuilder(
        listenable: provider!.model,
        builder: (BuildContext context, Widget? child) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("flipX"),
                    Switch(
                        value: provider.model.flipX,
                        onChanged: (value) {
                          provider.model.flipX = value;
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text("flipY"),
                    Switch(
                        value: provider.model.flipY,
                        onChanged: (value) {
                          provider.model.flipY = value;
                        }),
                  ],
                ),
                Slider(
                    value: provider.model.size,
                    min: 50,
                    max: 300,
                    onChanged: (value) {
                      provider?.model.size = value;
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
