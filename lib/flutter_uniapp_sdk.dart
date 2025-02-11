import 'flutter_uniapp_sdk_platform_interface.dart';

class FlutterUniappSdk {
  Future<bool> open(String id) {
    return FlutterUniappSdkPlatform.instance.open(id);
  }

  Future<bool> install({
    String id = '',
    String path = '',
    String password = '',
  }) {
    return FlutterUniappSdkPlatform.instance.install(id: id);
  }

  Future<bool> preload(String id) {
    return FlutterUniappSdkPlatform.instance.preload(id);
  }

  void close() {
    return FlutterUniappSdkPlatform.instance.close();
  }
}
