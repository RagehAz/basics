import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// LETS WINDOWS LISTEN TO SWIPES/DRAGS GESTURES
/// AND SHOULD BE PLACED IN THE TOP MOST MATERIAL APP
///  return MaterialApp(
///    scrollBehavior: AppScrollBehavior(),
///    ...
///  );
class AppScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };

}
