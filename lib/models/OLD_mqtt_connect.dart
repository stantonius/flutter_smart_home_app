/// Brilliant tutorial on flutter riverpod
/// https://codewithandrea.com/videos/flutter-state-management-riverpod/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// Connect to MQTT and return the client object
/// The client object is then referenced in the app State

final String brokerIPaddress = "10.0.0.54";
final int brokerPort = 1883;
final String clientId = "homeApp";

// enum MQTTStatusTypes { Connected, Disconnected } there is an Mqtt library enum

class MQTTState {
  String brokerIP;
  int brokerPort;
  String clientId;

  MqttClient client;
  MqttConnectMessage connMess;
  MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  MqttConnectionState connStatus = MqttConnectionState.disconnected;

  MQTTState({
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

  void connect() {
    client.connectionMessage = connMess;
    try {
      client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }
    connStatus = client.connectionStatus!.state;
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

class MQTTNotifier extends StateNotifier<MQTTState> {
  MQTTNotifier()
      : super(MQTTState(
            brokerIP: brokerIPaddress,
            brokerPort: brokerPort,
            clientId: clientId));

  @override
  MQTTState get state => super.state;
}

final mqttProvider = StateNotifierProvider<MQTTNotifier, MQTTState>((ref) {
  return MQTTNotifier();
});

class MQTTCards extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mqttProvider.notifier).state.connect();
    final clientState = ref.watch(mqttProvider.notifier).state;
    return Card(child: Text(clientState.connStatus.toString()));
  }
}
