import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'x2tiktracker_flutter.dart';
import 'x2tiktracker_flutter_platform_interface.dart';

/// An implementation of [X2tiktrackerFlutterPlatform] that uses method channels.
class MethodChannelX2tiktrackerFlutter extends X2tiktrackerFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('x2tiktracker_flutter');

  MethodChannelX2tiktrackerFlutter() {
    methodChannel.setMethodCallHandler(_handleMethodCall);
  }

  // 处理来自原生层的方法调用
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onEvent':
        final eventData = Map<String, dynamic>.from(call.arguments);
        X2tiktrackerFlutter.handlePlatformEvent(eventData);
        break;
      default:
        print('Unhandled method ${call.method}');
    }
  }

  @override
  Future<void> create(String appId) async {
    await methodChannel.invokeMethod('create', {'appId': appId});
  }

  @override
  Future<void> release() async {
    await methodChannel.invokeMethod('release');
  }

  @override
  Future<int?> startPlay(String url, {bool share = false}) async {
    return await methodChannel.invokeMethod<int>('startPlay', {'url': url, 'share': share});
  }

  @override
  Future<int?> stopPlay() async {
    return await methodChannel.invokeMethod<int>('stopPlay');
  }

  @override
  Future<int?> startShare() async {
    return await methodChannel.invokeMethod<int>('startShare');
  }

  @override
  Future<int?> stopShare() async {
    return await methodChannel.invokeMethod<int>('stopShare');
  }

  @override
  Future<String?> getExUrl() async {
    return await methodChannel.invokeMethod<String>('getExUrl');
  }

  @override
  Future<String?> removeListener() async {
    return await methodChannel.invokeMethod<String>('removeListener');
  }

  @override
  Future<String?> registerListener() async {
    return await methodChannel.invokeMethod<String>('registerListener');
  }
}
