// main.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mqtt_setup.freezed.dart';

@freezed
abstract class MQTTSetup with _$MQTTSetup {
  const MQTTSetup._();
  const factory MQTTSetup(
      {required String brokerIPaddress,
      required int brokerPort,
      required String clientId}) = _MQTTSetup;
}
