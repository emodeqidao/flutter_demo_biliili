import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isHidden = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("state: $state");
    switch (state) {
      case AppLifecycleState.resumed:
        // 应用重新进入前台
        break;
      case AppLifecycleState.inactive:
        // 应用进入后台状态
        break;
      case AppLifecycleState.paused:
        // 应用暂停运行
        break;
      case AppLifecycleState.detached:
        // 应用从内存中移除
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }

    setState(() {
      //只要不是resumed状态，就隐藏应用
      _isHidden = state != AppLifecycleState.resumed;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: [
          const MainPage(),
          if (_isHidden) Container(color: Colors.red,)
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double? _pi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compute Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("${_pi}", style: const TextStyle(fontSize: 30),),
            CircularProgressIndicator()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setState(() => _pi = null);
        await Future.delayed(const Duration(seconds: 1));
        final pi = await compute(estimatePi, 100000000);
        setState(() => _pi = pi);

      }),
    );
  }
}


/// 耗时操作，计算pi值
double estimatePi(int terms) {
  double pi = 0.0;
  for (int i = 1; i < terms; i += 4) {
    pi += (4 / i) - (4 / (i + 2 ));
  }

  return pi;
}