
import 'package:flutter/material.dart';

class AnimatedTweenWidget extends StatefulWidget {
  const AnimatedTweenWidget({super.key});

  @override
  State<AnimatedTweenWidget> createState() => _AnimatedTweenWidgetState();
}

class _AnimatedTweenWidgetState extends State<AnimatedTweenWidget> {
  double fontSize = 100;

  void _changeFontSize() {
    setState(() {
      fontSize = fontSize == 72.0 ? 172.0 : 72.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Tween'),
        actions: [
          ElevatedButton(
            onPressed: _changeFontSize,
            child: const Text('Change FontSize'),
          ),
        ],
      ),
      // body: Center(
      //   child: TweenAnimationBuilder(
      //     tween: Tween(begin: 0.0, end: 6.28),
      //     duration: Duration(seconds: 1),
      //     builder: (context, value, child2) {
      //       return Container(
      //         width: 300,
      //         height: 300,
      //         color: Colors.purple,
      //         child: Center(
      //           child: Transform.translate(
      //             offset: const Offset(50, 50),
      //             child: Text(
      //               "xixi",
      //               style: TextStyle(color: Colors.white, fontSize: 50),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),

      body: TweenAnimationBuilder(
        curve: Curves.bounceOut, // 添加动画曲线
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(begin: 72.0, end: fontSize),
        builder: (context, value, child) {
          return Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.purple,
              child: Center(
                child: Text(
                  "xixi",
                  style: TextStyle(fontSize: value),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
