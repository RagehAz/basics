import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';
/// TEST_THE_POPPER
class Popper extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Popper({
    required this.canGoBack,
    required this.child,
    this.onBack,
    super.key,
  });
  // -------------------------
  final bool canGoBack;
  final Function? onBack;
  final Widget child;
  // --------------------------------------------------------------------------
  static Future<void> _onPopInvoked({
    required BuildContext context,
    required Function? onBack,
    required bool canGoBack,
    required bool didPop,
  }) async {

    if (didPop == true){
      // blog('==> DID POP ALREADY');
    }

    else if (onBack != null){
      // blog('==> BACK IS OVERRIDEN : didPop : $didPop');
      await onBack.call();
    }

    else {

      if (canGoBack == true){
        // blog('==> GOING BACK : didPop : $didPop');
        await Nav.goBack(
          context: context,
          invoker: 'Popper.onGoBack',
        );
      }
      else {
        // blog('==> BACK IS BLOCKED : didPop : $didPop');
      }

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// I NEED
    /// if can go back = can press the back buttons
    /// back buttons : [ app bar back - android device back ]
    ///
    /// if onBack is defined = it overrides everything
    /// so when tapping any of those buttons
    /// it calls the overriding function
    ///
    /// that's it
    // --------------------
    /// DEPRECATED
    // return WillPopScope(
    //   key: const ValueKey<String>('Popper'),
    //   onWillPop: () async {
    //
    //     blog('on will pop aho');
    //
    //     await onGoBack(
    //       context: context,
    //       canGoBack: canGoBack,
    //       onBack: onBack,
    //     );
    //
    //     return false;
    //   },
    //   child: child,
    // );
    /// WORKS GOOD
    return PopScope(
      key: const ValueKey<String>('Popper'),
      canPop: false,
      onPopInvoked: (bool value) => _onPopInvoked(
        context: context,
        canGoBack: canGoBack,
        onBack: onBack,
        didPop: value,
      ),
      // onPopInvokedWithResult: (bool value, dynamic result) => _onPopInvoked(
      //   context: context,
      //   canGoBack: canGoBack,
      //   onBack: onBack,
      //   didPop: value,
      // ),
      child: child,
    );

    // return NavigatorPopHandler(
    //   key: const ValueKey<String>('Popper'),
    //   enabled: true,
    //   onPop: () async {
    //
    //     blog('on pop aho');
    //
    //     await onGoBack(
    //       context: context,
    //       canGoBack: canGoBack,
    //       onBack: onBack,
    //     );
    //
    //   },
    //   child: child,
    // );

  }
  // --------------------------------------------------------------------------
}
