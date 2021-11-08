import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Initially I tried to a) get the device Bluetooth state and b) start/stop broadcasting
/// but it became to complicated. So now breaking it up into 2 separate providers.
/// This provider simply gets/sets the device Bluetooth state
///
/// This provider returns a Future<BlutetoothState>, which is annoying to work with
/// and part of the reason

class BTDeviceState extends StateNotifier<Future<BluetoothState>> {
  final FlutterBeacon beacon;
  // Below is to allow access to the BLE provider outside of build
  final Ref ref;
  BTDeviceState({required this.beacon, required this.ref})
      : super(beacon.bluetoothState);

  Stream<BluetoothState> btDeviceStateChanged() {
    // ref.read(beaconStateProvider.notifier).bleKillSwitch();
    return beacon.bluetoothStateChanged();
  }
}

final btDeviceStateProvider = StateNotifierProvider(
    (ref) => BTDeviceState(beacon: flutterBeacon, ref: ref));

final btDeviceStreamProvider = StreamProvider.autoDispose((ref) {
  ref.onDispose(() {
    ref.read(btDeviceStateProvider.notifier).beacon.stopBroadcast();
  });

  return ref.watch(btDeviceStateProvider.notifier).btDeviceStateChanged();
});

class DeviceBTStatus extends ConsumerWidget {
  const DeviceBTStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final btStateAsyncValue = ref.watch(btDeviceStreamProvider);

    return Container(
      child: Center(
        child: btStateAsyncValue.when(
            data: (data) {
              return Text("Device Bluetooth State: $data");
            },
            loading: () => CircularProgressIndicator(),
            error: (e, st) => Text("$st")),
      ),
    );
  }
}
