package com.example.uniapp_sdk

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UniappSdkPlugin */
class UniappSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context: Context? = null
  private var activity: Activity? = null

  companion object {
    private const val TAG = "UniappSdkPlugin"
  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "uniapp_sdk")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    
    Log.d(TAG, "UniApp SDK Plugin initialized")
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "open" -> open(call, result)
      "install" -> install(call, result)
      "getVersionInfo" -> getVersionInfo(call, result)
      "isExist" -> isExist(call, result)
      "sendEvent" -> sendEvent(call, result)
      else -> result.notImplemented()
    }
  }

  private fun open(call: MethodCall, result: Result) {
    val appId = call.argument<String>("id") ?: ""
    val config = call.argument<Map<String, Any>>("config")
    
    Log.d(TAG, "Opening UniApp with ID: $appId")
    Log.d(TAG, "Config: $config")
    
    // 模拟打开小程序
    // 在实际实现中，这里会调用 DCUniMPSDK.getInstance().openUniMP()
    
    // 模拟延迟后的关闭回调
    android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
      val arguments = mapOf(
        "id" to appId,
        "type" to "1"
      )
      channel.invokeMethod("onClose", arguments)
    }, 3000) // 3秒后模拟关闭
    
    result.success(true)
  }

  private fun install(call: MethodCall, result: Result) {
    val appId = call.argument<String>("id") ?: ""
    val path = call.argument<String>("path") ?: ""
    val password = call.argument<String>("password")
    
    Log.d(TAG, "Installing UniApp with ID: $appId, Path: $path")
    
    // 模拟安装过程
    // 在实际实现中，这里会调用 DCUniMPSDK.getInstance().releaseWgtToRunPathFromePath()
    
    // 检查文件是否存在
    val file = java.io.File(path)
    if (file.exists()) {
      Log.d(TAG, "UniApp package file found, simulating installation...")
      result.success(true)
    } else {
      Log.e(TAG, "UniApp package file not found: $path")
      result.success(false)
    }
  }

  private fun getVersionInfo(call: MethodCall, result: Result) {
    val appId = call.argument<String>("id") ?: ""
    
    Log.d(TAG, "Getting version info for UniApp ID: $appId")
    
    // 模拟版本信息
    // 在实际实现中，这里会调用 DCUniMPSDK.getInstance().getUniMPVersionInfo()
    val versionInfo = mapOf(
      "code" to "1.0.0",
      "name" to "1.0.0",
      "description" to "Mock version info for $appId"
    )
    
    result.success(versionInfo)
  }

  private fun isExist(call: MethodCall, result: Result) {
    val appId = call.argument<String>("id") ?: ""
    
    Log.d(TAG, "Checking if UniApp exists: $appId")
    
    // 模拟检查小程序是否存在
    // 在实际实现中，这里会调用 DCUniMPSDK.getInstance().isExistsApp()
    
    // 简单模拟：如果appId不为空就认为存在
    val exists = appId.isNotEmpty()
    result.success(exists)
  }

  private fun sendEvent(call: MethodCall, result: Result) {
    val event = call.argument<String>("event") ?: ""
    val data = call.argument<Map<String, Any>>("data")
    
    Log.d(TAG, "Sending event to UniApp: $event, Data: $data")
    
    // 模拟发送事件
    // 在实际实现中，这里会调用 currentUniMP?.sendUniMPEvent()
    
    // 模拟接收到回调
    android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
      val arguments = mapOf("data" to "Mock response for event: $event")
      channel.invokeMethod("onReceive", arguments)
    }, 1000) // 1秒后模拟接收到回调
    
    result.success(true)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    Log.d(TAG, "Attached to activity")
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
    Log.d(TAG, "Detached from activity for config changes")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    Log.d(TAG, "Reattached to activity for config changes")
  }

  override fun onDetachedFromActivity() {
    activity = null
    Log.d(TAG, "Detached from activity")
  }
}
