import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';

final networkInfo = NetworkInfo();

// Future<String> wifiName() async {
//   return await networkInfo.getWifiName() ?? "None";
// }

final networkStreamProvider = StreamProvider((ref) {
  Stream wifiStream = Stream.periodic(Duration(seconds: 30), (_) {
    return networkInfo.getWifiName();
  });

  return wifiStream.asyncMap((event) async {
    final eventRes = await event;
    print("This is the network: $eventRes");
    return eventRes;
  });
});

class WifiStatus extends ConsumerWidget {
  const WifiStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wifiAsyncValue = ref.watch(networkStreamProvider);
    return Container(
      child: Center(
          child: wifiAsyncValue.when(
              data: (data) {
                return Text("Current Wifi Network: $data");
              },
              loading: (asyncVal) => CircularProgressIndicator(),
              error: (e, st, asyncVal) => Text("$st"))),
    );
  }
}
