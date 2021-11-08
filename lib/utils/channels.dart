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
  static const platform = MethodChannel('com.stantonius/beacon');

  String _deviceTransmissionSupport = 'Unknown device transmission support';

  Future<void> _checkDeviceTransmissionSupport() async {
    String deviceTransmissionSupport;
    try {
      final int result =
          await platform.invokeMethod('checkDeviceTransmissionSupport');
      deviceTransmissionSupport = 'Device transmission support is $result % .';
    } on PlatformException catch (e) {
      deviceTransmissionSupport =
          "Failed to get device transmission support: '${e.message}'.";
    }

    setState(() {
      _deviceTransmissionSupport = deviceTransmissionSupport;
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
              onPressed: _checkDeviceTransmissionSupport,
            ),
            Text(_deviceTransmissionSupport),
          ],
        ),
      ),
    );
  }
}
