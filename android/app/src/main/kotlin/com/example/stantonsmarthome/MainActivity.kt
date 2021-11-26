package com.example.stantonsmarthome

import io.flutter.embedding.android.FlutterActivity

/// Reference library used
///
// https://github.com/juliansteenbakker/flutter_ble_peripheral/blob/master/android/src/main/kotlin/dev/steenbakker/flutter_ble_peripheral/FlutterBlePeripheralPlugin.kt

fun Boolean.toInt() = if (this) 1 else 0

class MainActivity : FlutterActivity() {
    // private val METHOD_CHANNEL_NAME = "com.stantonius/beacon"
    // private val EVENT_CHANNEL_NAME = "com.stantonius/device_bluetooth"

    // private var methodChannel: MethodChannel? = null

    // // needed as beaconTransmitter.isStarted() is always false
    // private var isBeaconActive: Boolean = false

    // // setup vars for the beaconTransmitter class
    // private var beaconManager: BeaconManager? = null
    // private var beaconTransmitter: BeaconTransmitter? = null

    // override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    //     super.configureFlutterEngine(flutterEngine)
    //     setChannels(this, flutterEngine.dartExecutor.binaryMessenger)
    // }

    // private fun setChannels(context: Context, messenger: BinaryMessenger) {
    //     methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
    //     methodChannel!!.setMethodCallHandler { call, result ->
    //         if (call.method == "checkDeviceTransmissionSupport") {
    //             val deviceTransmissionSupport = checkDeviceTransmissionSupport(context)
    //             result.success(deviceTransmissionSupport.toInt())
    //         } else if (call.method == "startBroadcastBeacon") {
    //             val checkDevice = checkDeviceTransmissionSupport(context)
    //             Log.d("MainActivity", "checkDevice: $checkDevice")
    //             if (checkDevice) {
    //                 val _startBroadcasting = startBroadcastBeacon(call)
    //                 result.success(_startBroadcasting)
    //             } else {
    //                 result.error(
    //                         "DeviceTransmissionSupport",
    //                         "Device does not support beacon broadcasting",
    //                         null
    //                 )
    //             }
    //         } else if (call.method == "stopBroadcastBeacon") {
    //             val _stopBroadcasting = stopBroadcastBeacon(context)
    //             result.success(_stopBroadcasting)
    //         } else if (call.method == "isBroadcasting") {
    //             val _isBroadcasting = isBroadcasting(context)
    //             result.success(_isBroadcasting)
    //         } else {
    //             result.notImplemented()
    //         }
    //     }
    // }

    // private fun checkDeviceTransmissionSupport(context: Context): Boolean {
    //     val beaconManager = BeaconManager.getInstanceForApplication(context)
    //     beaconManager.return beaconManager.checkAvailability()
    // }

    // private fun startBroadcastBeacon(call: MethodCall): Boolean {
    //     if (call.arguments !is Map<*, *>) {
    //         throw IllegalArgumentException("Arguments are not a map! " + call.arguments)
    //     }
    //     val arguments = call.arguments as Map<String, Any>
    //     val beacon =
    //             Beacon.Builder()
    //                     .setId1(arguments["uuid"] as String)
    //                     .setId2(arguments["major"] as String)
    //                     .setId3(arguments["minor"] as String)
    //                     .setManufacturer(arguments["manufacturer"] as Int)
    //                     .setTxPower(arguments["txPower"] as Int)
    //                     .build()

    //     val beaconParser =
    //             BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
    //     beaconTransmitter!!.startAdvertising(beacon)
    //     this.isBeaconActive = true
    //     Log.d("Beacon Transmitter Status", this.isBeaconActive.toString())
    //     return true
    // }

    // private fun stopBroadcastBeacon(context: Context): Boolean {
    //     val beaconParser =
    //             BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
    //     val beaconTransmitter = BeaconTransmitter(context, beaconParser)
    //     beaconTransmitter.stopAdvertising()
    //     this.isBeaconActive = false
    //     Log.d("Beacon Stop", "Beacon Stop Called")
    //     return true
    // }

    // private fun isBroadcasting(context: Context): Boolean {
    //     return this.isBeaconActive
    // }

    // override fun onDestroy() {
    //     methodChannel!!.setMethodCallHandler(null)
    //     Log.d("Destroyed", "onDestroy called")
    //     super.onDestroy()
    //     this.stopBroadcastBeacon(context = this)
    // }
}
