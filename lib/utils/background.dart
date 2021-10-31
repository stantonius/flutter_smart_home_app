import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// class SmartHomePermissions {

//   bool requiredPermissionsGranted = false;

//   static Future<bool> checkAndRequestPermissions() async {
//     bool isPermissionGranted = await _checkPermissions();
//     if (!isPermissionGranted) {
//       await _requestPermissions();
//     }
//     return isPermissionGranted;
//   }

//   static Future<bool> _checkPermissions() async {
//     bool isPermissionGranted = true;
//     PermissionStatus permissionStatus = await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.location);
//     if (permissionStatus != PermissionStatus.granted) {
//       isPermissionGranted = false;
//     }
//     return isPermissionGranted;
//   }

//   static Future<void> _requestPermissions() async {
//     var locationStatus = await Permission.location.status;
//     var activityStatus = await Permission.activityRecognition.status;
//   }

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
