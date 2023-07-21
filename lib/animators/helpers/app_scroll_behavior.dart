import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// => TAMAM
class AppScrollBehavior extends MaterialScrollBehavior {

  const AppScrollBehavior();
  /// LETS WINDOWS LISTEN TO SWIPES/DRAGS GESTURES
  /// AND SHOULD BE PLACED IN THE TOP MOST MATERIAL APP
  ///  return MaterialApp(
  ///    scrollBehavior: AppScrollBehavior(),
  ///    ...
  ///  );
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
  };

}
