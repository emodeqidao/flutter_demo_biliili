import 'package:flutter/material.dart';

import 'logo_provider_widget.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = LogoProviderWidget.of(context);

    return Card(
      child: ListenableBuilder(
        listenable: provider!.model,
        builder: (BuildContext context, Widget? child) {
          return Transform.flip(
            flipX: provider.model.flipX,
            flipY: provider.model.flipY,
            child: FlutterLogo(
              size: provider.model.size,
            ),
          );
        },
      ),
    );
  }
}
