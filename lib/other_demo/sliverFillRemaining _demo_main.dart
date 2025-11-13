import 'package:flutter/material.dart';


void main() {
  final size = FontSize.fromSize(9);
  print(size);
  print(size.isLarge);

  runApp(const MyApp());
}

enum FontSize {
  small(100),
  medium(200),
  large(300),
  unknow(-1);

  final double size;
  const FontSize(this.size);

  static FontSize fromSize(double size) {
    return FontSize.values.
        firstWhere((element) => element.size == size,
        orElse: () => FontSize.unknow);
  }
}

extension on FontSize {
  bool get isSmall => this == FontSize.small;
  bool get isMedium => this == FontSize.medium;
  bool get isLarge => this == FontSize.large;
  bool get isUnknow => this == FontSize.unknow;
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliverFillRemaining Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverFillRemaining'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              children: [
                FlutterLogo(size: 100,),
                FlutterLogo(size: 100,),
                FlutterLogo(size: 100,),
                FlutterLogo(size: 100,),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
                child: Padding( padding: const EdgeInsets.all(10.0), child: ElevatedButton(onPressed: (){}, child: Text("next", style: TextStyle(color: Colors.red),)))),
          ),
        ],
      )
    );
  }
}
