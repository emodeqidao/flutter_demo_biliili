import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// 网络信息模型
class NetworkInfoData {
  final String? wifiName;
  final String? wifiBSSID;
  final String? wifiIPv4;
  final String? wifiIPv6;
  final String? wifiGatewayIP;
  final String? wifiBroadcast;
  final String? wifiSubmask;

  NetworkInfoData({
    this.wifiName,
    this.wifiBSSID,
    this.wifiIPv4,
    this.wifiIPv6,
    this.wifiGatewayIP,
    this.wifiBroadcast,
    this.wifiSubmask,
  });

  @override
  String toString() {
    return 'Wifi Name: $wifiName\n'
        'Wifi BSSID: $wifiBSSID\n'
        'Wifi IPv4: $wifiIPv4\n'
        'Wifi IPv6: $wifiIPv6\n'
        'Wifi Broadcast: $wifiBroadcast\n'
        'Wifi Gateway: $wifiGatewayIP\n'
        'Wifi Submask: $wifiSubmask\n';
  }
}

// 网络信息服务
class NetworkInfoService {
  static final NetworkInfo _networkInfo = NetworkInfo();
  static final NetworkInfoService _instance = NetworkInfoService._internal();

  factory NetworkInfoService() => _instance;

  NetworkInfoService._internal();

  // 缓存网络信息
  NetworkInfoData? _cachedNetworkInfo;

  // 权限处理器
  Future<bool> _checkLocationPermission() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final status = await Permission.locationWhenInUse.status;
      if (!status.isGranted) {
        final result = await Permission.locationWhenInUse.request();
        return result.isGranted;
      }
      return true;
    }
    return true;
  }

  // 获取WiFi名称
  Future<String?> _getWifiName() async {
    try {
      if (await _checkLocationPermission()) {
        return await _networkInfo.getWifiName();
      }
      return 'Unauthorized to get Wifi Name';
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      return 'Failed to get Wifi Name';
    }
  }

  // 获取WiFi BSSID
  Future<String?> _getWifiBSSID() async {
    try {
      if (await _checkLocationPermission()) {
        return await _networkInfo.getWifiBSSID();
      }
      return 'Unauthorized to get Wifi BSSID';
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      return 'Failed to get Wifi BSSID';
    }
  }

  // 获取WiFi IPv4
  Future<String?> _getWifiIPv4() async {
    try {
      return await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      debugPrint('Failed to get Wifi IPv4, try fallback : $e');
    return await _getIPFallback();
    }
  }

  /// 备用方法：遍历网络接口找局域网 IP
  Future<String?> _getIPFallback() async {
    try {
      List<NetworkInterface> interfaceList = await NetworkInterface.list();
      for (final interface in interfaceList) {
       for (var address in interface.addresses) {
         if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
           return address.address;
         }
       }
      }
      return null;
    } on SocketException catch (e) {
      developer.log('Failed to get Wifi IPv4 fallback', error: e);
      return null;
    }
  }


  // 获取WiFi IPv6
  Future<String?> _getWifiIPv6() async {
    try {
      return await _networkInfo.getWifiIPv6();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      return 'Failed to get Wifi IPv6';
    }
  }

  // 获取WiFi子网掩码
  Future<String?> _getWifiSubmask() async {
    try {
      return await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask', error: e);
      return 'Failed to get Wifi submask';
    }
  }

  // 获取WiFi广播地址
  Future<String?> _getWifiBroadcast() async {
    try {
      return await _networkInfo.getWifiBroadcast();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      return 'Failed to get Wifi broadcast';
    }
  }

  // 获取WiFi网关地址
  Future<String?> _getWifiGatewayIP() async {
    try {
      return await _networkInfo.getWifiGatewayIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway', error: e);
      return 'Failed to get Wifi gateway';
    }
  }

  // 获取所有网络信息
  Future<NetworkInfoData> getAllNetworkInfo({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedNetworkInfo != null) {
      return _cachedNetworkInfo!;
    }

    // 并行获取所有网络信息以提高性能
    final results = await Future.wait([
      _getWifiName(),
      _getWifiBSSID(),
      _getWifiIPv4(),
      _getWifiIPv6(),
      _getWifiSubmask(),
      _getWifiBroadcast(),
      _getWifiGatewayIP(),
    ]);

    _cachedNetworkInfo = NetworkInfoData(
      wifiName: results[0],
      wifiBSSID: results[1],
      wifiIPv4: results[2],
      wifiIPv6: results[3],
      wifiSubmask: results[4],
      wifiBroadcast: results[5],
      wifiGatewayIP: results[6],
    );

    return _cachedNetworkInfo!;
  }

  // 获取特定信息的方法（按需使用）
  Future<String?> getWifiName() async {
    final info = await getAllNetworkInfo();
    return info.wifiName;
  }

  Future<String?> getWifiIP() async {
    final info = await getAllNetworkInfo();
    return info.wifiIPv4;
  }

  Future<String?> getWifiGateway() async {
    final info = await getAllNetworkInfo();
    return info.wifiGatewayIP;
  }

  // 刷新网络信息
  Future<NetworkInfoData> refreshNetworkInfo() async {
    return await getAllNetworkInfo(forceRefresh: true);
  }

  // 清空缓存
  void clearCache() {
    _cachedNetworkInfo = null;
  }

  // 简化初始化方法
  Future<void> init() async {
    // 预加载网络信息
    await getAllNetworkInfo();
  }
}