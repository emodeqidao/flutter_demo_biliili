import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
// import 'package:shelf_router/shelf_router.dart' as shelf_router; // 添加路由管理

class HttpServerService {
  HttpServer? _server;
  final int port;

  bool isRunning() => _server != null;

  HttpServerService({this.port = 8888});

  Future<void> start() async {
    if (_server != null) throw Exception('服务器已经在运行');

    // 加载 HTML 文件内容
    // final htmlContent = await _loadHtmlFile();


    // Response handler(Request request) {
    //   // if (request.method == 'OPTIONS') {
    //   //   return Response.ok('', headers: _corsHeaders);
    //   // }
    //   debugPrint('✅  开始返回内容');
    //   return Response.ok("helllo x111ixi");
    // }
    Response handler(Request request) {
      debugPrint('收到请求来自: ${request.headers['host']}');
      debugPrint('请求路径: ${request.requestedUri.path}');
      debugPrint('请求方法: ${request.method}');
      debugPrint('请求头: ${request.headers}');


      return Response.ok(
        '111 Flutter HTTP Server\n'
            'Time: ${DateTime.now()}\n'
            'Path: ${request.requestedUri.path}\n'
            'Headers: ${request.headers}',
        headers: {
          'Content-Type': 'text/plain; charset=utf-8',
          'Access-Control-Allow-Origin': '*',
        },
      );
    }


    try {
      _server = await shelf_io.serve(
        handler,
        // '192.168.31.58',
        InternetAddress.anyIPv4,
        port,
      );

      debugPrint('✅  服务器启动成功，端口：${_server?.port}');
      debugPrint('🌐  访问地址：http://${await _getLocalIP()}:${_server?.port}');
    } catch (e) {
      debugPrint('❌  服务器启动失败: $e');
      rethrow;
    }
  }

  // 获取本地 IP 地址（用于显示访问地址）
  Future<String> _getLocalIP() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        print(interface.addresses);
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      debugPrint('获取 IP 地址失败: $e');
    }
    return 'localhost';
  }

  // 获取服务器地址（外部调用）
  String? get serverUrl {
    if (_server == null) return null;
    return 'http://${_server?.address.address}:${_server?.port}';
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
    debugPrint('⏹️  服务器停止成功');
  }
}