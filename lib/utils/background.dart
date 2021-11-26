import 'package:permission_handler/permission_handler.dart';

void devicePermissions() async {
  var locationStatus = await Permission.location.status;
  var activityStatus = await Permission.activityRecognition.status;
  var bluetoothAdvertiseStatus = await Permission.bluetoothAdvertise.status;

  if (locationStatus.isGranted == false) {
    await Permission.location.request();
  }

  if (activityStatus.isGranted == false) {
    await Permission.activityRecognition.request();
  }

  if (locationStatus.isGranted == true) {
    await Permission.locationAlways.request();
  }

  if (bluetoothAdvertiseStatus.isGranted == false) {
    await Permission.bluetoothAdvertise.request();
  }

  // ToDO:
}
