package com.example.stantonsmarthome

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


/// Reference library used
///
// https://github.com/juliansteenbakker/flutter_ble_peripheral/blob/master/android/src/main/kotlin/dev/steenbakker/flutter_ble_peripheral/FlutterBlePeripheralPlugin.kt

fun Boolean.toInt() = if (this) 1 else 0

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.stantonius/beacon"
//    private val EVENT_CHANNEL_NAME = "com.stantonius/device_bluetooth"

    private var methodChannel: MethodChannel? = null

    private lateinit var beacon: Beacon


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setChannels(this, flutterEngine.dartExecutor.binaryMessenger)
        beacon = Beacon()
        beacon.init(this)
    }

    private fun setChannels(context: Context, messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "checkDeviceTransmissionSupport") {
                val deviceTransmissionSupport = checkDeviceTransmissionSupport(context)
                result.success(deviceTransmissionSupport.toInt())
            } else if (call.method == "startBroadcastBeacon") {
                val _startBroadcasting = startBroadcastBeacon(call)
                result.success(_startBroadcasting)
            } else if (call.method == "stopBroadcastBeacon") {
                val _stopBroadcasting = stopBroadcastBeacon(context)
                result.success(_stopBroadcasting)
            } else if (call.method == "isBroadcasting") {
                val _isBroadcasting = isBroadcasting(context)
                result.success(_isBroadcasting)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onStop() {
        super.onStop()
        Log.d("FlutterActivity", "onStop cancelled")
    }

    private fun checkDeviceTransmissionSupport(context: Context): Boolean {
        return beacon.isBLEenabled()
    }


    private fun startBroadcastBeacon(call: MethodCall): Boolean {
        val arguments = call.arguments as Map<*, *>
        beacon.start(arguments)
        return true
    }

    private fun stopBroadcastBeacon(context: Context): Boolean {

        beacon.stop()
        return true
    }

    private fun isBroadcasting(context: Context): Boolean {
        return beacon.isAdvertising()
    }

    override fun onDestroy() {
        Log.d("Destroyed", "onDestroy called")
        super.onDestroy()
        this.stopBroadcastBeacon(context = this)
        methodChannel!!.setMethodCallHandler(null)
    }
}
