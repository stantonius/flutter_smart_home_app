import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// This page contains all of the setup for the BLE Beacon
/// FOr the most part this section is self-contained, with the exception for
/// reading the device BT state in order to disable BLE

/// 1. BLE Beacon setup

BeaconBroadcast beaconBroadcast = BeaconBroadcast();

// BeaconBroadcast broadcastSettings = BeaconBroadcast(
//     proximityUUID: "c8c706b9-879a-4682-ba7f-56346f4d800e",
//     major: 12121,
//     minor: 34343,
//     advertisingMode: AdvertisingMode.high);

class BLESetup extends StateNotifier<Future<bool?>> {
  final BeaconBroadcast beacon;

  BLESetup({required this.beacon}) : super(beacon.isAdvertising()) {
    beaconBroadcast
        .setUUID('c8c706b9-879a-4682-ba7f-56346f4d800e')
        // .setMajorId(12121)
        // .setMinorId(34343)
        .setTransmissionPower(-59) //optional
        .setAdvertiseMode(AdvertiseMode.lowPower) //Android-only, optional
        .setLayout(
            's:0-1=feaa,m:2-2=10,p:3-3:-41,i:4-21v') //Android-only, optional
        .setManufacturerId(0x001D) //Android-only, optional
        .start();
  }

  @override
  void dispose() {
    super.dispose();
    beacon.stop();
  }

  void broadcastOnOff() async {
    final advertStatus = await beacon.isAdvertising();
    if (advertStatus == true) {
      print("Turning beacon off");
      await beacon.stop();
      state = beacon.isAdvertising();
    } else {
      await beacon.start();
      print("Turning beacon on");
      state = beacon.isAdvertising();
    }
  }

  void bleOnSwitch() async {
    final currState = await state;
    if (currState != true) {
      await beacon.start();
      state = beacon.isAdvertising();
    } else {
      print("Already broadcasting");
    }
  }

  // Needed when wifi is not home network, shut off advertising
  void bleKillSwitch() async {
    await beacon.stop();
    state = beacon.isAdvertising();
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
                    loading: (asyncVal) => Text("Broadcasting State Loading"),
                    error: (e, st, asyncVal) => Text("Error: $e")),
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
