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
  /// canonical storage is a `Set` (a `LinkedHashSet`, so insertion order is
  /// preserved) for O(1) add/remove/contains in [addPath]/[removePath]
  /// below, instead of the O(n) list-copy-and-scan the old `List<String>`
  /// storage needed on every single file create/delete. The public
  /// surface (`getPaths()`/`setPaths()`) still speaks `List<String>`,
  /// converted at the boundary.
  Set<String>? _paths;
  Future<void> _ensureLoaded() async {
    _paths ??= Set<String>.from(await _readAllPaths());
  }
  Future<List<String>> get paths async {
    await _ensureLoaded();
    return _paths!.toList();
  }
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
    _paths = Set<String>.from(newPaths);
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

      final DirectoryOperator _instance = DirectoryOperator.instance;
      await _instance._ensureLoaded();
      _instance._paths!.add(xFilePath);

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removePath({
    required String? xFilePath,
  }) async {
    if (xFilePath != null){

      final DirectoryOperator _instance = DirectoryOperator.instance;
      await _instance._ensureLoaded();
      _instance._paths!.remove(xFilePath);

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
