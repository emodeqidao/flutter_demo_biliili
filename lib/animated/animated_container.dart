import 'package:flutter/material.dart';

  class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({super.key});

  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.red;

  void _changeContainer() {
    setState(() {
      // _width = _width == 100 ? 200 : 100;
      // _height = _height == 100 ? 200 : 100;
      _width = 300;
      _height = 300;
      _color = _color == Colors.red ? Colors.blue : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            width: _width,
            height: _height,
            // color: _color,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.white],
                stops: [0.3, 0.5],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              ),
              boxShadow: [
                BoxShadow(spreadRadius: 1, blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(150)
            ),
            duration: const Duration(seconds: 2),
            // child: const Center(
            //   child: Text(
            //     'hello',
            //     style: TextStyle(color: Colors.white, fontSize: 50),
            //   ),
            // ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _changeContainer,
            child: const Text('Change Container'),
          ),
        ],
      ),
    );
  }
}
