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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Main'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("我是第一行", style: TextStyle(fontSize: 30),),
          // _buildSingleChildScrollViewAndRow(),
          _buildListViewAndStack(),
          Text('我是最后一行', style: TextStyle(fontSize: 30),),
        ],
      ),
    );
  }

  Widget _buildListViewAndStack(){
    return Stack(
      children: [
        IgnorePointer(child: Opacity(opacity: 0.0, child: Item())),
        SizedBox(width: double.infinity,),
        Positioned.fill(child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 100,
            itemBuilder: (context, index) {
              return Item();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSingleChildScrollViewAndRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FlutterLogo(size: 50,),
          for (int i = 0; i < 10; i++) Item(),
          FlutterLogo(size: 150,)
        ],
      ),
    );
  }

  Widget Item()   {
    return Card(
      child: Column(
        children: [
          Text("hello", style: TextStyle(fontSize: 20),)
          ,
          Text("Hi", style: TextStyle(fontSize: 30),)
        ],
      ),
    );
  }
}
