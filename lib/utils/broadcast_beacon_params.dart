/// This BroadcastBeaconParams class contains the Beacon setup logic that is then passed to the
/// native code (via the BeaconChannelBridge class)
///
/// Note: this class is just a holder for the beacon parameters/settings. This class
/// doesn't need to do anything other than hold the config and pass it to the native
/// code via a map ot json method
///
class BroadcastBeaconParams {
  String uuid;
  String major;
  String minor;
  int manufacturer = 0x0118;
  int txPower = -59;

  BroadcastBeaconParams(
      {required this.uuid, required this.major, required this.minor});

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'major': major,
      'minor': minor,
      'manufacturer': manufacturer,
      'txPower': txPower,
    };
  }

  static BroadcastBeaconParams fromMap(Map<String, dynamic> map) {
    return BroadcastBeaconParams(
      uuid: map['uuid'],
      major: map['major'],
      minor: map['minor'],
    );
  }
}
