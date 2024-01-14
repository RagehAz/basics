import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
/// TESTED : WORKS PERFECT
void blog(dynamic msg, {String? invoker}){

    assert((){
        if (kDebugMode) {
          print(msg);
        }
      return true;
    }(), '_');

}
// --------------------
/// TESTED : WORKS PERFECT
void blogLoading({
  required bool loading,
  required String callerName,
}){
  if (loading == true) {
    blog('$callerName : LOADING --------------------------------------');
  }

  else {
    blog('$callerName : LOADING COMPLETE -----------------------------');
  }
}
// -----------------------------------------------------------------------------

/// VALUE NOTIFIER SETTER

// --------------------
/// TESTED : WORKS PERFECT
void setNotifier({
  required ValueNotifier<dynamic>? notifier,
  required bool mounted,
  required dynamic value,
  bool addPostFrameCallBack = false,
  Function? onFinish,
  bool shouldHaveListeners = false,
  String? invoker,
}){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (invoker != null){
        blog('-> setNotifier($invoker) : $value != <${notifier.value.runtimeType}>${notifier.value} ? ${value != notifier.value}');
      }

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
            if(onFinish != null){
              onFinish();
            }
          }

        }

      }

    }

  }

}
// -----------------------------------------------------------------------------
  void asyncInSync(Function? asynchronous) {

    if (asynchronous != null){

      Future<void> _start() async {}

      _start().then((_) async {
        await asynchronous();
      });

    }

  }
// -----------------------------------------------------------------------------
