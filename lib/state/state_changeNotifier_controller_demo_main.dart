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
        title: const Text('ChangeNotifier'),
      ),
      body: Center(
        child: Counter(controller: counterController,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.reset();
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
      listenable: controller,
      builder: (context, child) {
        print("listenableBuilder");
        return ElevatedButton(
            onPressed: () {
              controller.count = 2;
            },
            child: Text(
              'Counter: ${controller.count}',
              style: TextStyle(fontSize: 30),
            ),
        );
      },
    );
  }
}

class CounterController extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set count(int value) {
    _count = value;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}