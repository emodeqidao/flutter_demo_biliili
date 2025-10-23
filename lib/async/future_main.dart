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
      home: const AsyncMain(),
    );
  }
}

class AsyncMain extends StatefulWidget {
  const AsyncMain({super.key});

  @override
  State<AsyncMain> createState() => _AsyncMainState();
}

class _AsyncMainState extends State<AsyncMain> {

  Future<void> addAction() async {
    try {
      final id = await getFutureString();
      print(id);
      print(id  * 2);
    } catch (err) {
      print(err);
    }





    getFutureString().then((value) {
      print(value);
      return value * 2;
    }).then((value) {
      print(value);
    }).catchError((err) {
      print(err);
    }).whenComplete(() {
      // 不管有没有错，都会执行complete
      print('complete');
    });
  }

  Future<int> getFutureString() async {
    // return Future.value(100);
    throw 'throw error';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Main'),
      ),
      body: Center(
        child: FutureBuilder(
          // future: Future.delayed(Duration(seconds: 2), () => '我来了'),
          future: Future.delayed(Duration(seconds: 3), () => throw '有错误 '),

          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text('${snapshot.data}', style: TextStyle(fontSize: 30),);
            }

            if (snapshot.hasError) {
              return Text('${snapshot.error}', style: TextStyle(fontSize: 30),);
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
