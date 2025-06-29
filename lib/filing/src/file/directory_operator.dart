part of filing;
/// => TAMAM
class DirectoryOperator {
  // -----------------------------------------------------------------------------

  /// CLASS SINGLETON

  // --------------------
  DirectoryOperator.singleton();
  static final DirectoryOperator _singleton = DirectoryOperator.singleton();
  static DirectoryOperator get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// DATABASE SINGLETON

  // --------------------
  List<String>? _paths;
  Future<List<String>> get paths async =>  _paths ??= await _readAllPaths();
  static Future<List<String>> getPaths() => DirectoryOperator.instance.paths;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<String>> _readAllPaths() async {
    return Director.readDirectoryFilesPaths(
      type: DirectoryType.app,
    );
  }
  // -----------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void setThePaths(List<String> newPaths){
    _paths = newPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void setPaths({
    required List<String> newPaths,
  }){
    DirectoryOperator.instance.setThePaths(newPaths);
  }
  // -----------------------------------------------------------------------------

  /// EDITORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addPath({
    required String? xFilePath,
  }) async {
    if (xFilePath != null){

      final List<String> _allPaths = await getPaths();

      final bool _exists = Stringer.checkStringsContainString(
          strings: _allPaths,
          string: xFilePath,
      );

      if (_exists == false){

        setPaths(
          newPaths: [..._allPaths, xFilePath],
        );

      }

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removePath({
    required String? xFilePath,
  }) async {
    if (xFilePath != null){

      List<String> _allPaths = await getPaths();

      _allPaths = Stringer.removeStringFromStrings(
        removeFrom: _allPaths,
        removeThis: xFilePath,
      );

      setPaths(
        newPaths: _allPaths,
      );

    }
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists({
    required String? xFilePath,
  }) async {

    if (xFilePath == null){
      return false;
    }
    else {
      final List<String> _allPaths = await getPaths();
      final List<String> _matches = TextCheck.getStringsContainingThis(
        strings: _allPaths,
        subString: xFilePath,
      );
      return _matches.isNotEmpty;
    }

  }
  // -----------------------------------------------------------------------------
}
