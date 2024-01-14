import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppLifecycleObserver with WidgetsBindingObserver {

  Timer? _timer;
  final int checkInterval = 5; // in seconds, adjust as needed

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (
    state == AppLifecycleState.detached ||
    state == AppLifecycleState.inactive ||
    state == AppLifecycleState.paused
    ) {
      _stopTimer();
    }

    else {
      _startTimer();
    }

  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: checkInterval), (_) async {
      blog('XXX === >>> STARTING OBSERVATION');
    });
  }

  void _stopTimer() {
    blog('XXX === >>> STOPPING OBSERVATION');
    _timer?.cancel();
  }

}
