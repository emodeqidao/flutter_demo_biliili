import 'package:flutter/material.dart';

class AnimatedPaddingWidget extends StatefulWidget {
  const AnimatedPaddingWidget({super.key});

  @override
  State<AnimatedPaddingWidget> createState() => _AnimatedPaddingWidgetState();
}
class _AnimatedPaddingWidgetState extends State<AnimatedPaddingWidget> {
  double _padding = 0.0;

  void _changePadding() {
    setState(() {
      _padding = _padding == 0.0 ? 250.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Padding'),
        actions: [
          ElevatedButton(
            onPressed: _changePadding,
            child: const Text('Change Padding'),
          ),
        ],
      ),
      body: AnimatedPadding(
        padding: EdgeInsets.only( top: _padding),
        duration: const Duration(seconds: 2),
        curve: Curves.bounceOut,
        child: Container(
          width: 300,
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }
}
