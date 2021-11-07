/// Channels for creating platform-specific code to integrate with our Flutter app

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SampleAndroidAPI extends StatefulWidget {
  SampleAndroidAPI({Key? key}) : super(key: key);

  @override
  _SampleAndroidAPIState createState() => _SampleAndroidAPIState();
}

class _SampleAndroidAPIState extends State<SampleAndroidAPI> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Is Transmission Supported?'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
