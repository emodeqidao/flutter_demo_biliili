
import 'package:flutter/material.dart';

class TransitionTweenWidget extends StatefulWidget {
  const TransitionTweenWidget({super.key});

  @override
  State<TransitionTweenWidget> createState() => _TransitionTweenWidgetState();
}

class _TransitionTweenWidgetState extends State<TransitionTweenWidget> with SingleTickerProviderStateMixin {
  double angle = 0.0;

  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,  //不同设备刷新帧数不一样，有些60 有些是120
      duration: const Duration(seconds: 5),
    );

    // _controller.addListener(() {
    //   print("${_controller.value}");
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  void _rotate() {

    _controller.repeat();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Action'),
        actions: [
          ElevatedButton(
            onPressed: _rotate,
            child: const Text('Action'),
          ),
        ],
      ),
      body: Center(
        child: SlideTransition(
          position: Tween(begin: Offset(0, 0), end: Offset(1, 0))
              .chain(CurveTween(curve: Interval(0.8, 1.0)))
              .animate(_controller),

          // position: _controller.drive(Tween(begin: Offset(0, 0), end: Offset(1, 0))),
          child: Container(width: 50, height: 50, color: Colors.purple,),
        ),
        // child: ScaleTransition(
        //     scale: _controller.drive(Tween(begin: 0.5, end: 2.0)),
        //     child: Container(width: 50, height: 50, color: Colors.purple,)
        // ),
      ),
    );
  }
}
