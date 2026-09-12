part of ldb;
/// => TAMAM
abstract class SembastInfo {
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int?> getStoreItemsCount(String? docName) async {
    int? _output;

    if (docName != null){

      final DBModel? _ldbModel = await SembastInit.getDBModel(docName);

      /// StoreRef.count() instead of stringifying the whole database
      /// (toJson of every store) and text-mangling the docName's count back
      /// out of it.
      if (_ldbModel != null){
        _output = await _ldbModel.doc.count(_ldbModel.database);
      }

    }


    return _output;
  }
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
      blog('LDB($invoker).docName($docName).key($key).success($success)');
    }
  }
  // -----------------------------------------------------------------------------
}
