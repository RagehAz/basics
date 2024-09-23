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

    SembastInfo.report(
      invoker: 'searchMaps',
      success: _output.isNotEmpty,
      docName: docName,
      key: finder.toString(),
    );

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

      // blog('($invoker) : searchFirst: _snap : $_snap');

      _output = _snap?.value;

    }

    SembastInfo.report(
      invoker: 'searchFirst',
      success: _output != null,
      docName: docName,
      key: finder.toString(),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RECORD KEY FINDER

  // --------------------
  ///
  static Future<int?> findRecordKey({
    required String? docName,
    required String primaryKey,
    required String id,
    DBModel? dbModel,
  }) async {
    int? _output;

    if (docName != null){

      final DBModel? _dbModel = dbModel ?? await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        _output = await _dbModel.doc.findKey(
          _dbModel.database,
          finder: Finder(
            filter: Filter.equals(primaryKey, id,
              anyInList: false,
            ),
          ),
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
