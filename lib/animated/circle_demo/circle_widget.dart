
import 'package:flutter/cupertino.dart';

import 'circle.dart';

class CircleWidget extends StatelessWidget {
  final Circle circle;
  const CircleWidget({super.key, required this.circle});

  @override
  Widget build(BuildContext context) {
    (context as Element).dependOnInheritedWidgetOfExactType();
    return Container(
      transform: Matrix4.translationValues(circle.center.dx, circle.center.dy, 0),
      width: circle.radius * 2,
      height: circle.radius * 2,
      decoration: BoxDecoration(
        color: circle.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
