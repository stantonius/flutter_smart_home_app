import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stantonsmarthome/components/clickable_card.dart';
import 'package:stantonsmarthome/components/switch.dart';
import 'package:stantonsmarthome/theme/custom_theme.dart';
import 'package:stantonsmarthome/utils/ble_beacon.dart';
import 'package:stantonsmarthome/utils/mqtt_connect.dart';
import 'package:stantonsmarthome/utils/wifi_setup.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final blestate = BLESetup();

final networkInfo = NetworkInfo();

void deets() async {
  // networkInfo.getWifiName().then((value) => print("THIS IS VALUE $value"));
  // print(await Permission.location.isGranted);
  await Permission.location.request().isGranted;
}

// icons for service states
FaIcon mqttConnIcon(MqttConnectionState mqttConnectionState) {
  if (mqttConnectionState == MqttConnectionState.connected) {
    return FaIcon(
      FontAwesomeIcons.check,
      color: Colors.green,
    );
  } else {
    return FaIcon(
      FontAwesomeIcons.exclamationTriangle,
      color: Colors.red,
    );
  }
}

FaIcon bleConnIcon(MqttConnectionState mqttConnectionState) {
  if (mqttConnectionState == MqttConnectionState.connected) {
    return FaIcon(
      FontAwesomeIcons.check,
      color: Colors.green,
    );
  } else {
    return FaIcon(
      FontAwesomeIcons.exclamationTriangle,
      color: Colors.red,
    );
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
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
    deets();
    ref.read(clientStateProvider.notifier).connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientState = ref.watch(clientStateProvider);
    final wifiAsyncValue = ref.watch(networkStreamProvider);

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
                  children: [
                    Expanded(
                        child: Center(
                            child: wifiAsyncValue.when(
                                data: (data) {
                                  return Text("$data");
                                },
                                loading: () => CircularProgressIndicator(),
                                error: (e, st) => Text("$st"))))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ClickableCard(
                        clickFunction: ref.read(clientStateProvider) ==
                                MqttConnectionState.connected
                            ? ref.read(clientStateProvider.notifier).disconnect
                            : ref.read(clientStateProvider.notifier).connect,
                        cardText: clientState.toString(),
                        icon: mqttConnIcon(ref.read(clientStateProvider)),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ClickableCard(
                      cardText: "BLE clicker",
                      clickFunction: blestate.broadcastOnOff,
                      icon: FaIcon(FontAwesomeIcons.bluetooth),
                    ))
                  ],
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
