import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterWidget extends StatefulWidget {
  const CustomPainterWidget({super.key});

  @override
  State<CustomPainterWidget> createState() => _CustomPainterWidgetState();
}

class _CustomPainterWidgetState extends State<CustomPainterWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  List<Snowflake> snowflakes = List.generate(100, (index) => Snowflake());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Painter Widget'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: AnimatedBuilder(
          animation: _controller,

          builder: (BuildContext context, Widget? child) {
            snowflakes.forEach((element) {element.fall();});
            return  CustomPaint(
              painter: MyPainter(snowflakes),
            );
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter  {
  List<Snowflake> snowflakes;

  MyPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()..color = Colors.white;
    // 画一个圆形
    canvas.drawCircle(size.center(Offset(0, 110)), 60, paint);
    //  画一个椭圆形
    canvas.drawOval(
      Rect.fromCenter(
        center: size.center(Offset(0, 280)),
        width: 200,
        height: 250,
      ),
        paint,
    );

     snowflakes.forEach((snowflake) {
       canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, paint);
     });

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 1 + 0.2;

  fall() {
    y += velocity;
    if (y > 800) {
      y = Random().nextDouble() * 800;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 1 + 0.2;
    }
  }
}
