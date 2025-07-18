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

  Future<bool> open(
    String id, {
    UniAppConfiguration? config,
    void Function(String)? onClosed,
    void Function(dynamic)? onReceive,
  }) async {
    throw UnimplementedError('open() has not been implemented.');
  }

  Future<bool> install(
    String id, {
    String path = '',
    String? password,
  }) async {
    throw UnimplementedError('install() has not been implemented.');
  }

  Future<bool> isExist(String id) async {
    throw UnimplementedError('isExist() has not been implemented.');
  }

  Future<dynamic> getVersionInfo(String id) async {
    throw UnimplementedError('versionInfo() has not been implemented.');
  }

  Future<bool> sendEvent({
    required String event,
    Map<String, dynamic>? data,
  }) async {
    throw UnimplementedError('sendEvent() has not been implemented.');
  }
}

enum UniAPPOpenMode {
  present,
  push,
}

class UniAppConfiguration {
  /// 需要传递给目标小程序的数据 默认：nil
  Map<String, dynamic>? extraData;

  /// 小程序打开小程序时传来源小程序的appId
  String? fromAppId;

  /// 打开的页面路径，如果为空则打开首页。path 中 ? 后面的部分会成为 query 例："pages/component/view/view?a=1&b=2" 默认：nil
  String? path;

  /// 是否开启后台运行（退出小程序时隐藏到后台不销毁小程序应用） 默认：false
  bool enableBackground = false;

  /// 是否开启 show 小程序时的动画效果 默认：true
  bool showAnimated = true;

  /// 是否开启 hide 时的动画效果 默认：true
  bool hideAnimated = true;

  /// 打开小程序的方式 默认: present
  UniAPPOpenMode openMode = UniAPPOpenMode.present;

  /// 是否开启手势关闭小程序 默认：false
  bool enableGestureClose = false;

  UniAppConfiguration({
    this.extraData,
    this.fromAppId,
    this.path,
    this.enableBackground = false,
    this.showAnimated = true,
    this.hideAnimated = true,
    this.openMode = UniAPPOpenMode.present,
    this.enableGestureClose = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'extraData': extraData,
      'fromAppId': fromAppId,
      'path': path,
      'enableBackground': enableBackground,
      'showAnimated': showAnimated,
      'hideAnimated': hideAnimated,
      'openMode': openMode.name,
      'enableGestureClose': enableGestureClose,
    };
  }
}
