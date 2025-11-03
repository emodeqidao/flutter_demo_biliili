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
      home: MyColor(
          color: Colors.purpleAccent,
          child: const MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color _color = Colors.brown;

  @override
  Widget build(BuildContext context) {
    return MyColor( /// MainPage 上层还有一个MyColor ，但是会读取最近的一个
      color: _color,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('MainPage'),
            ),
            const Foo(), // 这里加了const 可以防止被setstate 重新build，但是Foo 内部color + updateShouldNotify 的判断来进行是否需要重新build
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          setState(() {
            _color = Colors.blue;
          });
        }),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  const Foo({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: MyColor.of(context).color,
    );
  }
}

class MyColor extends InheritedWidget {
  final Color color;
  const MyColor({super.key, required this.color, required super.child});

  static of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>();
  }

  @override
  bool updateShouldNotify(covariant MyColor oldWidget) {
    return oldWidget.color != color;
  }
}
