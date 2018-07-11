package com.metaflow.flutterinstabug

import android.app.Application
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.instabug.library.invocation.InstabugInvocationEvent
import com.instabug.library.Instabug



class FlutterInstabugPlugin: MethodCallHandler {
  companion object {
    private var app: Application? = null

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      app = registrar.activity().application
      val channel = MethodChannel(registrar.messenger(), "flutter_instabug")
      channel.setMethodCallHandler(FlutterInstabugPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when {
        call.method == "startInstabug" -> result.success("Instabug init")
        call.method == "identifyUser" -> result.success("Instabug user identified")
        else -> result.notImplemented()
    }
  }

}
