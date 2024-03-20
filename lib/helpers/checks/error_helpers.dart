// ignore_for_file: avoid_catches_without_on_clauses
import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';

@immutable
class HttpException implements Exception {
  /// --------------------------------------------------------------------------
  const HttpException(this.message);
  /// --------------------------------------------------------------------------
  final String message;
  /// --------------------------------------------------------------------------
  @override
  String toString() {
    return message;
    // return super.toString(); // instance of HttpException
  }
  /// --------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------

/// TRY AND CATCH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> tryAndCatch({
  required Future<void> Function() functions,
  String? invoker,
  ValueChanged<String>? onError,
  int? timeout,
}) async {

  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () async {
            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }
          });
    }


  }
  // on Exception : this does not work on web
  catch (error) {

    if (onError == null){
      blog('$invoker : tryAndCatch ERROR : $error');
    }

    else {
      onError(error.toString());
    }

    // throw(error);
  }

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<bool> tryCatchAndReturnBool({
  required Future<void> Function() functions,
  ValueChanged<String>? onError,
  int? timeout,
  String invoker = 'tryCatchAndReturnBool',
}) async {
  /// IF FUNCTIONS SUCCEED RETURN TRUE, IF ERROR CAUGHT RETURNS FALSE
  bool _success = false;

  /// TRY FUNCTIONS
  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
      _success = true;
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () {
            _success = false;
            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }
          });
    }

  }

  /// CATCH EXCEPTION ERROR
  // on Exception : this does not work on web
  catch (error) {

    blog('$invoker : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    _success = false;
  }

  return _success;
}
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
void blogFlutterErrorDetails(FlutterErrorDetails? details){

  if (details != null){

    blog('details.exception.toString() :  ${details.exception}');
    blog('details.stack.toString() :      ${details.stack}');
    blog('details.library :               ${details.library}');
    blog('details.context.name :          ${details.context?.name}');
    blog('details.context.style :         ${details.context?.style}');
    blog('details.context.showName :      ${details.context?.showName}');
    blog('details.context.showSeparator : ${details.context?.showSeparator}');
    blog('details.context.linePrefix :    ${details.context?.linePrefix}');
    blog('details.stackFilter :           ${details.stackFilter}');
    blog('details.informationCollector :  ${details.informationCollector}');
    blog('details.silent :                ${details.silent}');

  }

}
// -----------------------------------------------------------------------------
