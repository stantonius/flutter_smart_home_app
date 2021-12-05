// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:stantonsmarthome/utils/channels.dart';
// import 'broadcast_beacon_params.dart';

// /// This page contains all of the setup for the BLE Beacon
// /// FOr the most part this section is self-contained, with the exception for
// /// reading the device BT state in order to disable BLE

// /// 1. BLE Beacon setup

// // Initialize the settings for the advertising beacon

// BroadcastBeaconParams beaconParams = BroadcastBeaconParams(
//   uuid: "c8c706b9-879a-4682-ba7f-56346f4d800e",
//   major: '12121',
//   minor: '34343',
// );

// class BLESetup extends StateNotifier<bool> {
//   final BeaconChannelBridge beacon;

//   BLESetup({required this.beacon}) : super(false);

//   @override
//   void dispose() {
//     super.dispose();
//     beacon.stopBroadcastBeacon();
//   }

//   void broadcastOnOff() async {
//     if (state) {
//       print("Turning beacon off");
//       await beacon.stopBroadcastBeacon();
//       state = false;
//     } else {
//       await beacon.startBroadcastBeacon(beaconParams.toMap());
//       print("Turning beacon on");
//       state = true;
//     }
//   }

//   void bleOnSwitch() async {
//     final currState = await state;
//     if (currState != true) {
//       await beacon.startBroadcastBeacon(beaconParams.toMap());
//       state = true;
//     } else {
//       print("Already broadcasting");
//     }
//   }

//   // Needed when wifi is not home network, shut off advertising
//   void bleKillSwitch() async {
//     await beacon.stopBroadcastBeacon();
//     state = false;
//     print("Turning beacon off");
//   }
// }

// /// 2. BLE State Management

// // Store whether broadcasting is on/off. Pulls the isBroadcasting Future
// // from the state defined in BLESetup - which extends StateNotifier
// final beaconStateProvider =
//     StateNotifierProvider((ref) => BLESetup(beacon: beaconChannelBridge));

// // Reads the the Future isBroadcasting state. Needed since the state is a Future
// // so we need a secondary function to read and update accordingly
// final bleFutureStateProvider =
//     FutureProvider((ref) async => await ref.watch(beaconStateProvider));

// // final bleStreamStateProvider = StreamProvider((ref){
// //   Stream bleStreamState = Stream.fromFuture(ref.watch(bleFutureStateProvider));
// // })

// // Here is where we integrate the device BT state stream and
// // final getDeviceBTState = Provider.autoDispose((ref) {

// //   ref.read(btDeviceStreamProvider);
// // });

// /// 3. BLE Clickable Card

// // Dynamic icons that change colour depending on state
// FaIcon bleConnIcon(AsyncValue bleState) {
//   if (bleState.asData?.value == true) {
//     return FaIcon(
//       FontAwesomeIcons.bluetooth,
//       color: Colors.green,
//     );
//   } else {
//     return FaIcon(
//       FontAwesomeIcons.bluetooth,
//       color: Colors.red,
//     );
//   }
// }

// /// By clicking, we turn on or off BLE. But only if device BT is ON
// class BLECard extends ConsumerWidget {
//   const BLECard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentBLEState = ref.watch(bleFutureStateProvider);

//     return Container(
//       child: InkWell(
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 currentBLEState.when(
//                     data: (data) => Text("Broadcasting State $data"),
//                     loading: () => Text("Broadcasting State Loading"),
//                     error: (e, stl) => Text("Error: $e")),
//                 bleConnIcon(currentBLEState.whenData((value) => value))
//               ],
//             ),
//           ),
//         ),
//         onTap: () {
//           ref.read(beaconStateProvider.notifier).broadcastOnOff();
//         },
//       ),
//     );
//   }
// }
