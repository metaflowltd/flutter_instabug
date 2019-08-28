package com.metaflow.flutterinstabug

import android.app.Application
import com.instabug.library.Instabug
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterInstabugPlugin : MethodCallHandler {


    companion object {
        private lateinit var registrar: Registrar
        private var app: Application? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            this.registrar = registrar
            app = registrar.activity().application
            val channel = MethodChannel(registrar.messenger(), "flutter_instabug")
            channel.setMethodCallHandler(FlutterInstabugPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val turnOn = call.argument<Boolean>("isOn") ?: false
        when {
            call.method == "startInstabug" -> result.success("Instabug init")
            call.method == "identifyUser" -> result.success("Instabug user identified")
            call.method == "isOn" -> handleIsOn(turnOn)
            else -> result.notImplemented()
        }
    }

    private fun handleIsOn(turnOn: Boolean) =
            if (turnOn) Instabug.enable() else Instabug.disable()
}

