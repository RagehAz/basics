import 'dart:async';
import 'package:basics/helpers/maps/lister.dart';
import 'package:flutter/material.dart';
/// => TAMAM
abstract class Streamer {
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){

    /// this page has all functions that are related to streams checking
    if (snapshot.connectionState == ConnectionState.waiting){
      return true;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  /*
  bool _connectionHasData(AsyncSnapshot<dynamic> snapshot){
    return snapshot?.hasData ;
  }
 */
  // --------------------
  /*
  bool valueIsLoading(dynamic value){

    bool _isLoading;

    if (value == null){
      _isLoading = true;
    }

    else {
      _isLoading = false;
    }

    return _isLoading;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){

    if (
    _connectionIsWaiting(snapshot) == true
    //     ||
    // _connectionHasData(snapshot) == false
    //     ||
    // snapshot.error == null
    ){
      return true;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// STREAM SUBSCRIPTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> disposeStreamSubscriptions(List<StreamSubscription>? subs) async {

    if (Lister.checkCanLoop(subs) == true){

      for (final StreamSubscription sub in subs!){

        // if (sub != null){
          await sub.cancel();
        // }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
