import 'dart:async';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';

void pushWaitDialog({
  required BuildContext context,
  required String text,
  required Widget firstLine,
  Widget? secondLine,
  bool canManuallyGoBack = false,
}){
  WaitDialog.showUnawaitedWaitDialog(
    context: context,
    text: text,
    canManuallyGoBack: canManuallyGoBack,
    firstLine: firstLine,
    secondLine: secondLine,
  );
}

void closeWaitDialog(BuildContext context){
  unawaited(WaitDialog.closeWaitDialog(context));
}

class WaitDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WaitDialog({
    required this.firstLine,
    this.canManuallyGoBack = false,
    this.loadingText,
    this.secondLine,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final bool canManuallyGoBack;
  final String? loadingText;
  final Widget? firstLine;
  final Widget? secondLine;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void showUnawaitedWaitDialog({
    required BuildContext context,
    required String text,
    required Widget firstLine,
    Widget? secondLine,
    bool canManuallyGoBack = false,
  }) {

    unawaited(_showWaitDialog(
      context: context,
      loadingText: text,
      canManuallyGoBack: canManuallyGoBack,
      firstLine: firstLine,
      secondLine: secondLine,
    ));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showWaitDialog({
    required BuildContext context,
    required String loadingText,
    required Widget firstLine,
    Widget? secondLine,
    bool canManuallyGoBack = false,
  }) async {

    await showDialog(
      context: context,
      builder: (BuildContext ctx) => WaitDialog(
        canManuallyGoBack: canManuallyGoBack,
        loadingText: loadingText,
        firstLine: firstLine,
        secondLine: secondLine,
      ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeWaitDialog(BuildContext context) async {
    await Nav.goBack(
      context: context,
      invoker: 'closeWaitDialog',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return WillPopScope(
      onWillPop: () async {
        return !canManuallyGoBack;
      },
      child: Scaffold(
        backgroundColor: Colorz.black125,
        body: Stack(
          children: <Widget>[

            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  WidgetFader(
                    fadeType: FadeType.repeatAndReverse,
                    duration: const Duration(seconds: 1),
                    child: firstLine,
                  ),

                  if (secondLine != null)
                    WidgetFader(
                      fadeType: FadeType.repeatAndReverse,
                      duration: const Duration(milliseconds: 850),
                      curve: Curves.easeInBack,
                      child: SizedBox(
                        width: _screenWidth * 0.8,
                        child: secondLine,
                      ),
                    ),

                  const Loading(
                    color: Colorz.white200,
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
