import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';

/// This page contains all of the setup for the BLE Beacon
/// FOr the most part this section is self-contained, with the exception for
/// reading the device BT state in order to disable BLE

/// 1. BLE Beacon setup

// Initialize the settings for the advertising beacon

Map<String, dynamic> beaconParams = {
  "uuid": "c8c706b9-879a-4682-ba7f-56346f4d800e",
  "major": 12121,
  "minor": 34343,
  "identifier": "com.example.stantonius",
  "layout": BeaconBroadcast.ALTBEACON_LAYOUT,
  "manufacturerId": 0x0118,
  "extraData": [100]
};

BeaconBroadcast beaconBroadcast = BeaconBroadcast();

class BLESetup extends StateNotifier<bool?> {
  final BeaconBroadcast beacon;
  bool _isAdvertising = false;
  late BeaconStatus _isTransmissionSupported;
  late StreamSubscription<bool> _isAdvertisingSubscription;

  BLESetup({required this.beacon}) : super(false) {
    _isAdvertisingSubscription =
        beacon.getAdvertisingStateChange().listen((isAdvertising) {
      _isAdvertising = isAdvertising;
    });
    beacon
        .setUUID(beaconParams["uuid"])
        .setMajorId(beaconParams["major"])
        .setMinorId(beaconParams["minor"])
        .setIdentifier(beaconParams["identifier"])
        .setManufacturerId(beaconParams["manufacturerId"])
        .setExtraData(beaconParams["extraData"])
        .setLayout(beaconParams["layout"]);

    beaconBroadcast
        .checkTransmissionSupported()
        .then((isTransmissionSupported) {
      _isTransmissionSupported = isTransmissionSupported;
    });
  }

  @override
  void dispose() {
    _isAdvertisingSubscription.cancel();
    beacon.stop();
    super.dispose();
  }

  void broadcastOnOff() async {
    if (_isAdvertising) {
      print("Turning beacon off: ${beacon.isAdvertising()}");
      await beacon.stop();
      state = false;
    } else {
      await beacon.start();
      state = await true;
    }
  }

  void bleOnSwitch() async {
    final currState = await state;
    if (currState != true) {
      await beacon.start();
      state = true;
    } else {
      print("Already broadcasting");
    }
  }

  // Needed when wifi is not home network, shut off advertising
  void bleKillSwitch() async {
    await beacon.stop();
    state = await false;
    print("Turning beacon off");
  }
}

/// 2. BLE State Management

// Store whether broadcasting is on/off. Pulls the isBroadcasting Future
// from the state defined in BLESetup - which extends StateNotifier
final beaconStateProvider =
    StateNotifierProvider((ref) => BLESetup(beacon: beaconBroadcast));

// Reads the the Future isBroadcasting state. Needed since the state is a Future
// so we need a secondary function to read and update accordingly
final bleFutureStateProvider =
    FutureProvider((ref) async => await ref.watch(beaconStateProvider));

// final bleStreamStateProvider = StreamProvider((ref){
//   Stream bleStreamState = Stream.fromFuture(ref.watch(bleFutureStateProvider));
// })

// Here is where we integrate the device BT state stream and
// final getDeviceBTState = Provider.autoDispose((ref) {

//   ref.read(btDeviceStreamProvider);
// });

/// 3. BLE Clickable Card

// Dynamic icons that change colour depending on state
FaIcon bleConnIcon(AsyncValue bleState) {
  if (bleState.asData?.value == true) {
    return FaIcon(
      FontAwesomeIcons.bluetooth,
      color: Colors.green,
    );
  } else {
    return FaIcon(
      FontAwesomeIcons.bluetooth,
      color: Colors.red,
    );
  }
}

/// By clicking, we turn on or off BLE. But only if device BT is ON
class BLECard extends ConsumerWidget {
  const BLECard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBLEState = ref.watch(bleFutureStateProvider);
    // final testy = ref.watch(getDeviceBTState);

    return Container(
      child: InkWell(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentBLEState.when(
                    data: (data) => Text("Broadcasting State $data"),
                    loading: () => Text("Broadcasting State Loading"),
                    error: (e, stl) => Text("Error: $e")),
                bleConnIcon(currentBLEState.whenData((value) => value))
              ],
            ),
          ),
        ),
        onTap: () {
          ref.read(beaconStateProvider.notifier).broadcastOnOff();
        },
      ),
    );
  }
}
