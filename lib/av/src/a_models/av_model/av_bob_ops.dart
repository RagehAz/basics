part of av;

abstract class AvBobOps {
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<bool> insert({
    required AvModel? avModel,
  }) async {
    bool _success = false;

    if (avModel != null){
      /// IMPLEMENT_ME
    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<AvModel?> read() async {

    return null;
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<bool> delete() async {
    bool _deleted = false;

    return _deleted;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
