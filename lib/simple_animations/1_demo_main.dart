import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/animation_controller_extension/animation_controller_extension.dart';
import 'package:simple_animations/animation_developer_tools/animation_developer_tools.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      body: Center(
        child: TopWidget(),
      ),
    );
  }
}

class SimplePlayAnimation extends StatelessWidget {
  const SimplePlayAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      developerMode: true,
      delay: Duration(seconds: 10),
      onStarted: () {
        print('onStarted');
      },
      onCompleted: () {
        print('onCompleted');
      },
      tween: Tween(begin: 100.0, end: 200.0),
      duration: Duration(seconds: 2),
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          width: value,
          height: value,
          color: Colors.red,
        );
      },
    );
  }
}

class RotatingBox extends StatelessWidget {
  const RotatingBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<double>(
      developerMode: true,
      tween: Tween(begin: 0.0, end: 2 * pi), // 0° to 360° (2π)
      duration: const Duration(seconds: 2), // for 2 seconds per iteration
      builder: (context, value, _) {
        return Transform.rotate(
          angle: value, // use value
          child: Container(color: Colors.blue, width: 100, height: 100),
        );
      },
    );
  }
}


class ColorFadeLoop extends StatelessWidget {
  const ColorFadeLoop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MirrorAnimationBuilder plays forever: alternating forward and backward
    return MirrorAnimationBuilder<Color?>(
      tween: ColorTween(begin: Colors.red, end: Colors.blue), // red to blue
      duration: const Duration(seconds: 5), // for 5 seconds per iteration
      builder: (context, value, _) {
        return Container(
          color: value, // use animated value
          width: 100,
          height: 100,
        );
      },
    );
  }
}

class MoreTween extends StatefulWidget {
  const MoreTween({super.key});

  @override
  State<MoreTween> createState() => _MoreTweenState();
}

class _MoreTweenState extends State<MoreTween> {
  final tween = MovieTween()
    ..tween('x', Tween(begin: -100.0, end: 100.0),
        duration: const Duration(seconds: 1))
        .thenTween('y', Tween(begin: -100.0, end: 100.0),
        duration: const Duration(seconds: 4))
        .tween('color', ColorTween(begin: Colors.red, end: Colors.blue))
        // .tween('width', Tween(begin: 100.0, end: 150.0))
        .thenTween('x', Tween(begin: 100.0, end: -100.0),
        duration: const Duration(seconds: 1))
    .thenTween('211', Tween(begin: 100.0, end: 200.0), duration: const Duration(seconds: 5))
        // .tween('width', Tween(begin: 150.0, end: 100.0))
        .thenTween('y', Tween(begin: 100.0, end: -100.0),
        duration: const Duration(seconds: 2));

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder<Movie>(
      tween: tween, // Pass in tween
      duration: tween.duration, // Obtain duration
      builder: (context, value, child) {
        return Transform.translate(
          // Get animated offset
          offset: Offset(value.get('x'), value.get('y')),
          child: Container(
            // width: value.get('width'),
            width: 100,
            height: 100,
            color: value.get('color'),
          ),
        );
      },
    );
  }
}

class MyAnimationMix extends StatefulWidget {
  const MyAnimationMix({Key? key}) : super(key: key);



  @override
  _MyAnimationMixState createState() => _MyAnimationMixState();
}

class _MyAnimationMixState extends State<MyAnimationMix> with
    AnimationMixin {
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.duration = Duration(seconds: 3);
    sizeAnimation = Tween(begin: 10.0, end: 100.0).animate(controller);

    Future.delayed(Duration(seconds: 5), () {
      controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: sizeAnimation.value,
      height: sizeAnimation.value,
      color: Colors.purpleAccent,
    );
  }
}

class TopWidget extends StatefulWidget {
  const TopWidget({super.key});

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> with AnimationMixin {
  double screenWidth = 0;
  MovieTween? tween;
  bool isPlaying = false;
  Control control = Control.stop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {

        screenWidth = MediaQuery.of(context).size.width;
        tween = MovieTween()
        // 第一阶段：从右侧进入 (0.5秒)
          ..scene(
            begin: Duration.zero,
            end: const Duration(milliseconds: 500),
          ).tween('x', Tween<double>(begin: screenWidth, end: 0))

        // 第二阶段：停留5秒 - 创建一个空场景，x值保持不变
          ..scene(
            begin: const Duration(milliseconds: 500),
            end: const Duration(milliseconds: 5500), // 500ms + 5000ms = 5500ms
          ).tween('x', ConstantTween<double>(0)) // 使用 ConstantTween 保持x值不变

        // 第三阶段：向左移出 (0.5秒)
          ..scene(
            begin: const Duration(milliseconds: 5500),
            end: const Duration(milliseconds: 6000), // 5500ms + 500ms = 6000ms
          ).tween('x', Tween<double>(begin: 0, end: -screenWidth));

        // tween = MovieTween()
        //   ..tween('x', Tween<double>(begin: screenWidth, end: 0),
        //       duration: Duration(milliseconds: 500))
        //       .thenTween('x', Tween<double>(begin: 0, end: -screenWidth),
        //       duration: Duration(milliseconds: 500));
      });
    });

    controller.addStatusListener((status) {
      print('status: $status');
    });
    }

  void playAction() {
    setState(() {
      print('play action $isPlaying');
      isPlaying = !isPlaying;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (tween != null)
          CustomAnimationBuilder(
            developerMode: false,
            tween: tween!,
            duration: tween!.duration,
            control: control,
            builder: (BuildContext context, value, Widget? child) {
            print('value: ${value.get('x')}');
              return Transform.translate(
                offset: Offset(value.get('x'), 100),
                child: Container(width: screenWidth, height: 50, color: Colors.purpleAccent,));
            },
          ),
        
        SizedBox(height: 100,),
        MaterialButton(onPressed: playAction, child: Text('Click me'))
      ],
    );
  }
}
