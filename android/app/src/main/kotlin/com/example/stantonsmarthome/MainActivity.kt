package com.example.stantonsmarthome

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import org.altbeacon.beacon.BeaconManager

fun Boolean.toInt() = if (this) 1 else 0

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.stantonius/beacon"

    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME)
        //         .setMethodCallHandler {
        //                 // Note: this method is invoked on the main thread.
        //                 call,
        //                 result ->
        //             if (call.method == "checkDeviceTransmissionSupport") {
        //                 // val batteryLevel = getBatteryLevel()

        //                 // if (batteryLevel != -1) {
        //                 //     result.success(batteryLevel)
        //                 // } else {
        //                 //     result.error("UNAVAILABLE", "Battery level not available.", null)
        //                 // }
        //                 val deviceTransmissionSupport = checkDeviceTransmissionSupport(this)
        //                 result.success(deviceTransmissionSupport.toInt())
        //             } else {
        //                 result.notImplemented()
        //             }
        //         }
        setChannels(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    //    private fun getBatteryLevel(): Int {
    //        val batteryLevel: Int
    //        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    //            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    //            batteryLevel =
    // batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    //        } else {
    //            val intent = ContextWrapper(applicationContext).registerReceiver(null,
    // IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    //            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 /
    // intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    //        }
    //
    //        return batteryLevel
    //    }

    private fun setChannels(context: Context, messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "checkDeviceTransmissionSupport") {
                val deviceTransmissionSupport = checkDeviceTransmissionSupport(context)
                result.success(deviceTransmissionSupport.toInt())
            } else {
                result.notImplemented()
            }
        }
    }

    private fun checkDeviceTransmissionSupport(context: Context): Boolean {
        val beaconManager = BeaconManager.getInstanceForApplication(context)
        return beaconManager.checkAvailability()
    }

    //    private fun teardownChannels() {
    //        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
    // METHOD_CHANNEL_NAME)!!.setMethodCallHandler(null)
    //    }

}
