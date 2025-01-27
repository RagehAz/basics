
/// => AI TESTED
abstract class Booler {
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// AI TESTED
  static int cipherBool({
    required bool? bool,
  }) {
    /// true => 1; false => 0 else => null => return false instead of null
    switch (bool) {
      case true: return 1;
      case false: return 0;
      default: return 0;
    }
  }
  // --------------------
  /// AI TESTED
  static bool decipherBool(int? int) {
    /// 1 => true; 0 => false else => null (returning false instead of null)
    switch (int) {
      case 1: return true;
      case 0: return false;
      default: return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool boolIsTrue(dynamic value){
    bool _output = false;

    if (value != null && value is bool){
      _output = value;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
