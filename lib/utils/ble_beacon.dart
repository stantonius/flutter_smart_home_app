import 'package:flutter_beacon/flutter_beacon.dart';

BeaconBroadcast broadcastSettings = BeaconBroadcast(
    proximityUUID: "c8c706b9-879a-4682-ba7f-56346f4d800e",
    major: 12121,
    minor: 34343,
    advertisingMode: AdvertisingMode.high);

class BLESetup {
  final beacon = flutterBeacon;

  Future<BluetoothState> btState() {
    return beacon.bluetoothState;
  }

  void broadcastOnOff() async {
    beacon.bluetoothState.then((value) => print(value));
    if (await beacon.isBroadcasting()) {
      print("Turning beacon off");
      await beacon.stopBroadcast();
    } else {
      beacon.startBroadcast(broadcastSettings);
      print("Turning beacon on");
      print(beacon.toString());
    }
  }
}
