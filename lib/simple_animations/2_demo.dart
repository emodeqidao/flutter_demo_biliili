import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

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
        child: AnimationMixinWidget(),
      ),
    );
  }
}

class AnimationMixinWidget extends StatefulWidget {
  const AnimationMixinWidget({super.key});

  @override
  State<AnimationMixinWidget> createState() => _AnimationMixinWidgetState();
}

class _AnimationMixinWidgetState extends State<AnimationMixinWidget> with AnimationMixin {
  late Animation xAnimation;
  late MovieTween tween;

  final double screenWidth = 400.0;
  bool _isPlaying = false;

  List<String> words = [
    'flutter',
    'animation',
    'simple',
    'package',
    'tween',
    'builder',
    'controller',
    'duration',
    'curve',
    'widget'
  ];
  String currentWord = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    controller.reset();
    tween = _createMovieTween();
    currentWord = words[Random().nextInt(words.length)];
    // xAnimation = tween.animate(controller);
    // controller.reset();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  MovieTween _createMovieTween() {
    // 使用方法1：明确的 scene 时间
    return MovieTween()
      ..scene(
        begin: Duration.zero,
        end: const Duration(seconds: 3),
      ).tween('x', Tween<double>(begin: screenWidth - 100, end: 0))
     ..scene(
       begin: Duration.zero,
       end: const Duration(seconds: 3),
     ).tween('color', ColorTween(begin: Colors.purpleAccent, end: Colors.redAccent))
      ..scene(
        begin: Duration.zero,
        end: const Duration(seconds: 3),
      ).tween('opacity', Tween<double>(begin: 0.0, end: 1.0))


      ..scene(
        begin: const Duration(seconds: 3),
        end: const Duration(seconds: 6),
      ).tween('x', ConstantTween<double>(0))
    .thenTween('color', ColorTween(begin: Colors.blue, end: Colors.brown), duration: Duration(seconds: 3))

      ..scene(
        begin: const Duration(seconds: 6),
        end: const Duration(seconds: 9),
      ).tween('x', Tween<double>(begin: 0.0, end: -screenWidth))
        ..scene(
          begin: const Duration(seconds: 7),
          end: const Duration(seconds: 9),
        ).tween('opacity', Tween<double>(begin: 1.0, end: 0.0));
  }

  void _startAnimation() {
    // controller.play(duration: Duration(seconds: 2));
    setState(() {
      _isPlaying = !_isPlaying;
      currentWord = words[Random().nextInt(words.length)];
    });
  }

  void resetWidget() {
    controller.reset();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ElevatedButton(
          onPressed: _startAnimation,
          child: const Text('重新播放动画'),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: resetWidget,
          child: const Text('归为重置'),
        ),
        const SizedBox(height: 40),
        CustomAnimationBuilder(

          control: Control.playFromStart,
          tween: tween,
          duration: tween.duration,
          builder: (_, value, Widget? child) {
            return Transform.translate(
            offset: Offset(value.get('x'), 0),
            child: Opacity(
              opacity: value.get('opacity'),
              child: Container(
                width: 200,
                height: 50,
                child: Text(currentWord, style: TextStyle(color: Colors.blue, fontSize: 30),),
                // width: xAnimation.value.get('width'),
                // height: xAnimation.value.get('height'),
                color: value.get('color'),
              ),
            ),
          );
          },
        ),

      ],
    );
  }
}
