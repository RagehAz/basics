import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';

/// GoHomeOnMaxBounce
class MaxBounceNavigator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MaxBounceNavigator({
    required this.child,
    this.boxDistance,
    this.numberOfScreens = 1,
    this.onNavigate,
    this.notificationListenerKey,
    this.axis = Axis.vertical,
    this.isOn = true,
    this.slideLimitRatio = 0.18,
    this.onlyBack = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? boxDistance;
  final int numberOfScreens;
  final Widget child;
  final Function? onNavigate;
  final Key? notificationListenerKey;
  final Axis axis;
  final bool isOn;
  final double slideLimitRatio;
  final bool onlyBack;
  /// --------------------------------------------------------------------------
  @override
  _MaxBounceNavigatorState createState() => _MaxBounceNavigatorState();
  /// --------------------------------------------------------------------------
}

class _MaxBounceNavigatorState extends State<MaxBounceNavigator> {
  // -----------------------------------------------------------------------------
  bool _canNavigate = true;
  // --------------------
  Future<void> navigate() async {

      _canNavigate = false;

    if (widget.onNavigate == null) {

      await Nav.goBack(
        context: context,
        invoker: 'OldMaxBounceNavigator.navigate',
      );

    }

    else {

      if (widget.onNavigate != null){
       await widget.onNavigate?.call();
      }
      _canNavigate = true;

    }
  }
  // --------------------
  // bool _goesBackOnlyCheck() {
  //   bool _goesBack;
  //
  //   if (widget.axis == Axis.vertical) {
  //     _goesBack = true;
  //   } else {
  //     _goesBack = false;
  //   }
  //
  //   return _goesBack;
  // }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.isOn == true){

      final double _height = widget.boxDistance ?? Scale.screenHeight(context);
      final double _width = widget.boxDistance ?? Scale.screenHeight(context);
      final double _boxDistance = widget.axis == Axis.vertical ? _height : _width;

      return NotificationListener<ScrollUpdateNotification>(
        key: widget.notificationListenerKey,
        onNotification: (ScrollUpdateNotification details) {

          /// CAN SLIDE WHEN ( SLIDE LIMIT REACHED )
          final bool _canSlide = Sliders.checkCanSlide(
            details: details,
            boxDistance: _boxDistance,
            numberOfBoxes: widget.numberOfScreens,
            goesBackOnly: widget.onlyBack,
            axis: widget.axis,
            slideLimitRatio: widget.slideLimitRatio,
          );

          // blog('_canSlide : $_canSlide : _canNavigate : $_canNavigate');

          if (_canSlide == true && _canNavigate == true) {
            navigate();
          }

          return true;
        },
        child: widget.child,
      );


    }

    else {
      return widget.child;
    }

  }
  // -----------------------------------------------------------------------------
}
