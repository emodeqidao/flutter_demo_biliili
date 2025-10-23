import 'package:flutter/material.dart';

import 'animated/custom_painter_widget.dart';

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
      home: const CustomPainterWidget(),
    );
  }
}

class AsyncMain extends StatelessWidget {
  const AsyncMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Main'),
      ),
      body: const Center(
        child: Text('Async Main'),
      ),
    );
  }
}
