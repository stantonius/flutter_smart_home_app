// https://github.com/shamblett/mqtt_client/blob/master/example/mqtt_server_client.dart
// https://codewithandrea.com/videos/flutter-state-management-riverpod/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final String brokerIPaddress = "10.0.0.54";
final int brokerPort = 1883;
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

final clientReconnectStateProvider = StateProvider<int>((ref) => 0);

final clientStateProvider =
    StateNotifierProvider<MqttSetup, MqttConnectionState>((ref) => MqttSetup(
        MqttServerClient.withPort(brokerIPaddress, clientId, brokerPort,
            maxConnectionAttempts: 10)));

// final streamController = StreamController();
