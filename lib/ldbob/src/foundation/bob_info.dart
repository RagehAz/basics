part of bob;
///
abstract class BobInfo {
  // --------------------
  ///
  // static Future<int?> getStoreItemsCount(String? docName) async {
  //   int? _output;
    // if (docName != null){
    //
    //   final DBModel? _ldbModel = await SembastInit.getDBModel(docName);
    //
    //   String? _thing = _ldbModel?.database.toString();
    //
    //   _thing = TextMod.removeTextBeforeFirstSpecialCharacter(text: _thing, specialCharacter: docName);
    //   _thing = TextMod.removeTextAfterFirstSpecialCharacter(text: _thing, specialCharacter: '}');
    //   _thing = TextMod.removeTextBeforeFirstSpecialCharacter(text: _thing, specialCharacter: ':');
    //   _thing = TextMod.removeSpacesFromAString(_thing);
    //
    //   _output = Numeric.transformStringToInt(_thing);
    //
    // }
    //
  //   return _output;
  // }
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
