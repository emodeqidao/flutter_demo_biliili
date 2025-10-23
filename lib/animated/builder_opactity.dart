import 'package:flutter/material.dart';

class BuilderOpacityWidget extends StatefulWidget {
  const BuilderOpacityWidget({super.key});

  @override
  State<BuilderOpacityWidget> createState() => _BuilderOpacityWidgetState();
}

class _BuilderOpacityWidgetState extends State<BuilderOpacityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation opacityAnimation;
  late final Animation heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
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
            return Opacity(
              opacity: opacityAnimation.value,
              // opacity: Tween(begin: 0.5, end: 1.0).evaluate(_controller),
              // opacity: _controller.value,
              child: Container(
                width: 300,
                height: heightAnimation.value,
                // height: Tween(begin: 200.0, end: 300.0).evaluate(_controller),
                // height: 200 + 100 * _controller.value,
                color: Colors.red,
                child: child),
              );
          },
          child: Center(child: Text('xixi', style: TextStyle(color: Colors.white, fontSize: 60),)),
        ),
      ),
    );
  }
}
