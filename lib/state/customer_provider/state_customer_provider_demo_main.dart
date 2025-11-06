import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/state/customer_provider/ui/my_provider.dart';

import '../customer_provider/ui/logo_widget.dart';
import '../customer_provider/ui/control_panel_widget.dart';
import '../customer_provider/model/logo_model.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyProvider(create: () => LogoModel(),
      child: const MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            ControlPanelWidget(),
          ],
        ),
      ),
    );
  }
}
