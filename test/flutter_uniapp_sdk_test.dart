import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uniapp_sdk/flutter_uniapp_sdk.dart';
import 'package:flutter_uniapp_sdk/flutter_uniapp_sdk_platform_interface.dart';
import 'package:flutter_uniapp_sdk/flutter_uniapp_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUniappSdkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUniappSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUniappSdkPlatform initialPlatform = FlutterUniappSdkPlatform.instance;

  test('$MethodChannelFlutterUniappSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUniappSdk>());
  });

  test('getPlatformVersion', () async {
    FlutterUniappSdk flutterUniappSdkPlugin = FlutterUniappSdk();
    MockFlutterUniappSdkPlatform fakePlatform = MockFlutterUniappSdkPlatform();
    FlutterUniappSdkPlatform.instance = fakePlatform;

    expect(await flutterUniappSdkPlugin.getPlatformVersion(), '42');
  });
}
