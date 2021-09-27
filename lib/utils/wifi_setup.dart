import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';

final networkInfo = NetworkInfo();

final controller = StreamController<String>();

final networkStreamProvider = StreamProvider((ref) {
  Stream wifiStream = Stream.periodic(Duration(seconds: 2), (_) {
    return networkInfo.getWifiName();
  });

  return wifiStream;
});
