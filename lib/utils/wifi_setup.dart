import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';

final networkInfo = NetworkInfo();

// Future<String> wifiName() async {
//   return await networkInfo.getWifiName() ?? "None";
// }

final networkStreamProvider = StreamProvider((ref) {
  Stream wifiStream = Stream.periodic(Duration(seconds: 2), (_) {
    return networkInfo.getWifiName();
  });

  return wifiStream.asyncMap((event) async => await event);
});
