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

class SingleChildScrollViewX extends StatelessWidget {

  const SingleChildScrollViewX({
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.physics,
    this.reverse = false,
    this.padding,
    this.primary = false,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Axis scrollDirection;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool primary;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const AppScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        controller: controller,
        physics: physics,
        reverse: reverse,
        padding: padding,
        primary: primary,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        child: child,
      ),
    );
  }
}
