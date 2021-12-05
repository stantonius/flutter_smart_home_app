import 'package:permission_handler/permission_handler.dart';

class SmartHomePermissions {
  List<Permission> permissions = [
    Permission.location,
    Permission.activityRecognition,
    Permission.locationAlways,
    Permission.bluetoothAdvertise
  ];

  Future<bool> requestPermission() async {
    var result = await permissions.request();
    return true;
  }
}

void devicePermissions() async {
  var locationStatus = await Permission.location.status;
  var activityStatus = await Permission.activityRecognition.status;

  if (locationStatus.isGranted == false) {
    await Permission.location.request();
  }

  if (activityStatus.isGranted == false) {
    await Permission.activityRecognition.request();
  }

  if (locationStatus.isGranted == true) {
    await Permission.locationAlways.request();
  }

  // ToDO:
}
