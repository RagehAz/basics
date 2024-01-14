import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:flutter/material.dart';

class Searching {
  // --------------------------------------------------------------------------

  const Searching();

  // --------------------------------------------------------------------------

  /// SEARCH TRIGGERS

  // --------------------
  /// AI TESTED
  static bool triggerIsSearching({
    required String? text,
    int minCharLimit = 3,
  }){

    if (text != null && text.length >= minCharLimit){
      return true;
    }
    else {
      return  false;
    }

  }
  // --------------------
  /// AI TESTED
  static void triggerIsSearchingNotifier({
    required String? text,
    required ValueNotifier<bool> isSearching,
    required bool mounted,
    int minCharLimit = 3,
    Function? onSwitchOff,
    Function? onResume,
  }){

    /// WHEN GOING MORE THAN MIN LENGTH
    if (text != null && text.length >= minCharLimit){

      /// ONLY SWITCH ON SEARCHING IF ITS NOT ALREADY ON
      if (isSearching.value != true){
        setNotifier(notifier: isSearching, mounted: mounted, value: true);
      }

      /// SHOULD FIRE WITH EACH TEXT CHANGE WHILE SEARCHING
      if (onResume != null){
        onResume();
      }

    }

    /// WHEN GOING LESS THAN MIN LENGTH
    else {

      /// ONLY SWITCH OFF SEARCHING IF ITS NOT ALREADY OFF
      if (isSearching.value != false){

        setNotifier(notifier: isSearching, mounted: mounted, value: false);

        /// SHOULD FIRE ONCE ON SWITCHING ON EVENT
        if (onSwitchOff != null){
          onSwitchOff();
        }

      }

    }

  }
  // --------------------------------------------------------------------------

  /// CANCEL SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onCancelSearch({
    required TextEditingController? controller,
    required ValueNotifier<dynamic>? foundResultNotifier,
    required ValueNotifier<bool>? isSearching,
    required Function? closKeyboardFunction,
    required bool mounted,
  }) async {

    // await Keyboard.closeKeyboard();

    await closKeyboardFunction?.call();

    controller?.text = '';

    if (foundResultNotifier != null){
      setNotifier(
          notifier: foundResultNotifier,
          mounted: mounted,
          value: null
      );
    }

    if (isSearching != null){
      setNotifier(
          notifier: isSearching,
          mounted: mounted,
          value: false
      );
    }

  }
  // --------------------------------------------------------------------------
}
