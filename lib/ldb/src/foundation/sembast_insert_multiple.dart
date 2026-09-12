// ignore_for_file: avoid_redundant_argument_values

part of ldb;
/// => TAMAM
abstract class SembastInsertMultiple {
  // -----------------------------------------------------------------------------

  /// INSERT MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertAll({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
    required bool allowDuplicateIDs,
  }) async {
    bool _success = false;

    if (allowDuplicateIDs == true){
      _success = await _SembastInsertionAllowingDuplicateID().insert(
          maps: maps,
          docName: docName,
      );
    }

    else {
      _success = await _SembastInsertionPreventingDuplicateID().insert(
          maps: maps,
          docName: docName,
          primaryKey: primaryKey,
      );
    }

    return _success;
  }
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> _updateMaps({
    required List<Map<String, dynamic>> maps,
    required String docName,
    required String primaryKey,
  }) async {

    final List<Map<String, dynamic>> _cleanedMaps = Mapper.cleanMapsOfDuplicateIDs(
      maps: maps,
      idFieldName: primaryKey,
    );

    await Future.wait([

      ...List.generate(_cleanedMaps.length, (index){

        final Map<String, dynamic> _map = _cleanedMaps[index];

        return SembastInsertSingle.insert(
          map: _map,
          docName: docName,
          primaryKey: primaryKey,
          allowDuplicateIDs: false,
        );

      }),

    ]);

  }
   */
  // -----------------------------------------------------------------------------

  /// INSERT ON CLEAN SLATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertAllOnCleanSlate({
    required List<Map<String, dynamic>> maps,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (
        Lister.checkCanLoop(maps) == true &&
        docName != null &&
        primaryKey != null
    ){

      final bool _go = await SembastDelete.deleteAllAtOnce(
        docName: docName,
      );

      if (_go == true){

        _success = await SembastInsertMultiple.insertAll(
          maps: maps,
          docName: docName,
          primaryKey: primaryKey,
          allowDuplicateIDs: false,
        );
      }

    }

    SembastInfo.report(
      invoker: 'insertAllOnCleanSlate',
      success: _success,
      docName: docName,
      key: '${maps.length} maps',
    );

    return _success;
  }
  // -----------------------------------------------------------------------------
}

