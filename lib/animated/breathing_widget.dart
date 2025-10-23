import 'package:flutter/material.dart';

class BreathingWidget extends StatefulWidget {
  const BreathingWidget({super.key});

  @override
  State<BreathingWidget> createState() => _BreathingWidgetState();
}
class _BreathingWidgetState extends State<BreathingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation opacityAnimation;
  late final Animation heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat(reverse: true);
    opacityAnimation = Tween(begin: 0.5, end: 1.0).animate(_controller);
    heightAnimation = Tween(begin: 200.0, end: 300.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    gradient: RadialGradient(
                        colors: [Colors.blue[500]!, Colors.blue[100]!],
                        stops: [_controller.value, _controller.value + 0.1]
                    )
                ),
              );
            },
          ),
        )
    );
  }
}