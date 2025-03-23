import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
/// TESTED : WORKS PERFECT
void blog(dynamic msg, {String? invoker}){

    assert((){
        if (kDebugMode) {
          debugPrint(msg?.toString());
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
bool setNotifier({
  required ValueNotifier<dynamic>? notifier,
  required bool mounted,
  required dynamic value,
  bool addPostFrameCallBack = false,
  Function? onFinish,
  bool shouldHaveListeners = false,
  String? invoker,
}){
  bool _done = false;

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
            _done = true;
          }

        }

      }

    }

  }

  return _done;
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
// --------------------
Future<void> awaiter({
  required bool wait,
  required Function function,
}) async {

  if (wait == true){
    await function();
  }

  else {
    unawaited(function());
  }

}
// -----------------------------------------------------------------------------

class UnNullify<T> extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UnNullify({
    required this.value,
    required this.builder,
    this.nullChild,
    super.key
  });
  // --------------------
  final T? value;
  final Widget? nullChild;
  final Widget Function(T value) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (value == null){
      return nullChild ?? const SizedBox();
    }
    else {
      return builder(value!);
    }
    // --------------------
  }
// --------------------------------------------------------------------------
}

void bro(){
  blog('BRO');
}
