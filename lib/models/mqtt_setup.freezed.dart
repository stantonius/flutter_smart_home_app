// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mqtt_setup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MQTTSetupTearOff {
  const _$MQTTSetupTearOff();

  _MQTTSetup call(
      {required String brokerIPaddress,
      required int brokerPort,
      required String clientId}) {
    return _MQTTSetup(
      brokerIPaddress: brokerIPaddress,
      brokerPort: brokerPort,
      clientId: clientId,
    );
  }
}

/// @nodoc
const $MQTTSetup = _$MQTTSetupTearOff();

/// @nodoc
mixin _$MQTTSetup {
  String get brokerIPaddress => throw _privateConstructorUsedError;
  int get brokerPort => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MQTTSetupCopyWith<MQTTSetup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MQTTSetupCopyWith<$Res> {
  factory $MQTTSetupCopyWith(MQTTSetup value, $Res Function(MQTTSetup) then) =
      _$MQTTSetupCopyWithImpl<$Res>;
  $Res call({String brokerIPaddress, int brokerPort, String clientId});
}

/// @nodoc
class _$MQTTSetupCopyWithImpl<$Res> implements $MQTTSetupCopyWith<$Res> {
  _$MQTTSetupCopyWithImpl(this._value, this._then);

  final MQTTSetup _value;
  // ignore: unused_field
  final $Res Function(MQTTSetup) _then;

  @override
  $Res call({
    Object? brokerIPaddress = freezed,
    Object? brokerPort = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_value.copyWith(
      brokerIPaddress: brokerIPaddress == freezed
          ? _value.brokerIPaddress
          : brokerIPaddress // ignore: cast_nullable_to_non_nullable
              as String,
      brokerPort: brokerPort == freezed
          ? _value.brokerPort
          : brokerPort // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MQTTSetupCopyWith<$Res> implements $MQTTSetupCopyWith<$Res> {
  factory _$MQTTSetupCopyWith(
          _MQTTSetup value, $Res Function(_MQTTSetup) then) =
      __$MQTTSetupCopyWithImpl<$Res>;
  @override
  $Res call({String brokerIPaddress, int brokerPort, String clientId});
}

/// @nodoc
class __$MQTTSetupCopyWithImpl<$Res> extends _$MQTTSetupCopyWithImpl<$Res>
    implements _$MQTTSetupCopyWith<$Res> {
  __$MQTTSetupCopyWithImpl(_MQTTSetup _value, $Res Function(_MQTTSetup) _then)
      : super(_value, (v) => _then(v as _MQTTSetup));

  @override
  _MQTTSetup get _value => super._value as _MQTTSetup;

  @override
  $Res call({
    Object? brokerIPaddress = freezed,
    Object? brokerPort = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_MQTTSetup(
      brokerIPaddress: brokerIPaddress == freezed
          ? _value.brokerIPaddress
          : brokerIPaddress // ignore: cast_nullable_to_non_nullable
              as String,
      brokerPort: brokerPort == freezed
          ? _value.brokerPort
          : brokerPort // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MQTTSetup extends _MQTTSetup with DiagnosticableTreeMixin {
  const _$_MQTTSetup(
      {required this.brokerIPaddress,
      required this.brokerPort,
      required this.clientId})
      : super._();

  @override
  final String brokerIPaddress;
  @override
  final int brokerPort;
  @override
  final String clientId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MQTTSetup(brokerIPaddress: $brokerIPaddress, brokerPort: $brokerPort, clientId: $clientId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MQTTSetup'))
      ..add(DiagnosticsProperty('brokerIPaddress', brokerIPaddress))
      ..add(DiagnosticsProperty('brokerPort', brokerPort))
      ..add(DiagnosticsProperty('clientId', clientId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MQTTSetup &&
            (identical(other.brokerIPaddress, brokerIPaddress) ||
                const DeepCollectionEquality()
                    .equals(other.brokerIPaddress, brokerIPaddress)) &&
            (identical(other.brokerPort, brokerPort) ||
                const DeepCollectionEquality()
                    .equals(other.brokerPort, brokerPort)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(brokerIPaddress) ^
      const DeepCollectionEquality().hash(brokerPort) ^
      const DeepCollectionEquality().hash(clientId);

  @JsonKey(ignore: true)
  @override
  _$MQTTSetupCopyWith<_MQTTSetup> get copyWith =>
      __$MQTTSetupCopyWithImpl<_MQTTSetup>(this, _$identity);
}

abstract class _MQTTSetup extends MQTTSetup {
  const factory _MQTTSetup(
      {required String brokerIPaddress,
      required int brokerPort,
      required String clientId}) = _$_MQTTSetup;
  const _MQTTSetup._() : super._();

  @override
  String get brokerIPaddress => throw _privateConstructorUsedError;
  @override
  int get brokerPort => throw _privateConstructorUsedError;
  @override
  String get clientId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MQTTSetupCopyWith<_MQTTSetup> get copyWith =>
      throw _privateConstructorUsedError;
}
