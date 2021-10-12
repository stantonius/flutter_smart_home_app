// import 'package:flutter_beacon/flutter_beacon.dart';
// import 'package:stantonsmarthome/main.dart';
// import 'package:stantonsmarthome/utils/ble_beacon.dart';
// import 'package:workmanager/workmanager.dart';

// /// The callbackDispatcher initiates a Workmanager task
// /// Workmanager tasks must first be registered elsewhere in the code
// /// Then the registered task, and any input data needed (passed as a map),
// /// are given to the callbackDispatcher.
// /// It is within each case in the callbackDispatcher that the background function
// /// is specified.

// final workManager = Workmanager();

// const checkBLE = "checkBLE";

// void callbackDispatcher() {
//   workManager.executeTask((task, inputData) async {
//     switch (task) {
//       case checkBLE:
//         final beacon = flutterBeacon;
//         beacon.startBroadcast(broadcastSettings);
//         // container.read(beaconStateProvider.notifier).bleOnSwitch();
//         print("Starting background task - turning on BLE");

//         // final bleStateNotifier = container.read(beaconStateProvider.notifier);
//         // bleStateNotifier.bleKillSwitch();
//         // print("Ending background task. Current state is $currentBLEState");
//         break;
//     }
//     //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

// void registerWorkmanagerTasks() {
//   workManager.registerPeriodicTask("1", checkBLE,
//       // initialDelay: Duration(minutes: 2),
//       frequency: Duration(minutes: 2));
// }
