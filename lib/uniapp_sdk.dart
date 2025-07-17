import 'uniapp_sdk_platform_interface.dart';

class UniappSdk {
  Future<bool> open(String id) async {
    return UniappSdkPlatform.instance.open(id);
  }

  Future<bool> install(
    String id, {
    String path = '',
    String password = '',
  }) async {
    return UniappSdkPlatform.instance.install(
      id,
      path: path,
      password: password,
    );
  }

  Future<bool> isExist(String id) async {
    return UniappSdkPlatform.instance.isExist(id);
  }

  Future<dynamic> getVersionInfo(String id) async {
    return UniappSdkPlatform.instance.getVersionInfo(id);
  }
}
