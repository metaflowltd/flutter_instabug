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
    if (call.method == "initInstabug") {
      Instabug.Builder(app!!, "77f1665e44b0517abb069ba762bad3c9")
              .setInvocationEvents(InstabugInvocationEvent.SHAKE, InstabugInvocationEvent.SCREENSHOT_GESTURE)
              .build()
      result.success("Instabug init")
    } else {
      result.notImplemented()
    }
  }

}
