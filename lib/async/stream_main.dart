import 'dart:async';

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
  final future = Future.delayed(Duration(seconds: 3), () => '123');
  final stream = Stream.periodic(Duration(seconds: 1), (_) => "222");

  // final streamController = StreamController();
  final streamController = StreamController.broadcast();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      streamController.stream.listen((event) {
        print(event);
      },
        onError: (error) {
          print(error);
        },
        onDone: () {
          print('done');
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Async Main'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.waiting:
                  return Text('waiting');
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return Text(
                      'active: error: ${snapshot.error}',
                      style: TextStyle(fontSize: 30),
                    );
                  }
                  return Text(
                    'active:  ${snapshot.data}',
                    style: TextStyle(fontSize: 30),
                  );
                case ConnectionState.done:
                  return Text('done');
              }
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                streamController.sink.add(100);
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                streamController.sink.add(20);
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                streamController.sink.addError('我是 error');
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                streamController.sink.close();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }
}
