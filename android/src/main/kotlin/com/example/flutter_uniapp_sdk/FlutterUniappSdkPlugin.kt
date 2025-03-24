package com.example.flutter_uniapp_sdk

import android.content.Context
import android.os.Handler
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
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "open") {
      open(call, result)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  private fun open(call: MethodCall, result: Result) {
    Log.d(TAG, "open: $result")
    /*val uniMPReleaseConfiguration = UniMPReleaseConfiguration()
    uniMPReleaseConfiguration.wgtPath = file.getPath()
    uniMPReleaseConfiguration.password = "789456123222"

    DCUniMPSDK.getInstance().releaseWgtToRunPath(
      "__UNI__A922B72_minimall", uniMPReleaseConfiguration
    ) { code, pArgs ->
      if (code == 1) {
        //释放wgt完成
        try {
          DCUniMPSDK.getInstance().openUniMP(this@MainActivity, "__UNI__A922B72_minimall")
        } catch (e: Exception) {
          e.printStackTrace()
        }
      } else {
        //释放wgt失败
      }
    }*/

    remoteOpen()
    /*try {
      val unimp =
        DCUniMPSDK.getInstance().openUniMP(context, "__UNI__B61D13B")
    } catch (e: Exception) {
      e.printStackTrace()
    }*/
  }

  private fun remoteOpen(){

    //
    val wgtUrl = "https://native-res.dcloud.net.cn/unimp-sdk/__UNI__7AEA00D.wgt"
    val wgtName = "__UNI__7AEA00D.wgt"

    val downFilePath: String? = context.cacheDir.getPath()

    val uiHandler = Handler()

    Log.d(TAG, "remoteOpen: $downFilePath")
    DownloadUtil.get()
      .download(context, wgtUrl, downFilePath, wgtName, object : DownloadUtil.OnDownloadListener {
        override fun onDownloadSuccess(file: File) {
          val uniMPReleaseConfiguration = UniMPReleaseConfiguration()
          uniMPReleaseConfiguration.wgtPath = file.path
          uniMPReleaseConfiguration.password = "789456123"

          uiHandler.post {
            DCUniMPSDK.getInstance().releaseWgtToRunPath(
              "__UNI__7AEA00D", uniMPReleaseConfiguration
            ) { code, pArgs ->
              if (code == 1) {
                //释放wgt完成
                try {
                  val uniMPOpenConfiguration = UniMPOpenConfiguration()
                  uniMPOpenConfiguration.extraData.put("darkmode", "auto")
                  DCUniMPSDK.getInstance().openUniMP(
                    context,
                    "__UNI__7AEA00D",
                    uniMPOpenConfiguration
                  )
                  Log.d(TAG, "onDownloadSuccess: 释放成功")
                } catch (e: java.lang.Exception) {
                  e.printStackTrace()
                }
              } else {
                //释放wgt失败
                Log.e(TAG, "onDownloadSuccess: 释放失败")
              }
            }
          }
        }

        override fun onDownloading(progress: Int) {
        }

        override fun onDownloadFailed() {
          Log.e("unimp", "downFilePath  ===  onDownloadFailed")
        }
      })
  }
}
