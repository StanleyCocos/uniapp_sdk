#include "include/flutter_uniapp_sdk/flutter_uniapp_sdk_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_uniapp_sdk_plugin.h"

void FlutterUniappSdkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_uniapp_sdk::FlutterUniappSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
