import 'package:flutter/material.dart';

class TopScreenWidget extends StatefulWidget {
  const TopScreenWidget({super.key});

  @override
  State<TopScreenWidget> createState() => _TopScreenWidgetState();
}

class _TopScreenWidgetState extends State<TopScreenWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  bool _isInitialized = false;

  void _showAnimation() async {
    final screenWidth = MediaQuery.of(context).size.width;

    // 进入动画：从右侧外面滑入
    await _runAnimation(
      begin: screenWidth, // 从右侧外面开始
      end: 0.0,          // 滑到左侧边缘
      duration: Duration(milliseconds: 300),
    );

    await Future.delayed(Duration(seconds: 3));

    // 退出动画：向左滑出屏幕
    await _runAnimation(
      begin: 0.0,
      end: -screenWidth, // 滑到左侧外面
      duration: Duration(milliseconds: 500),
    );
  }

  Future<void> _runAnimation({
    required double begin,
    required double end,
    required Duration duration,
  }) {
    _controller.duration = duration;

    // 关键修复：创建新的动画并更新引用
    final newAnimation = Tween<double>(begin: begin, end: end).animate(_controller);

    setState(() {
      _animation = newAnimation;
    });

    _controller.value = 0.0; // 重置动画进度
    return _controller.forward();
  }

  void _resetToRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    _controller.duration = Duration.zero; // 立即跳转，无动画

    final newAnimation = Tween<double>(begin: screenWidth, end: screenWidth).animate(_controller);

    setState(() {
      _animation = newAnimation;
    });

    _controller.value = 1.0; // 立即设置到右侧外面
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // 初始动画定义
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 在第一次构建后设置初始位置到右侧外面
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _isInitialized = true;
        _resetToRight();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('顶部浮动窗口'),
      ),
      body: Stack(
        children: [
          // 使用 _animation.value 直接获取位置值，不依赖 AnimatedBuilder
          Positioned(
            top: 0,
            left: _animation.value,
            child: Container(
              margin: EdgeInsets.all(10),
              width: screenWidth - 20,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '顶部浮动窗口',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 按钮1：完整动画
          FloatingActionButton(
            heroTag: 'btn1',
            child: Icon(Icons.play_arrow, color: Colors.white),
            backgroundColor: Colors.blue,
            onPressed: _showAnimation,
          ),
          SizedBox(height: 10),
          // 按钮2：仅滑入
          FloatingActionButton(
            heroTag: 'btn2',
            child: Icon(Icons.arrow_right, color: Colors.white),
            backgroundColor: Colors.green,
            onPressed: () async {
              final currentScreenWidth = MediaQuery.of(context).size.width;
              await _runAnimation(
                begin: currentScreenWidth,
                end: 0.0,
                duration: Duration(milliseconds: 300),
              );
            },
          ),
          SizedBox(height: 10),
          // 按钮3：重置到右侧外面
          FloatingActionButton(
            heroTag: 'btn3',
            child: Icon(Icons.refresh, color: Colors.white),
            backgroundColor: Colors.orange,
            onPressed: _resetToRight,
          ),
          SizedBox(height: 10),
          // 按钮4：仅滑出
          FloatingActionButton(
            heroTag: 'btn4',
            child: Icon(Icons.arrow_left, color: Colors.white),
            backgroundColor: Colors.purple,
            onPressed: () async {
              final currentScreenWidth = MediaQuery.of(context).size.width;
              await _runAnimation(
                begin: 0.0,
                end: -currentScreenWidth,
                duration: Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}