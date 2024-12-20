import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:x2tiktracker_flutter/x2tiktracker_flutter_method_channel.dart';

void main() {
  MethodChannelX2tiktrackerFlutter platform = MethodChannelX2tiktrackerFlutter();
  const MethodChannel channel = MethodChannel('x2tiktracker_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
