import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_app/components/clickable_card.dart';
import 'package:home_app/components/switch.dart';
import 'package:home_app/theme/custom_theme.dart';
import 'package:home_app/utils/ble_beacon.dart';
import 'package:home_app/utils/mqtt_connect.dart';
import 'package:home_app/utils/wifi_setup.dart';
import 'package:mqtt_client/mqtt_client.dart';

final blestate = BLESetup();

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
                      child: wifiAsyncValue.map(
                          data: (data) => Text("Current Wifi Network is $data"),
                          loading: () => CircularProgressIndicator(),
                          error: (e, st) => Text('Error: $e')),
                    ))
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
