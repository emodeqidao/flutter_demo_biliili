
import 'dart:async';
import 'dart:math';

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
   late final StreamController<int> _inputController;
   late final StreamController _scoreController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputController = StreamController<int>.broadcast();
    _scoreController = StreamController<int>.broadcast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder(
            stream: _scoreController.stream.transform(TallyTransformer()),  //这里将scoreController 的数据流转换成新的数据流
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              int score = 0;
              if  (snapshot.hasData) {
                score = snapshot.data;
              }
              return Text("${score}", style: TextStyle(fontSize: 30),);
            },
          ),
        ),
        body: Stack(
          children: [
            /// List 并不能直接传给children,   这里可以使用 三个点   ...
            ...List.generate(5, (index) => Puzzle(inputStream: _inputController.stream, scoreStreamController: _scoreController)),
            // Puzzle(inputStream: _controller.stream),
            Align(
              alignment: Alignment.bottomCenter,
                child: KeyPad(controller: _inputController)),
          ],
        )
    );
  }
}


class TallyTransformer implements StreamTransformer<int, int> {
  int sum = 0;
  StreamController<int> _controller = StreamController<int>();

  @override
  Stream<int> bind(Stream<int> stream) {
    stream.listen((event) {
      //这里可以做过滤 做一些其它的操作
      print('event:::: ${event}');
      sum += event;
      print('sum:::: ${sum}');
      _controller.sink.add(sum);
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    //这里做类型的检查
    return StreamTransformer.castFrom<int, int, RS, RT>(this);
  }

}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;
  final StreamController scoreStreamController;
  const Puzzle({super.key, required this.inputStream, required this.scoreStreamController});

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  int a = 0;
  int b = 0;
  double x = 0;
  late Color color;
  int time = 0;
  late AnimationController _animationController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _animationController = AnimationController(vsync: this);
    reset();
    _animationController.forward();

    _animationController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        reset();
        _animationController.forward(from: 0.0);
        //这里是错误 因为动画完成了还没有计算出来
        widget.scoreStreamController.sink.add(-3);
      }
    });

    widget.inputStream.listen((int event) {
      print('我收到了： $event');
      print('a + b = ${a + b}');
      if (event == (a + b)) {
        print('命中');
        reset();
        _animationController.forward(from: Random().nextDouble());
        // 这里是算对了
        widget.scoreStreamController.sink.add(10);
      }
    });
  }

  void reset()  {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    time =  Random().nextInt(3) + 10;
    _animationController.duration = Duration(seconds: time);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: 800 * _animationController.value - 100,
          left: x,
          child: Container(
               decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(24),
                 border: Border.all(color: Colors.black, width: 2)
              ),
              padding: EdgeInsets.all(8),
              child: Text("${a} + ${b}", style: const TextStyle(fontSize: 30),)),
        );
      }
    );
  }
}




class KeyPad extends StatelessWidget {
  final StreamController<int> controller;

  const KeyPad({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2 / 1,
        shrinkWrap: true,
        children: List.generate(9, (index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.primaries[index][300],
                shape: RoundedRectangleBorder()  //这里不传值就不会是圆角
            ),
            onPressed: ()  {
              controller.sink.add(index + 1);
            },
            child: Text('${index + 1}',  style: TextStyle(fontSize: 20),),
          );
        }),
      ),
    );
  }
}
