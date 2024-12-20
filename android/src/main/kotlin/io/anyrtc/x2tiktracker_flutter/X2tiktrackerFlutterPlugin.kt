package io.anyrtc.x2tiktracker_flutter

import android.content.Context
import android.os.Handler
import androidx.annotation.NonNull
import io.anyrtc.x2tiktracker.X2TikTrackerEngine

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** X2tiktrackerFlutterPlugin */
class X2tiktrackerFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
   private var x2TikTracker: X2TikTracker? = null
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "x2tiktracker_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
      when (call.method) {
          "create" -> {
              val appId = call.argument<String>("appId")
              if (appId != null) {
                  if (x2TikTracker == null) {
                      x2TikTracker = X2TikTracker(channel)
                  }
                  x2TikTracker?.create(context, appId)
                  result.success(0)
              } else {
                  result.error("INVALID_ARGUMENT", "appId is required", null)
              }
          }
          "release" -> {
              x2TikTracker?.release()
              x2TikTracker = null
              result.success(0)
          }
          "startPlay" -> {
              val url = call.argument<String>("url")
              val share = call.argument<Boolean>("share") ?: false
              if (url != null) {
                  val resultCode = x2TikTracker?.startPlay(url, share) ?: -1
                  result.success(resultCode)
              } else {
                  result.error("INVALID_ARGUMENT", "url is required", null)
              }
          }
          "stopPlay" -> {
              val resultCode = x2TikTracker?.stopPlay() ?: -1
              result.success(resultCode)
          }
          "startShare" -> {
              val resultCode = x2TikTracker?.startShare() ?: -1
              result.success(resultCode)
          }
          "stopShare" -> {
              val resultCode = x2TikTracker?.stopShare() ?: -1
              result.success(resultCode)
          }
          "getExUrl" -> {
              val exUrl = x2TikTracker?.getExUrl().orEmpty()
              result.success(exUrl)
          }
          "registerListener" -> {
              x2TikTracker?.registerListener()
              result.success("Listener Registered")
          }
          "removeListener" -> {
              x2TikTracker?.removeListener()
              result.success("Listener Removed")
          }
          else -> {
              result.notImplemented()
          }
      }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
     channel.setMethodCallHandler(null)
      x2TikTracker?.release()
      x2TikTracker = null
  }

}
