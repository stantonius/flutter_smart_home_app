//https://levelup.gitconnected.com/flutter-how-to-utilize-app-life-cycle-run-function-on-app-bootup-close-and-on-interval-cacc8d147166

//not used currently, but this is great tutorial for managing different lifecycle
//states and corresponding actions

import 'package:flutter/material.dart';

class Lifecycle extends StatefulWidget {
  final Widget child;
  const Lifecycle({required this.child});

  @override
  _LifecycleState createState() => _LifecycleState();
}

class _LifecycleState extends State<Lifecycle> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
