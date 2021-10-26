// https://github.com/shamblett/mqtt_client/blob/master/example/mqtt_server_client.dart
// https://codewithandrea.com/videos/flutter-state-management-riverpod/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:stantonsmarthome/utils/local_vars.dart';

final String brokerIPaddress = local_vars['brokerIPaddress'];
final int brokerPort = local_vars['brokerPort'];
final String clientId = "homeApp";

class MqttSetup extends StateNotifier<MqttConnectionState> {
  MqttServerClient client;
  MqttSetup(this.client) : super(client.connectionStatus!.state);

  final connMess = MqttConnectMessage()
      .withClientIdentifier(clientId)
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);

  void setups() {
    client.connectionMessage = connMess;
    client.onDisconnected = onDisconnect;
    client.onConnected = onConnect;
    client.autoReconnect = true;
    client.onAutoReconnect = onReconnecting;
    client.onAutoReconnected = onReconnected;
  }

  void connect() async {
    setups();
    try {
      await client.connect();
      state = client.connectionStatus!.state;
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('MQTT client connection exception - $e');
      client.disconnect();
      state = MqttConnectionState.faulted;
    } on SocketException catch (e) {
      print('MQTT client connection exception - $e');
      client.disconnect();
      state = MqttConnectionState.disconnected;
    }
  }

  void disconnect() {
    client.disconnect();
    state = client.connectionStatus!.state;
  }

  // callback for when disconnected
  // this does not set state - that is done in disconnect()
  void onDisconnect() {
    print("onDisconnected callback");
  }

  void onConnect() {
    print("onConnect callback");
  }

  // callback for when trying to reconnect
  void onReconnecting() {
    state = MqttConnectionState.connecting;
    print("Reconnecting...");
  }

  void onReconnected() {
    state = client.connectionStatus!.state;
    print("Reconnected");
  }

  void sendMessage(String pubTopic, String msg) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }
}

// final clientReconnectStateProvider = StateProvider<int>((ref) => 0);

final clientStateProvider =
    StateNotifierProvider<MqttSetup, MqttConnectionState>((ref) => MqttSetup(
        MqttServerClient.withPort(brokerIPaddress, clientId, brokerPort,
            maxConnectionAttempts: 10)));

// final streamController = StreamController();

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

class MqttCard extends ConsumerWidget {
  const MqttCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientState = ref.watch(clientStateProvider);
    return Container(
        child: InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MQTT State: $clientState"),
              mqttConnIcon(ref.read(clientStateProvider))
            ],
          ),
        ),
      ),
      onTap: () {
        ref.read(clientStateProvider) == MqttConnectionState.connected
            ? ref.read(clientStateProvider.notifier).disconnect()
            : ref.read(clientStateProvider.notifier).connect();
      },
    ));
  }
}
