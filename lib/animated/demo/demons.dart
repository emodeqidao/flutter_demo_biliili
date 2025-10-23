import 'package:flutter/material.dart';

class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器（总时长5秒）
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // 监听动画状态，更新按钮状态
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isAnimating = false);
      }
    });

    // 定义三段式动画路径
    _animation = TweenSequence<Offset>([
      // 1秒：从右侧外部滑入屏幕中央
      TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero),
        weight: 1,
      ),
      // 3秒：在屏幕中央停留（无位移）
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: Offset.zero),
        weight: 3,
      ),
      // 1秒：从中央滑出到右侧外部
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.5, 0)),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  // 开始动画
  void _startAnimation() {
    if (!_isAnimating) {
      setState(() => _isAnimating = true);
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedBuilder 动画'),
      ),
      body: Stack(
        children: [
          // 使用AnimatedBuilder构建动画组件
          AnimatedBuilder(
            animation: _animation, // 关联动画
            builder: (context, child) {
              // 通过Transform实现位移（替代SlideTransition）
              return Transform.translate(
                offset: _animation.value * MediaQuery.of(context).size.width,
                child: child, // 复用子组件，优化性能
              );
            },
            // 动画的目标组件（会被传递给builder的child参数）
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  '动画元素',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // 控制按钮
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _isAnimating ? null : _startAnimation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  _isAnimating ? '动画进行中...' : '开始动画',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnimatedBuilderDemo(),
  ));
}