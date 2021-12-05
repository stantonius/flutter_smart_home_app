import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stantonsmarthome/utils/lightswitch.dart';
import 'package:stantonsmarthome/theme/custom_colours.dart';
import 'package:stantonsmarthome/theme/custom_theme.dart';
import 'package:stantonsmarthome/utils/background.dart';
import 'package:stantonsmarthome/utils/ble_beacon.dart';
import 'package:stantonsmarthome/utils/device_bluetooth.dart';
import 'package:stantonsmarthome/utils/geofence.dart';
import 'package:stantonsmarthome/utils/mqtt_connect.dart';
import 'package:stantonsmarthome/utils/wifi_setup.dart';

// Remi recommends against this but I have no other way to acess the state
// outside of Consumer widget and Providers
final container = ProviderContainer();

void testFunction() async {
  // callbackDispatcher();
}

void main() {
  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
  geofenceCallbacks();
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

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   container.read(beaconStateProvider.notifier).bleKillSwitch();
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   print("App Lifecycle State: ${state}");
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // devicePermissions();
    return geofenceWidgetWrapper(
      Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: Drawer(
            backgroundColor: CustomColours.background,
            child: ListView(children: <Widget>[
              DrawerHeader(child: Text("Settings")),
              ListTile(
                title: Text('Enable Required Permissions'),
                onTap: () {
                  devicePermissions();
                },
              )
            ])),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Row(
                    children: [Expanded(child: WifiStatus())],
                  ),
                  // Row(
                  //   children: [Expanded(child: DeviceBTStatus())],
                  // ),
                  Row(
                    children: [Expanded(child: GeofenceDetails())],
                  ),
                  Row(
                    children: [Expanded(child: ActivityDetails())],
                  ),
                  Row(
                    children: [Expanded(child: MqttCard())],
                  ),
                  // Row(
                  //   children: [Expanded(child: BLECard())],
                  // )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 75),
            ),
            Row(
              children: [
                Expanded(
                    child:
                        Card(child: LightSwitch(switchText: "Bedroom Light"))),
              ],
            ),
            Row(
              children: [
                // Expanded(child: SampleAndroidAPI()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