class _SembastInsertionPreventingDuplicateID {
  // --------------------
  List<Map<String, dynamic>> _allMaps = [];
  String? _primaryKey;
  DBModel? _dbModel;
  // --------------------
  final Map<int, Map<String, dynamic>> _found = {};
  final Map<String, Map<String, dynamic>> _notFound = {};
  // --------------------
  ///
  Future<bool> insert({
    required List<Map <String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _success = false;

    final bool _canRun = _checkCanRun(
      maps: maps,
      docName: docName,
      primaryKey: primaryKey,
    );

    if (_canRun == true){

      _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        _allMaps = Mapper.cleanMapsOfDuplicateIDs(
          maps: maps,
          idFieldName: primaryKey!,
        );
        _primaryKey = primaryKey;

        await _filterEachMapByExistence();

        bool _notFoundSuccess = false;
        bool _foundSuccess = false;

        await Future.wait(<Future>[

          awaiter(
              wait: true,
              function: () async {
                _notFoundSuccess = await _insertTheNotFound();
              },
          ),

          awaiter(
            wait: true,
            function: () async {
              _foundSuccess = await _overrideTheFound();
            },
          ),

        ]);

        _success = _notFoundSuccess && _foundSuccess;

      }

    }

    SembastInfo.report(
      invoker: '_SembastInsertionPreventingDuplicateID',
      success: _success,
      docName: docName,
      key: Mapper.getMapsPrimaryKeysValues(maps: maps).toString(),
    );

    return _success;
  }
  // --------------------
  ///
  bool _checkCanRun({
    required List<Map <String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
  }){

    if (Lister.checkCanLoop(maps) == true && docName != null && primaryKey != null){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  ///
  /// one Filter.inList query for the whole batch instead of one
  /// findRecordKey query per map (each of which ran its own Filter.equals
  /// linear scan against the whole store) -- same fix already applied to
  /// LdbBobOps.insertMany on the ObjectBox side, mirroring the
  /// Filter.inList pattern already used by this file's sibling,
  /// SembastDelete.deleteMaps.
  Future<void> _filterEachMapByExistence() async {

    final List<String> _ids = _allMaps
        .map((Map<String, dynamic> map) => map[_primaryKey].toString())
        .toList();

    List<RecordSnapshot<int, Map<String, dynamic>>> _existingRecords = [];

    await tryAndCatch(
      invoker: '_filterEachMapByExistence',
      timeout: SembastInfo.theTimeOutS,
      functions: () async {
        _existingRecords = await _dbModel!.doc.find(
          _dbModel!.database,
          finder: Finder(filter: Filter.inList(_primaryKey!, _ids)),
        );
      },
    );

    final Map<String, int> _existingKeyByID = {
      for (final RecordSnapshot<int, Map<String, dynamic>> record in _existingRecords)
        record.value[_primaryKey].toString(): record.key,
    };

    for (final Map<String, dynamic> map in _allMaps){

      final int? _recordNumber = _existingKeyByID[map[_primaryKey].toString()];

      /// NOT FOUND
      if (_recordNumber == null){
        _addMapToTheNotFound(map);
      }

      /// FOUND
      else {
        _addMapToTheFounds(_recordNumber, map);
      }

    }

  }
  // --------------------
  ///
  void _addMapToTheFounds(int recordNumber, Map<String, dynamic> map){
    _found[recordNumber] = map;
  }
  // --------------------
  ///
  void _addMapToTheNotFound(Map<String, dynamic> map){
    final String _id = map[_primaryKey];
    _notFound[_id] = map;
  }
  // -----------------------------------------------------------------------------

  /// INSERTION

  // --------------------
  ///
  Future<bool> _insertTheNotFound() async {
    bool _success = false;

    final List<Map<String, dynamic>> maps = Mapper.getMapsFromDynamics(
      dynamics: _notFound.values.toList(),
    );

    if (Lister.checkCanLoop(maps) == true) {
      await tryAndCatch(
        invoker: '_insertTheNotFound',
        timeout: SembastInfo.theTimeOutS,
        functions: () async {
          await _dbModel!.doc.addAll(_dbModel!.database, maps);
          _success = true;
          },
      );
    }
    else {
      _success = true;
    }

    return _success;
  }
  // --------------------
  ///
  Future<bool> _overrideTheFound() async {
    bool _success = false;

    final List<int> _recordsNumbers = _found.keys.toList();

    if (Lister.checkCanLoop(_recordsNumbers) == true){

      final RecordsRef<int, Map<String, dynamic>> _records = _dbModel!.doc.records(_recordsNumbers);
      final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(
        dynamics: _found.values.toList(),
      );

      await tryAndCatch(
        invoker: '_overrideTheFound',
        timeout: SembastInfo.theTimeOutS,
        functions: () async {
          await _records.update(_dbModel!.database, _maps);
          _success = true;
        },
      );

    }
    else {
      _success = true;
    }

    return _success;
  }
  // -----------------------------------------------------------------------------
}

class _SembastInsertionAllowingDuplicateID {

  Future<bool> insert({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
  }) async {
    bool _success = false;

    if (docName != null) {

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        if (Lister.checkCanLoop(maps) == true){
          await tryAndCatch(
            invoker: '_SembastInsertionAllowingDuplicateID',
            timeout: SembastInfo.theTimeOutS,
            functions: () async {
              await _dbModel.doc.addAll(_dbModel.database, maps!);
              _success = true;
            },
          );
        }

        else {
          _success = true;
        }

      }

    }

    SembastInfo.report(
      invoker: '_SembastInsertionAllowingDuplicateID',
      success: _success,
      docName: docName,
      key: Mapper.getMapsPrimaryKeysValues(maps: maps).toString(),
    );

    return _success;
  }

}
