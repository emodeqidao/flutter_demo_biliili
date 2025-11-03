import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CounterController counterController = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueNotifier'),
      ),
      body: Center(
        child: Counter(controller: counterController,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.count.value = 0;
          counterController.fontSize.value = 30;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final CounterController controller;
  const Counter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller.count, controller.fontSize]),
      builder: (context, child) {
        print("listenableBuilder");
        return ElevatedButton(
            onPressed: () {
              controller.count.value++;
              controller.fontSize.value += 5;
            },
            child: Text(
              'Counter: ${controller.count.value}',
              style: TextStyle(fontSize: controller.fontSize.value),
            ),
        );
      },
    );
  }
}

class CounterController  {
  ValueNotifier<int> count = ValueNotifier(0);
  ValueNotifier<double> fontSize = ValueNotifier(30);

}