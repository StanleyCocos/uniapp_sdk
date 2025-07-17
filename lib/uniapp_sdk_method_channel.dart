import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'uniapp_sdk_platform_interface.dart';

/// An implementation of [UniappSdkPlatform] that uses method channels.
class MethodChannelUniappSdk extends UniappSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uniapp_sdk');

  @override
  Future<bool> open(String id) async {
    final result = await methodChannel.invokeMethod<bool>('open', {'id': id});
    return result ?? false;
  }

  @override
  Future<bool> install(String id,
      {String path = '', String password = ''}) async {
    final result = await methodChannel.invokeMethod<bool>('install', {
      'id': id,
      'path': path,
      'password': password,
    });
    return result ?? false;
  }

  @override
  Future<bool> isExist(String id) async {
    final result =
        await methodChannel.invokeMethod<bool>('isExist', {'id': id});
    return result ?? false;
  }

  @override
  Future<dynamic> getVersionInfo(String id) async {
    var result = await methodChannel.invokeMethod('getVersionInfo', {'id': id});
    return result;
  }
}
