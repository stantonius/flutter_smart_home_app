import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final String brokerIPaddress = "10.0.0.54";
final int brokerPort = 1883;
final String clientId = "homeApp";

class MQTTSetup {
  String brokerIP;
  int brokerPort;
  String clientId;

  MqttClient client;
  MqttConnectMessage connMess;
  MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  MqttConnectionState connStatus = MqttConnectionState.faulted;

  MQTTSetup({
    required this.brokerIP,
    required this.brokerPort,
    required this.clientId,
  })  : client = MqttServerClient.withPort(brokerIP, clientId, brokerPort),
        connMess = MqttConnectMessage()
            .withClientIdentifier(clientId)
            // .withWillTopic('willtopic') // If you set this you must set a will message
            // .withWillMessage('My Will message')
            .startClean() // Non persistent session for testing
            .withWillQos(MqttQos.atLeastOnce);

  void connect() async {
    client.connectionMessage = connMess;
    await client.connect();
  }

  void disconnect() {
    client.disconnect();
  }

  String get topic => topic;

  set topic(pubTopic) {
    topic = pubTopic;
  }

  void sendMQTTstring(msg) {
    builder.addString(msg);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }
}

class MQTTNotifier extends StateNotifier<MQTTSetup> {
  MQTTNotifier()
      : super(MQTTSetup(
            brokerIP: brokerIPaddress,
            brokerPort: brokerPort,
            clientId: clientId));

  void connectio() {
    state.connect();
  }

  void disconnect() {
    state.disconnect();
    state.connStatus = state.client.connectionStatus!.state;
  }
}

// new with riverpod, you must specify the notifier type and the returned state type
final mqttProvider = StateNotifierProvider<MQTTNotifier, MQTTSetup>((ref) {
  return MQTTNotifier();
});

class MQTTCards extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientState = ref.watch(mqttProvider).connStatus;
    print("CALLED");
    return Card(child: Text(clientState.toString()));
  }
}
