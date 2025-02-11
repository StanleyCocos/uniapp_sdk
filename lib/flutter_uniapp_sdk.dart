
import 'flutter_uniapp_sdk_platform_interface.dart';

class FlutterUniappSdk {
  Future<String?> getPlatformVersion() {
    return FlutterUniappSdkPlatform.instance.getPlatformVersion();
  }
}
