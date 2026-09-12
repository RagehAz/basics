part of bob;
///
abstract class BobInfo {
  // --------------------
  ///
  static const int? theTimeOutS = null;
  // -----------------------------------------------------------------------------

  /// REPORTING

  // --------------------
  static const bool _canReport = false; // kDebugMode;
  // --------------------
  static void report({
    required String invoker,
    required bool success,
    required String? docName,
    required String? key,
  }){
    if (_canReport == true){
      blog('BOB($invoker).docName($docName).key($key).success($success)');
    }
  }
  // -----------------------------------------------------------------------------
}
