import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_uniapp_sdk_method_channel.dart';

abstract class FlutterUniappSdkPlatform extends PlatformInterface {
  /// Constructs a FlutterUniappSdkPlatform.
  FlutterUniappSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUniappSdkPlatform _instance = MethodChannelFlutterUniappSdk();

  /// The default instance of [FlutterUniappSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUniappSdk].
  static FlutterUniappSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUniappSdkPlatform] when
  /// they register themselves.
  static set instance(FlutterUniappSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
