import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toggleBackgroundRun = StateProvider<bool>((_) => true);

class ToggleBackgroundRun extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ElevatedButton(
        child: ref.watch(toggleBackgroundRun)
            ? Text('Toggle background OFF')
            : Text('Toggle background ON'),
        onPressed: () {
          ref.read(toggleBackgroundRun.notifier).state =
              !ref.read(toggleBackgroundRun.notifier).state;
        },
      ),
    );
  }
}
