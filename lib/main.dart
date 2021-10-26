import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stantonsmarthome/components/switch.dart';
import 'package:stantonsmarthome/theme/custom_theme.dart';
import 'package:stantonsmarthome/utils/ble_beacon.dart';
import 'package:stantonsmarthome/utils/device_bluetooth.dart';
import 'package:stantonsmarthome/utils/geofence.dart';
import 'package:stantonsmarthome/utils/mqtt_connect.dart';
import 'package:stantonsmarthome/utils/wifi_setup.dart';
import 'package:permission_handler/permission_handler.dart';

void devicePermissions() async {
  // await Permission.bluetooth.
  // await Permission.location.request().isGranted;
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.activityRecognition,
  ].request();
  print(statuses[Permission.location]);
}

// Remi recommends against this but I have no other way
final container = ProviderContainer();

void testFunction() async {
  // callbackDispatcher();
}

void main() {
  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      home: MyHomePage(title: 'Stanton Smart Home'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    devicePermissions();

    // ref.read(clientStateProvider.notifier).connect();
    // ref.read(beaconStateProvider.notifier).bleOnSwitch();
    // workManager.initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode:
    //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    //     );
    // registerWorkmanagerTasks();

    // Future.delayed(Duration(seconds: 20), testFunction);
    super.initState();
    geofenceCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Row(
                  children: [Expanded(child: WifiStatus())],
                ),
                Row(
                  children: [Expanded(child: DeviceBTStatus())],
                ),
                Row(
                  children: [Expanded(child: GeofenceDetails())],
                ),
                Row(
                  children: [Expanded(child: ActivityDetails())],
                ),
                Row(
                  children: [Expanded(child: MqttCard())],
                ),
                Row(
                  children: [Expanded(child: BLECard())],
                )
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 75),
          ),
          Row(
            children: [
              Expanded(
                  child: Card(child: LightSwitch(switchText: "Bedroom Light"))),
            ],
          ),
        ],
      ),
    );
  }
}
