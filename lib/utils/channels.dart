/// Channels for creating platform-specific code to integrate with our Flutter app

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Layout of the Beacon channel bridge
/// Must have the following:
/// 1. A singleton instance to ensure that the channel is only created once
/// 2. Channel method logic to sort the different channel calls
/// 3. A method that accepts the initial beacon class parameters
///
/// Took inspiration from https://github.com/alann-maulana/flutter_beacon/blob/master/lib/flutter_beacon.dart
///
/// Note we could handle all of the permissions and check the bluetooth settings in the native Kotlin code
/// as the library above does. However just to simplify things we will only turn the beacon on
/// and off in this implementation and handle the permissions and bluetooth settings in the top level dart code
///
/// Therefore we need 3 methods:
/// 1. startBroadcastBeacon
/// 2. stopBroadcastBeacon
/// 3. isBroadcasting
///

final BeaconChannelBridge beaconChannelBridge =
    new BeaconChannelBridge._internal();

class BeaconChannelBridge {
  BeaconChannelBridge._internal();

  // channels to communicate to and from native code
  static const MethodChannel _methodChannel =
      MethodChannel('com.stantonius/beacon');

  //
  Future<bool> startBroadcastBeacon(Map beaconBroadcastSettings) async {
    final bool startBroadcasting = await _methodChannel.invokeMethod(
        'startBroadcastBeacon', beaconBroadcastSettings);
    return startBroadcasting;
  }

  Future<bool> stopBroadcastBeacon() async {
    final bool stopBroadcasting =
        await _methodChannel.invokeMethod('stopBroadcastBeacon');
    return stopBroadcasting;
  }

  Future<bool> isBroadcasting() async {
    final bool isBroadcasting =
        await _methodChannel.invokeMethod('isBroadcasting');
    print("THIS IS isBroadcasting: ${isBroadcasting}");
    return isBroadcasting;
  }
}

// break

// class SampleAndroidAPI extends StatefulWidget {
//   SampleAndroidAPI({Key? key}) : super(key: key);

//   @override
//   _SampleAndroidAPIState createState() => _SampleAndroidAPIState();
// }

// class _SampleAndroidAPIState extends State<SampleAndroidAPI> {
//   static const platform = MethodChannel('com.stantonius/beacon');

//   String _deviceTransmissionSupport = 'Unknown device transmission support';

//   Future<void> _checkDeviceTransmissionSupport() async {
//     String deviceTransmissionSupport;
//     try {
//       final int result =
//           await platform.invokeMethod('checkDeviceTransmissionSupport');
//       deviceTransmissionSupport = 'Device transmission support is $result % .';
//     } on PlatformException catch (e) {
//       deviceTransmissionSupport =
//           "Failed to get device transmission support: '${e.message}'.";
//     }

//     setState(() {
//       _deviceTransmissionSupport = deviceTransmissionSupport;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             ElevatedButton(
//               child: Text('Is Transmission Supported?'),
//               onPressed: _checkDeviceTransmissionSupport,
//             ),
//             Text(_deviceTransmissionSupport),
//           ],
//         ),
//       ),
//     );
//   }
// }
