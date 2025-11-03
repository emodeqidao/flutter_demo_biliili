import 'package:flutter/material.dart';

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
  final DoubleController _controller = DoubleController(0.5);
  final sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "hello",
            style: TextStyle(fontSize: 30),
          ),
          SubItem(
            controller: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _controller.setValue(1.0);
                  },
                  child: Text("100%")),
              ElevatedButton(
                  onPressed: () {
                    _controller.setValue(0.0);
                  },
                  child: Text("0%"))
            ],
          )
        ],
      ),
    );
  }
}

class DoubleController extends ChangeNotifier {
  double _value;
  DoubleController(this._value);

  double get value => _value;

  void setValue(double value) {
    _value = value;
    notifyListeners();
  }
}

class SubItem extends StatelessWidget {
  final DoubleController controller;
  const SubItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                Text(
                  "xixi",
                  style: TextStyle(fontSize: controller.value * 100 + 12),
                ),
                FlutterLogo(
                  size: controller.value * 100 + 50,
                ),
                Slider(
                    value: controller.value,
                    onChanged: (v) {
                      controller.setValue(v);
                      print(v);
                    }),
              ],
            );
          },
        ),
      ],
    );
  }
}
