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
  static Future<void> onGoBack({
    required BuildContext context,
    required Function? onBack,
    required bool canGoBack,
  }) async {

    if (onBack != null){
      await onBack.call();
    }

    else {

      if (canGoBack == true){
        await Nav.goBack(
          context: context,
          invoker: 'Popper.onGoBack',
        );
      }

    }

  }
  // -------------------------
  @override
  Widget build(BuildContext context) {

    // return WillPopScope(
    //   key: const ValueKey<String>('Popper'),
    //   onWillPop: () async {
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

    return PopScope(
      key: const ValueKey<String>('Popper'),
      canPop: canGoBack,
      onPopInvoked: (bool value) => onGoBack(
        context: context,
        canGoBack: canGoBack,
        onBack: onBack,
      ),
      child: child,
    );

  }
  // --------------------------------------------------------------------------
}
