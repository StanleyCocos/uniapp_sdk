import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'uniapp_sdk_method_channel.dart';

abstract class UniappSdkPlatform extends PlatformInterface {
  /// Constructs a UniappSdkPlatform.
  UniappSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static UniappSdkPlatform _instance = MethodChannelUniappSdk();

  /// The default instance of [UniappSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelUniappSdk].
  static UniappSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UniappSdkPlatform] when
  /// they register themselves.
  static set instance(UniappSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> open(String id) async {
    throw UnimplementedError('open() has not been implemented.');
  }

  Future<bool> install(String id,
      {String path = '', String password = ''}) async {
    throw UnimplementedError('install() has not been implemented.');
  }

  Future<bool> isExist(String id) async {
    throw UnimplementedError('isExist() has not been implemented.');
  }

  Future<dynamic> getVersionInfo(String id) async {
    throw UnimplementedError('versionInfo() has not been implemented.');
  }
}
