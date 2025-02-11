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

  /// 启动应用
  ///
  /// [id] appId
  Future<bool> open(String id) {
    throw UnimplementedError('open() has not been implemented.');
  }

  /// 安装应用
  ///
  /// [id] appId
  /// [path] 安装包路径
  /// [password] 安装包密码
  Future<bool> install({
    String id = '',
    String path = '',
    String password = '',
  }) {
    throw UnimplementedError('install() has not been implemented.');
  }

  /// 预加载应用
  ///
  /// [id] appId
  Future<bool> preload(String id){
    throw UnimplementedError('preload() has not been implemented.');
  }

  /// 关闭应用
  void close() {
    throw UnimplementedError('close() has not been implemented.');
  }
}
