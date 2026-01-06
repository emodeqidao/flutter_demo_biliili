import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_bilibili/server_web/http_server.dart';
import 'package:flutter_demo_bilibili/server_web/network_info_service.dart';

// void main() {
//   runApp(const MyApp());
// }

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
  String _currentIP = "112";
  final int port = 8888;
  late HttpServerService _service;
  bool _isRunning = false;

  void serviceAction() {
    try {
      if (!_isRunning) {
        _service.start();
      } else {
        _service.stop();
      }

      if (mounted) {
        setState(() {
          _isRunning = !_isRunning;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('❌ 错误: $e')));
    }
  }

  String get serverURL => 'http://$_currentIP:$port';
  String get serverURLText => '请在浏览器上面输入 \n $serverURL';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _service = HttpServerService(port: port);
    initNetworkInfo();
  }

  void initNetworkInfo() async {
    await NetworkInfoService().init();

    final ipAddress = await NetworkInfoService().getWifiIP();
    setState(() {
      _currentIP = ipAddress ?? '获取失败';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('web server'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: _isRunning ? Colors.green : Colors.grey,
                  shape: BoxShape.circle),
              child: Icon(
                _isRunning ? Icons.check : Icons.error,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              _isRunning ? '运行中' : '未运行',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: _isRunning ? Colors.green : Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            if (_isRunning)
              //增加下划线
              GestureDetector(
                onTap: () {
                  // 复制到剪贴板
                  Clipboard.setData(ClipboardData(text: serverURL));
                },
                child: Text(
                  serverURLText,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: serviceAction,
              child: Icon(_isRunning ? Icons.stop : Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
