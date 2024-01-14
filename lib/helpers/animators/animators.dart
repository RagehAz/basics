import 'package:basics/helpers/animators/sliders.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class Animators {
  // -----------------------------------------------------------------------------

  const Animators();

  // -----------------------------------------------------------------------------

  /// SWIPE DIRECTION

  // --------------------
  /// AI TESTED
  static SwipeDirection getSwipeDirection({
  required int? oldIndex,
  required int? newIndex
  }) {

    if (oldIndex == null || newIndex == null) {
      return SwipeDirection.freeze;
    }

    else {
      switch (newIndex.compareTo(oldIndex)) {
        case 1:return SwipeDirection.next;
        case -1:return SwipeDirection.back;
        default:return SwipeDirection.freeze;
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// PAGE CONTROLLERS

  // --------------------
  /*
  static void disposePageControllerIfPossible(PageController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
   */
  // --------------------
  /*
  static void disposeScrollControllerIfPossible(ScrollController controller) {
    if (controller != null) {
      controller.dispose();
    }
  }
   */
  // -----------------------------------------------------------------------------

  /// Animation<double>

  // --------------------
  /// TESTED : WORKS PERFECT
  static Animation<double>? animateDouble({
    required double? begin,
    required double? end,
    required AnimationController? controller,
    Cubic curve = Curves.easeIn,
    Cubic reverseCurve = Curves.easeIn,
  }) {

    if (begin == null || end == null || controller == null){
      return null;
    }

    else {
      return Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: curve,
        reverseCurve: reverseCurve,
      ));
    }

    /// can do stuff here
    //   ..addListener(() {
    //   // setState(() {
    //   //
    //   // });
    // })
    //   ..addStatusListener((status) {
    //     // if (status == AnimationStatus.completed) {
    //     //   _controller.reverse();
    //     // } else if (status == AnimationStatus.dismissed) {
    //     //   _controller.forward();
    //     // }
    //   })

  }
  // -----------------------------------------------------------------------------

  /// TWEEN MODS

  // --------------------
  /// AI TESTED
  static double limitTweenImpact({
    required double maxDouble,
    required double minDouble,
    required double tweenValue, // 0 -> 1
  }){

    assert(minDouble <= maxDouble, 'limitTweenImpact : minDouble can not be bigger than maxDouble');

    /// NOTE : THIS LIMITS THE IMPACT OF TWEEN VALUE TO AFFECT ONLY PART OF THE GIVEN SIZE (MAX DOUBLE)
    /// AS IT FIXES THE MINIMUM

    return minDouble + ((maxDouble - minDouble) * tweenValue);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getInverseTweenValue({
    required double? tweenValue,
  }){

    if (tweenValue == null){
      return tweenValue;
    }
    else {
      return 1 - tweenValue;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadiusTween tweenCorners({
    required BorderRadius begin,
    required BorderRadius end,
    BorderRadiusTween? cornerTween,
  }){

    return BorderRadiusTween(
      begin: begin,
      end: end,
    );

  }
  // -----------------------------------------------------------------------------
}
