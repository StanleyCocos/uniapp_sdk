import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_uniapp_sdk_platform_interface.dart';

/// An implementation of [FlutterUniappSdkPlatform] that uses method channels.
class MethodChannelFlutterUniappSdk extends FlutterUniappSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_uniapp_sdk');

  @override
  Future<bool> open(String id) async {
    final result = await methodChannel.invokeMethod<bool>('open', {'appId': id});
    return result ?? false;
  }

  @override
  Future<bool> install({
    String id = '',
    String path = '',
    String password = '',
  }) async {
    final result = await methodChannel.invokeMethod<bool>('install', {
      'appId': id,
      'path': path,
      'password': password,
    });
    return result ?? false;
  }

  @override
  Future<bool> preload(String id) async {
    final result = await methodChannel.invokeMethod<bool>('preload', {'appId': id});
    return result ?? false;
  }

  @override
  void close() {
    methodChannel.invokeMethod<void>('close');
  }
}
