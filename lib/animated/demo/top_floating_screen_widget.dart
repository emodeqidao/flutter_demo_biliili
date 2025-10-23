

import 'package:flutter/material.dart';

class TopFloatingScreenWidget extends StatefulWidget {
  const TopFloatingScreenWidget({super.key});

  @override
  State<TopFloatingScreenWidget> createState() => _TopFloatingScreenWidgetState();
}

class _TopFloatingScreenWidgetState extends State<TopFloatingScreenWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation _animation;
  final double screenWidth = 400;

  void _showAnimation() async {
    // 确保使用最新的screenWidth
    final currentScreenWidth = MediaQuery.of(context).size.width;

    // 进入动画：从右侧外面滑入
    await _runAnimation(
      begin: currentScreenWidth, // 从右侧外面开始
      end: 0.0,                 // 滑到左侧边缘
      duration: Duration(milliseconds: 300),
    );

    await Future.delayed(Duration(seconds: 3));

    // 退出动画：向左滑出屏幕
    await _runAnimation(
      begin: 0.0,
      end: -currentScreenWidth, // 滑到左侧外面
      duration: Duration(milliseconds: 500),
    );
  }

  Future<void> _runAnimation({
    required double begin,
    required double end,
    required Duration duration,
  }) {
    _controller.duration = duration;
    _animation = Tween<double>(begin: begin, end: end).animate(_controller);
    _controller.value = 0.0; // 重置动画进度
    return _controller.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
      duration: Duration(milliseconds: 100)
    );
      _animation =  Tween(begin: screenWidth, end: 0.0).animate(_controller);
      _controller.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
   final screenWidth = MediaQuery.of(context).size.width;
   print('screenWidth: $screenWidth');
// 如果是第一次构建，设置初始位置在右侧外面
    if (_controller.value == 0.0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.value = 1.0; // 设置到右侧外面
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              print(_animation.value);
              return Positioned(
                top: 0,
                left: _animation.value,
                child: child ?? Container() ,
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: screenWidth - 20,
              height: 100,
              color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: Icon(Icons.browse_gallery, color: Colors.yellow,),
              onPressed: _showAnimation,
          ),
          FloatingActionButton(
            child: Icon(Icons.browse_gallery, color: Colors.green,),
            onPressed: () async {
              _controller.reset();
              _controller.duration = Duration(milliseconds: 300);
              _animation = Tween(begin: screenWidth, end: 0.0).animate(_controller);
              await _controller.forward();

              await Future.delayed(Duration(seconds: 3));

              _controller.reset();
              _controller.duration = Duration(milliseconds: 500);
              _animation = Tween(begin: 0.0, end: -screenWidth).animate(_controller);
              await _controller.forward();
            }
          ),
          FloatingActionButton(
            onPressed: () {
              _animation =  Tween(begin: screenWidth, end: 0.0).animate(_controller);
              _controller.reset();
            },
          ),
        ],
      ),
    );
  }
}
