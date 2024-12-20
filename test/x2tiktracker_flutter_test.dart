import 'package:flutter_test/flutter_test.dart';
import 'package:x2tiktracker_flutter/x2tiktracker_flutter.dart';
import 'package:x2tiktracker_flutter/x2tiktracker_flutter_platform_interface.dart';
import 'package:x2tiktracker_flutter/x2tiktracker_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockX2tiktrackerFlutterPlatform 
    with MockPlatformInterfaceMixin
    implements X2tiktrackerFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final X2tiktrackerFlutterPlatform initialPlatform = X2tiktrackerFlutterPlatform.instance;

  test('$MethodChannelX2tiktrackerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelX2tiktrackerFlutter>());
  });

  test('getPlatformVersion', () async {
    X2tiktrackerFlutter x2tiktrackerFlutterPlugin = X2tiktrackerFlutter();
    MockX2tiktrackerFlutterPlatform fakePlatform = MockX2tiktrackerFlutterPlatform();
    X2tiktrackerFlutterPlatform.instance = fakePlatform;
  
    expect(await x2tiktrackerFlutterPlugin.getPlatformVersion(), '42');
  });
}
