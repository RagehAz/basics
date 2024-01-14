import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
export 'package:page_transition/page_transition.dart';
/// => TAMAM
class Nav {
  // -----------------------------------------------------------------------------

  const Nav();

  // -----------------------------------------------------------------------------
  static const Duration duration150ms = Duration(milliseconds: 300);
  static const Curve transitionCurve = Curves.fastOutSlowIn;
  // -----------------------------------------------------------------------------

  /// TRANSITION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> transit({
    required Widget screen,
    required PageTransitionType pageTransitionType,
    RouteSettings? settings,
  }) {
    return PageTransition<dynamic>(
      child: screen,
      type: pageTransitionType,
      duration: duration150ms,
      reverseDuration: duration150ms,
      curve: transitionCurve,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> transitFade({
    required Widget screen,
    RouteSettings? settings,
  }) {
    return transit(
      screen: screen,
      pageTransitionType: PageTransitionType.fade,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> transitSuperHorizontal({
    required Widget screen,
    required bool appIsLTR,
    required bool enAnimatesLTR,
    RouteSettings? settings,
  }) {
    return transit(
      screen: screen,
      pageTransitionType: superHorizontalTransition(
        appIsLTR: appIsLTR,
        enAnimatesLTR: enAnimatesLTR,
      ),
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransitionType superHorizontalTransition({
    bool appIsLTR = true, /// LEFT => RIGHT (ENGLISH)
    bool enAnimatesLTR = false,
    bool withFade = false,
  }) {
    /// NOTE: IMAGINE OPENING AN ENGLISH BOOK => NEXT PAGE COMES FROM RIGHT TO LEFT

    if (withFade == true){

      /// LEFT TO RIGHT (EN)
      if (appIsLTR == true){

        return enAnimatesLTR == true ?
        /// INVERSE : ---> LEFT TO RIGHT
        PageTransitionType.leftToRightWithFade
            :
        /// NORMAL : <--- RIGHT TO LEFT (LIKE A BOOK)
        PageTransitionType.rightToLeftWithFade;
      }

      /// RIGHT TO LEFT (AR)
      else {
        return enAnimatesLTR == true ?
        /// INVERSE : <--- RIGHT TO LEFT
        PageTransitionType.rightToLeftWithFade
            :
        /// NORMAL : ---> LEFT TO RIGHT (LIKE A BOOK)
        PageTransitionType.leftToRightWithFade;
      }

    }

    else {

      /// LEFT TO RIGHT (EN)
      if (appIsLTR == true){

        return enAnimatesLTR == true ?
        /// INVERSE : ---> LEFT TO RIGHT
        PageTransitionType.leftToRight
            :
        /// NORMAL : <--- RIGHT TO LEFT (LIKE A BOOK)
        PageTransitionType.rightToLeft;
      }

      /// RIGHT TO LEFT (AR)
      else {
        return enAnimatesLTR == true ?
        /// INVERSE : <--- RIGHT TO LEFT
        PageTransitionType.rightToLeft
            :
        /// NORMAL : ---> LEFT TO RIGHT (LIKE A BOOK)
        PageTransitionType.leftToRight;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// PUSH WIDGET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
    required BuildContext context,
    required Widget screen,
    required bool appIsLTR,
    PageTransitionType? pageTransitionType,
    Duration duration = const Duration(milliseconds: 300),
    Widget? childCurrent,
  }) async {

    final dynamic _result = await Navigator.push(
      context,
      PageTransition<dynamic>(
        type: pageTransitionType ?? Nav.superHorizontalTransition(
          enAnimatesLTR: true,
          appIsLTR: appIsLTR,
          // withFade: false,
        ),
        childCurrent: childCurrent,
        child: screen,
        duration: duration,
        reverseDuration: duration,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.bottomCenter,

      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> replaceScreen({
    required BuildContext context,
    required Widget screen,
    PageTransitionType transitionType = PageTransitionType.bottomToTop,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
  }) async {

    final dynamic _result = await Navigator.pushReplacement(
        context,
        PageTransition<dynamic>(
          type: transitionType,
          child: screen,
          duration: duration,
          reverseDuration: reverseDuration,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.bottomCenter,
        )
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushAndRemoveAllBelow({
    required BuildContext context,
    required Widget screen,
  }) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => screen,
        ),
            (Route<dynamic> route) => false);


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushAndRemoveUntil({
    required BuildContext context,
    required Widget screen,
  }) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => screen,
        ),
            (Route<dynamic> route) => route.isFirst);
  }
  // -----------------------------------------------------------------------------

  /// PUSH ROUTE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> replaceRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushReplacementNamed(routezName, arguments: arguments);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushNamedAndRemoveAllBelow({
    required BuildContext context,
    required String goToRoute,
    bool closeAppOnFinish = true,
  }) async {

    final dynamic _result = await Navigator.of(context).pushNamedAndRemoveUntil(
            goToRoute,
            (Route<dynamic> route) => false
    );

    if (closeAppOnFinish == true){
      blog('pushNamedAndRemoveAllBelow : _result: $_result');
      await closeApp();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushHomeAndRemoveAllBelow({
    required BuildContext context,
    required String homeRoute,
    required String invoker,
  }) async {

    blog('pushHomeAndRemoveAllBelow : $invoker');

    await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: homeRoute,
    );

  }
  // -----------------------------------------------------------------------------

  /// GOING BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBack({
    required BuildContext? context,
    String? invoker,
    dynamic passedData,
    bool addPostFrameCallback = false,
  }) async {

    // await CacheOps.wipeCaches();

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context, passedData);
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.pop(context, passedData);
        });
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeApp() async {
    await SystemNavigator.pop();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBackUntil({
    required BuildContext? context,
    required String routeName,
    bool addPostFrameCallback = false,
  }) async {

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }


    }

  }
  // -----------------------------------------------------------------------------

  /// I DONT KNO ABOUT THIS SHIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
  }
  // -----------------------------------------------------------------------------
}
