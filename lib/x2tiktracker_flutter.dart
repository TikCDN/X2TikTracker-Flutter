import 'x2tiktracker_flutter_platform_interface.dart';
import 'dart:async';

class X2tiktrackerFlutter {

  static final _instance = X2tiktrackerFlutter._();
  factory X2tiktrackerFlutter() => _instance;
  X2tiktrackerFlutter._();

  // 创建广播流控制器
  static final _eventController = StreamController<Map<String, dynamic>>.broadcast();

  // 公开事件流
  static Stream<Map<String, dynamic>> get eventStream => _eventController.stream;

  // 初始化标志
  bool _isInitialized = false;

  // 获取初始化状态
  bool get isInitialized => _isInitialized;

  Future<void> create(String appId) async{
    await X2tiktrackerFlutterPlatform.instance.create(appId);
    _isInitialized = true;
  }

  Future<void> release() async{
    await X2tiktrackerFlutterPlatform.instance.release();
    _isInitialized = false;
  }

  Future<int?> startPlay(String url, {bool share = false}) {
    return X2tiktrackerFlutterPlatform.instance.startPlay(url, share: share);
  }

  Future<int?> stopPlay() {
    return X2tiktrackerFlutterPlatform.instance.stopPlay();
  }

  Future<int?> startShare() {
    return X2tiktrackerFlutterPlatform.instance.startShare();
  }

  Future<int?> stopShare() {
    return X2tiktrackerFlutterPlatform.instance.stopShare();
  }

  Future<String?> getExUrl() {
    return X2tiktrackerFlutterPlatform.instance.getExUrl();
  }

  Future<String?> getVersion() {
    return X2tiktrackerFlutterPlatform.instance.getVersion();
  }

  Future<String?> removeListener() {
    return X2tiktrackerFlutterPlatform.instance.removeListener();
  }

  Future<String?> registerListener() {
    return X2tiktrackerFlutterPlatform.instance.registerListener();
  }

  // 处理原生事件
  static void handlePlatformEvent(Map<String, dynamic> event) {
    if (!_instance._isInitialized) {
      print('Plugin not initialized yet, dropping event: $event');
      return;
    }
    _eventController.add(event);
  }

  // 关闭事件流
  static void dispose() {
    _eventController.close();
  }

}
