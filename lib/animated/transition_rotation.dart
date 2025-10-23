import 'package:flutter/material.dart';

class TransitionRotationWidget extends StatefulWidget {
  const TransitionRotationWidget({super.key});

  @override
  State<TransitionRotationWidget> createState() => _TransitionRotationWidgetState();
}

class _TransitionRotationWidgetState extends State<TransitionRotationWidget> with SingleTickerProviderStateMixin {
  double angle = 0.0;

  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,  //不同设备刷新帧数不一样，有些60 有些是120
      duration: const Duration(seconds: 1),
      lowerBound: 2.0,
      upperBound: 4.0,
    );

    _controller.addListener(() {
      print("${_controller.value}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  void _rotate() {
    // 向前一次
    // _controller.forward();
    // // 重复动画
    _controller.repeat(reverse: true);
    // // 停止动画
    // _controller.reset();
    //
    // _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transition Rotation'),
        actions: [
          ElevatedButton(
            onPressed: _rotate,
            child: const Text('Rotate'),
          ),
        ],
      ),
      body: Center(
        child: ScaleTransition(
          scale: _controller,
          child: Icon(Icons.refresh, size: 100, color: Colors.purple,)
        ),
      ),
    );
  }
}
