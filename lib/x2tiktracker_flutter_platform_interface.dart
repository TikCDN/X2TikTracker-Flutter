import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'x2tiktracker_flutter_method_channel.dart';

abstract class X2tiktrackerFlutterPlatform extends PlatformInterface {
  /// Constructs a X2tiktrackerFlutterPlatform.
  X2tiktrackerFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static X2tiktrackerFlutterPlatform _instance = MethodChannelX2tiktrackerFlutter();

  /// The default instance of [X2tiktrackerFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelX2tiktrackerFlutter].
  static X2tiktrackerFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [X2tiktrackerFlutterPlatform] when
  /// they register themselves.
  static set instance(X2tiktrackerFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> create(String appId) {
    throw UnimplementedError('create() has not been implemented.');
  }

  Future<void> release() {
    throw UnimplementedError('release() has not been implemented.');
  }

  Future<int?> startPlay(String url, {bool share = false}) {
    throw UnimplementedError('startPlay() has not been implemented.');
  }

  Future<int?> stopPlay() {
    throw UnimplementedError('stopPlay() has not been implemented.');
  }

  Future<int?> startShare() {
    throw UnimplementedError('startShare() has not been implemented.');
  }

  Future<int?> stopShare() {
    throw UnimplementedError('stopShare() has not been implemented.');
  }

  Future<String?> getExUrl() {
    throw UnimplementedError('getExUrl() has not been implemented.');
  }
  Future<String?> removeListener() {
    throw UnimplementedError('removeListener() has not been implemented.');
  }
  Future<String?> registerListener() {
    throw UnimplementedError('registerListener() has not been implemented.');
  }
}
