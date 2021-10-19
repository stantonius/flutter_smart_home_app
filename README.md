# Flutter Smart Home App

## Objective

1. Advertise as beacon for in-home position tracking.
2. Interface to store other smart home/IoT settings (switches, video feeds eventually)

## Status

Very much in progress. It does work though as an iBeacon.

## Features

* Advertises in the background as iBeacon
* Connects to home Raspberry Pi server (specifically to Mosquitto MQTT protocol).
* Acts as an activity tracker and has geofencing set up
* Currently only for Android (although every library purposely chosen with iPhone compatability in mind).

## ToDo
- [] Turn off beacon when leaving geofence
- [] Enable light switch to
- [] Properly disable all features if not at home
- [] Enable remote access
