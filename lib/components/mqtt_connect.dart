import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final String brokerIPaddress = "10.0.0.54";
final int brokerPort = 1883;
final String clientId = "homeApp";

/**
 * What we need from the MQTT client
 * 1) upon startup, connect to broker
 * 2) Stream any changes to the connection
 * 3) Reconnect after disconnecting
 * 4) Be able to manually shut off, and restarted manually
 * 5) Have a function that pushes messages throughout the app
 * 
 * Therefore, the MQTT class must be available throughout the app
 */

/**
 * This MQTT setup class should:
 * - store the IP, port, and clientId
 * - house the client attribute and listen to changes in connection
 */

final client = MqttServerClient.withPort(brokerIPaddress, clientId, brokerPort);
