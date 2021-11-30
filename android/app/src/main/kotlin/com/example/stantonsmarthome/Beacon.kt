package com.example.stantonsmarthome

// heavily influenced by https://github.com/pszklarska/beacon_broadcast/blob/master/android/src/main/kotlin/pl/pszklarska/beaconbroadcast/Beacon.kt

import android.content.Context
import org.altbeacon.beacon.Beacon
import org.altbeacon.beacon.BeaconParser
import org.altbeacon.beacon.BeaconManager
import org.altbeacon.beacon.BeaconTransmitter

class Beacon {
    private lateinit var context: Context
    
    private var beaconTransmitter: BeaconTransmitter? = null
    private var beaconParser: BeaconParser = BeaconParser().setBeaconLayout("m:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24")
    
    fun init(context: Context) {
        this.context = context
        beaconTransmitter = BeaconTransmitter(context, beaconParser)
    }

    fun start(beaconParams: Map<*, *>) {

        if (beaconParams !is Map<*, *>) {
            throw IllegalArgumentException("Beacon params must be a Map")
        }

        val beacon =
                Beacon.Builder()
                        .setId1(beaconParams["uuid"] as String)
                        .setId2(beaconParams["major"] as String)
                        .setId3(beaconParams["minor"] as String)
                        .setManufacturer(beaconParams["manufacturer"] as Int)
                        .setTxPower(beaconParams["txPower"] as Int)
                        .build()
        beaconTransmitter?.startAdvertising(beacon)
    }

    fun stop() {
        beaconTransmitter?.stopAdvertising()
    }

    fun isAdvertising(): Boolean {
        return beaconTransmitter?.isStarted ?: false
    }
}