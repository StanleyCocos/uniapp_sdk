package com.example.flutter_uniapp_sdk

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.dcloud.feature.sdk.DCSDKInitConfig
import io.dcloud.feature.sdk.DCUniMPSDK
import io.dcloud.feature.sdk.MenuActionSheetItem
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** FlutterUniappSdkPlugin */
class FlutterUniappSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private val TAG = "FlutterUniappSdkPlugin"
  private lateinit var channel : MethodChannel

  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    initSdk()
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_uniapp_sdk")
    channel.setMethodCallHandler(this)
  }

  private fun initSdk() {
    Log.d(TAG, "initSdk: 初始化 uniapp sdk")
    val item = MenuActionSheetItem("关于", "gy")
    val sheetItems: MutableList<MenuActionSheetItem> = ArrayList()
    sheetItems.add(item)

    val config = DCSDKInitConfig.Builder()
      .setCapsule(true)
      .setMenuDefFontSize("16px")
      .setMenuDefFontColor("#ff00ff")
      .setMenuDefFontWeight("normal")
      .setMenuActionSheetItems(sheetItems)
      .build()
    DCUniMPSDK.getInstance().initialize(context, config)

    DCUniMPSDK.getInstance().setDefMenuButtonClickCallBack { appid, id ->
      when (id) {
        "gy" -> {
          Log.d(TAG, appid + "用户点击了关于")
        }
      }
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    Log.d(TAG, "onMethodCall: ${call.method}")
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "open" -> {
          open(call, result)
        }
        "install" -> {
          install(call, result)
        }
        "preload" -> {
          preload(call, result)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun install(call: MethodCall, result: Result){
    val id: String = call.argument("appId") ?: ""
    val path: String = call.argument("path") ?: ""
    val password: String = call.argument("password") ?: ""

    val uniMPReleaseConfiguration = UniMPReleaseConfiguration()
    uniMPReleaseConfiguration.wgtPath = path
    uniMPReleaseConfiguration.password = password

    DCUniMPSDK.getInstance().releaseWgtToRunPath(
      id, uniMPReleaseConfiguration
    ) { code, pArgs ->
      if (code == 1) {
        //释放wgt完成
        result.success(true)
        Log.d(TAG, "install: 释放wgt完成")
      } else {
        //释放wgt失败
        result.error("error", "释放 wgt 失败: $code, $pArgs", pArgs)
        Log.e(TAG, "install: 释放 wgt 失败: $code, $pArgs")
      }
    }
  }

  private fun open(call: MethodCall, result: Result) {
    val id: String = call.argument("appId") ?: ""
    Log.d(TAG, "open: $id")
    rawOpen(id, result)
  }

  private fun preload(call: MethodCall, result: Result) {
   /* val id: String = call.argument("appId") ?: ""
    val path: String = call.argument("path") ?: ""
    val password: String = call.argument("password") ?: ""
    val downFilePath: String? = context.cacheDir.getPath()
    val uiHandler = Handler(context.mainLooper)
    DownloadUtil.get()
      .download(context, path, downFilePath, id, object : DownloadUtil.OnDownloadListener {
        override fun onDownloadSuccess(file: File) {
          val uniMPReleaseConfiguration = UniMPReleaseConfiguration()
          uniMPReleaseConfiguration.wgtPath = file.path
          uniMPReleaseConfiguration.password = password

          uiHandler.post {
            DCUniMPSDK.getInstance().releaseWgtToRunPath(
              id, uniMPReleaseConfiguration
            ) { code, pArgs ->
              if (code == 1) {
                //释放wgt完成
                try {
                  val uniMPOpenConfiguration = UniMPOpenConfiguration()
                  //uniMPOpenConfiguration.extraData.put("darkmode", "auto")
                  DCUniMPSDK.getInstance().openUniMP(
                    context,
                    id,
                    uniMPOpenConfiguration
                  )
                  Log.d(TAG, "onDownloadSuccess: 释放 wgt 完成")
                  result.success(true)
                } catch (e: java.lang.Exception) {
                  e.printStackTrace()
                }
              } else {
                //释放wgt失败
                Log.e(TAG, "onDownloadSuccess: 释放 wgt 失败")
              }
            }
          }
        }

        override fun onDownloading(progress: Int) {
          Log.d(TAG, "onDownloading: $progress")
        }

        override fun onDownloadFailed() {
          Log.e("unimp", "onDownloadFailed: 下载 uniapp wgt 失败")
        }
      })*/
  }

  private fun rawOpen(id: String, result: Result? = null) {
    try {
      DCUniMPSDK.getInstance().openUniMP(context, id)
      result?.success(true)
    } catch (e: Exception) {
      result?.error("error", e.message, null)
      e.printStackTrace()
    }
  }
}
