part of ldb;
/// => TAMAM
class SembastInfo {
  // -----------------------------------------------------------------------------

  const SembastInfo();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int?> getStoreItemsCount(String? docName) async {
    int? _output;

    if (docName != null){

      final DBModel? _ldbModel = await SembastInit.getDBModel(docName);

      String? _thing = _ldbModel?.database.toString();

      _thing = TextMod.removeTextBeforeFirstSpecialCharacter(text: _thing, specialCharacter: docName);
      _thing = TextMod.removeTextAfterFirstSpecialCharacter(text: _thing, specialCharacter: '}');
      _thing = TextMod.removeTextBeforeFirstSpecialCharacter(text: _thing, specialCharacter: ':');
      _thing = TextMod.removeSpacesFromAString(_thing);

      _output = Numeric.transformStringToInt(_thing);

    }


    return _output;
  }
  // --------------------
  ///
  static int? theTimeOutS = 1;
  // -----------------------------------------------------------------------------

  /// REPORTING

  // --------------------
  static const bool _canReport = kDebugMode;
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
