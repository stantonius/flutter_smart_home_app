import 'package:permission_handler/permission_handler.dart';

class SmartHomePermissions {
  List<Permission> permissions = [
    Permission.location,
    Permission.activityRecognition,
    Permission.locationAlways,
    Permission.bluetoothAdvertise
  ];

  // Future<Map> getPermissions() async {
  //   Map perms = {};
  //   await permissions.forEach((element) {
  //     perms[element.value] = element.status;
  //   });
  //   print(perms);
  //   return perms;
  // }

  Future<bool> requestPermission() async {
    print("Permission request called");
    await permissions.map((e) {
      return e.request();
    });

    // var result = await permissions.request();
    // result.forEach((key, value) async {
    //   if (value != PermissionStatus.granted) {
    //     await key.request();
    //   }
    // });
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
