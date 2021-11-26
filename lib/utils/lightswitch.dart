import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mqtt_connect.dart';

// current topic
const String pubTopic = "Lights/manualSwitch";

class LightSwitch extends ConsumerStatefulWidget {
  final String switchText;

  LightSwitch({Key? key, required this.switchText}) : super(key: key);

  @override
  _LightSwitchState createState() => _LightSwitchState();
}

class _LightSwitchState extends ConsumerState<LightSwitch> {
  bool _toggled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchListTile(
        title: Text(widget.switchText),
        value: _toggled,
        onChanged: (bool value) {
          setState(() {
            _toggled = value;
          });
          ref
              .read(clientStateProvider.notifier)
              .sendMessage(pubTopic, _toggled.toString());
        },
      ),
    );
  }
}
