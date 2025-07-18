
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'uniapp_sdk_platform_interface.dart';

/// An implementation of [UniappSdkPlatform] that uses method channels.
class MethodChannelUniappSdk extends UniappSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uniapp_sdk');

  void Function(String)? _onClosed;
  void Function(dynamic)? _onReceive;

  MethodChannelUniappSdk() {
    methodChannel.setMethodCallHandler(_setupCallbackHandler);
  }

  @override
  Future<bool> open(
    String id, {
    UniAppConfiguration? config,
    void Function(String)? onClosed,
    void Function(dynamic)? onReceive,
  }) async {
    _onClosed = onClosed;
    _onReceive = onReceive;
    final result = await methodChannel.invokeMethod<bool>('open', {
      'id': id,
      'config': config?.toJson(),
    });
    return result ?? false;
  }

  @override
  Future<bool> install(
    String id, {
    String path = '',
    String? password,
  }) async {
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

  @override
  Future<bool> sendEvent({
    required String event,
    Map<String, dynamic>? data,
  }) async {
    var result = await methodChannel.invokeMethod(
      'sendEvent',
      {'event': event, 'data': data},
    );
    return result;
  }

  Future<dynamic> _setupCallbackHandler(MethodCall call) {
    try {
      if (call.method == 'onClose') {
        String? id = call.arguments?['id'] ?? '';
        _onClosed?.call(id ?? '');
      } else if (call.method == 'onReceive') {
        _onReceive?.call(call.arguments);
      } else {
        throw Exception('未知的回调方法: ${call.method}');
      }
    } catch (e) {
      throw Exception('onClose 回调处理出错: $e');
    }
    return Future.value(null);
  }
}
