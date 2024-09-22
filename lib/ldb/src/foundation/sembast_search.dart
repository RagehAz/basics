part of ldb;
/// => TAMAM
class SembastSearch {
  // -----------------------------------------------------------------------------

  const SembastSearch();

  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchMaps({
    required String? docName,
    required Finder? finder,
  }) async {
    List<Map<String, dynamic>> _output = [];

    final DBModel? _dbModel = await SembastInit.getDBModel(docName);

    if (_dbModel != null){

      final List<DBSnap> _snaps = await _dbModel.doc.find(
        _dbModel.database,
        finder: finder,
      );

      _output = LDBMapper.getMapsFromSnapshots(
        snaps: _snaps,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> searchFirst({
    required String? docName,
    required Finder finder,
    required String invoker,
  }) async {
    Map<String, dynamic>? _output;

    final DBModel? _dbModel = await SembastInit.getDBModel(docName);

    if (_dbModel != null){

      final DBSnap? _snap = await _dbModel.doc.findFirst(
        _dbModel.database,
        finder: finder,
      );

      blog('($invoker) : searchFirst: _snap : $_snap');

      _output = _snap?.value;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
