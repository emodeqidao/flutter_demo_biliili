import 'package:flutter/material.dart';

class TransitionStaggerWidget extends StatefulWidget {
  const TransitionStaggerWidget({super.key});

  @override
  State<TransitionStaggerWidget> createState() =>
      _TransitionStaggerWidgetState();
}

class _TransitionStaggerWidgetState extends State<TransitionStaggerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
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
        child: Column(
          children: [
            BoxWidget(
                controller: _controller,
                color: Colors.red[100]!,
                interval: Interval(0, 0.2)),
            BoxWidget(
                controller: _controller,
                color: Colors.red[300]!,
                interval: Interval(0.2, 0.4)),
            FadeTransition(
              opacity: Tween(begin: 0.5, end: 1.0)
                  .chain(CurveTween(curve: Interval(0.4, 0.6)))
                  .animate(_controller),
              child: Container(
                width: 250,
                height: 100,
                color:  Colors.red[500]!,
              ),
            ),
            BoxWidget(
                controller: _controller,
                color: Colors.red[700]!,
                interval: Interval(0.6, 0.8)),
            BoxWidget(
                controller: _controller,
                color: Colors.red[900]!,
                interval: Interval(0.8, 1.0)),
          ],
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;
  const BoxWidget(
      {super.key,
      required this.controller,
      required this.color,
      required this.interval});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.2, 0.0),
      )
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(controller),
      child: Container(
        width: 250,
        height: 100,
        color: color,
      ),
    );
  }
}
