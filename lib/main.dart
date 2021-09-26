import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_app/components/clickable_card.dart';
import 'package:home_app/components/switch.dart';
import 'package:home_app/theme/custom_theme.dart';
import 'package:home_app/utils/ble_beacon.dart';
import 'package:home_app/utils/mqtt_connect.dart';

final blestate = BLESetup();

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
                    Expanded(child: Card(child: Text(clientState.toString()))),
                    Expanded(
                      child: ClickableCard(
                          clickFunction:
                              ref.read(clientStateProvider.notifier).disconnect,
                          cardText: clientState.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ClickableCard(
                      cardText: "BLE clicker",
                      clickFunction: blestate.broadcastOnOff,
                    ))
                  ],
                )
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 75),
          ),
          Row(
            children: [
              TextButton(
                child: Text("Disconnect"),
                onPressed: () {
                  print("Hello");
                  ref.read(clientStateProvider.notifier).disconnect();
                },
              ),
              TextButton(
                child: Text("Connect"),
                onPressed: () {
                  print("CCCConnect hit");
                  ref.read(clientStateProvider.notifier).connect();
                },
              )
            ],
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
