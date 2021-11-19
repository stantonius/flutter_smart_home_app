package com.example.stantonsmarthome

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.altbeacon.beacon.Beacon
import org.altbeacon.beacon.BeaconManager
import org.altbeacon.beacon.BeaconParser
import org.altbeacon.beacon.BeaconTransmitter

/// Reference library used
///
// https://github.com/juliansteenbakker/flutter_ble_peripheral/blob/master/android/src/main/kotlin/dev/steenbakker/flutter_ble_peripheral/FlutterBlePeripheralPlugin.kt

fun Boolean.toInt() = if (this) 1 else 0

class MainActivity : FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.stantonius/beacon"

    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setChannels(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    private fun setChannels(context: Context, messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler { call, result ->
            if (call.method == "checkDeviceTransmissionSupport") {
                val deviceTransmissionSupport = checkDeviceTransmissionSupport(context)
                result.success(deviceTransmissionSupport.toInt())
            } else if (call.method == "startBroadcastBeacon") {
                Log.d("ARGHHH", "PRINTING FROM NATIVE")
                val _startBroadcasting = startBroadcastBeacon(call)
                result.success(_startBroadcasting)
            } else if (call.method == "stopBroadcastBeacon") {
                val _stopBroadcasting = stopBroadcastBeacon(context)
                Log.d("STOP CALLED", "STOPPP")
                result.success(_stopBroadcasting)
            } else if (call.method == "isBroadcasting") {
                val _isBroadcasting = isBroadcasting(context)
                result.success(_isBroadcasting)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun checkDeviceTransmissionSupport(context: Context): Boolean {
        val beaconManager = BeaconManager.getInstanceForApplication(context)
        return beaconManager.checkAvailability()
    }

    private fun startBroadcastBeacon(call: MethodCall): Boolean {
        if (call.arguments !is Map<*, *>) {
            throw IllegalArgumentException("Arguments are not a map! " + call.arguments)
        }
        val arguments = call.arguments as Map<String, Any>
        val beacon =
                Beacon.Builder()
                        .setId1(arguments["uuid"] as String)
                        .setId2(arguments["major"] as String)
                        .setId3(arguments["minor"] as String)
                        .setManufacturer(arguments["manufacturer"] as Int)
                        .setTxPower(arguments["txPower"] as Int)
                        .build()

        val beaconParser =
                BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
        var beaconTransmitter = BeaconTransmitter(getApplicationContext(), beaconParser)
        beaconTransmitter.startAdvertising(beacon)
        return true
    }

    private fun stopBroadcastBeacon(context: Context): Boolean {
        val beaconParser =
                BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
        val beaconTransmitter = BeaconTransmitter(context, beaconParser)
        Log.d("STOP CALLED 2", "STOPPP 2")
        beaconTransmitter.stopAdvertising()
        return true
    }

    private fun isBroadcasting(context: Context): Boolean {
        val beaconParser =
                BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
        val beaconTransmitter = BeaconTransmitter(context, beaconParser)

        return beaconTransmitter.isStarted()
    }

    override fun onDestroy() {
        Log.d("Destroyed", "onDestroy called")
        super.onDestroy()
        this.stopBroadcastBeacon(context = this)
        methodChannel!!.setMethodCallHandler(null)
    }
}
