import 'package:flutter/material.dart';
import 'package:flutter_demo_bilibili/server_web/network_info_service.dart';

import 'server_web/server_web_demo_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NetworkInfoService().init();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const CustomPainterWidget(),
//     );
//   }
// }
//
// class AsyncMain extends StatelessWidget {
//   const AsyncMain({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Async Main'),
//       ),
//       body: const Center(
//         child: Text('Async Main'),
//       ),
//     );
//   }
// }
