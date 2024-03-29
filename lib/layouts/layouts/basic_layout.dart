import 'package:basics/components/sensors/connectivity_sensor.dart';
import 'package:basics/components/sensors/popper.dart';
import 'package:flutter/material.dart';

class BasicLayout extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BasicLayout({
    required this.body,
    this.backgroundColor = Colors.black,
    this.canGoBack = true,
    this.onBack,
    this.scaffoldKey,
    this.onConnectivityChanged,
    this.safeAreaIsOn = false,
      super.key
  });  // -----------------------------------------------------------------------------
  final Widget body;
  final Color backgroundColor;
  final bool canGoBack;
  final Function? onBack;
  final Key? scaffoldKey;
  final Function(bool isConnected)? onConnectivityChanged;
  final bool safeAreaIsOn;
  // --------------------
  /*
  Future<void> _onBack(BuildContext context) async {


    if (onBack != null){
      await onBack?.call();
    }

    else {

      FocusManager.instance.primaryFocus?.unfocus();

      if (canGoBack == true){
        await Nav.goBack(
          context: context,
          invoker: 'MainLayout._onBack',
        );
      }

    }

  }
   */
  // --------------------
  @override
  Widget build(BuildContext context) {

    return Popper(
      key: const ValueKey<String>('BasicLayout'),
      canGoBack: canGoBack,
      onBack: onBack,
      child: ConnectivitySensor(
        onConnectivityChanged: onConnectivityChanged,
        child: GestureDetector(
          onTap: (){
            /// TO CLOSE KEYBOARD ON TAP OUTSIDE
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            bottom: safeAreaIsOn,
            top: safeAreaIsOn,

            child: Scaffold(
              key: scaffoldKey ?? const ValueKey<String>('mainScaffold'),
              // appBar: AboTubeAppBar.getBackAppBar(),

              /// INSETS
              resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
              // resizeToAvoidBottomPadding: false,
              backgroundColor: backgroundColor,
              extendBodyBehindAppBar: !safeAreaIsOn,
              body: body,
            ),
          ),
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
