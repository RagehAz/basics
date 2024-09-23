part of ldb;
/// => TAMAM
class SembastInsertMultiple {
  // -----------------------------------------------------------------------------

  const SembastInsertMultiple();

  // -----------------------------------------------------------------------------

  /// INSERT MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAll({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
    required bool allowDuplicateIDs,
  }) async {

    if (allowDuplicateIDs == true){
      await _SembastInsertionAllowingDuplicateID().insert(
          maps: maps,
          docName: docName,
      );
    }
    else {
      await _SembastInsertionPreventingDuplicateID().insert(
          maps: maps,
          docName: docName,
          primaryKey: primaryKey,
      );
    }

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
  static Future<void> insertAllOnCleanSlate({
    required List<Map<String, dynamic>> maps,
    required String? docName,
    required String? primaryKey,
  }) async {

    if (
        Lister.checkCanLoop(maps) == true &&
        docName != null &&
        primaryKey != null
    ){

      await SembastDelete.deleteAllAtOnce(
        docName: docName,
      );

      await SembastInsertMultiple.insertAll(
        maps: maps,
        docName: docName,
        primaryKey: primaryKey,
        allowDuplicateIDs: false,
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _SembastInsertionPreventingDuplicateID {
  // --------------------
  List<Map<String, dynamic>> _allMaps = [];
  String? _docName;
  String? _primaryKey;
  DBModel? _dbModel;
  // --------------------
  final Map<int, Map<String, dynamic>> _found = {};
  final Map<String, Map<String, dynamic>> _notFound = {};
  // --------------------
  ///
  Future<void> insert({
    required List<Map <String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
  }) async {

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
        _docName = docName!;
        _primaryKey = primaryKey;

        await _filterEachMapByExistence();

        await Future.wait(<Future>[

          _insertTheNotFound(),

          _overrideTheFound(),

        ]);

      }

    }


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
  Future<void> _filterEachMapByExistence() async {

    await Future.wait(<Future>[

      ...List.generate(_allMaps.length, (int index){

        return awaiter(
          wait: true,
          function: () async {

            final Map<String, dynamic> map = _allMaps[index];

            final int? _recordNumber = await SembastSearch.findRecordKey(
                docName: _docName,
                primaryKey: _primaryKey!,
                id: map[_primaryKey]
            );

            /// NOT FOUND
            if (_recordNumber == null){
              _addMapToTheNotFound(map);
            }

            /// FOUND
            else {
              _addMapToTheFounds(_recordNumber, map);
            }

          },
        );

      }),

    ]);

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
  Future<void> _insertTheNotFound() async {


    final List<Map<String, dynamic>> maps = Mapper.getMapsFromDynamics(
      dynamics: _notFound.values.toList(),
    );

    if (Lister.checkCanLoop(maps) == true) {
      await tryAndCatch(
        invoker: '_insertTheNotFound',
        functions: () async {
          await _dbModel!.doc.addAll(_dbModel!.database, maps);
          },
      );
    }

  }
  // --------------------
  ///
  Future<void> _overrideTheFound() async {

    final List<int> _recordsNumbers = _found.keys.toList();

    if (Lister.checkCanLoop(_recordsNumbers) == true){

      final RecordsRef<int, Map<String, dynamic>> _records = _dbModel!.doc.records(_recordsNumbers);
      final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(
        dynamics: _found.values.toList(),
      );

      await tryAndCatch(
        invoker: '_overrideTheFound',
        functions: () async {
          await _records.update(_dbModel!.database, _maps);
        },
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _SembastInsertionAllowingDuplicateID {

  Future<void> insert({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
  }) async {

    if (Lister.checkCanLoop(maps) == true && docName != null) {

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){
        await tryAndCatch(
          invoker: '_SembastInsertionAllowingDuplicateID',
          functions: () async {
            await _dbModel.doc.addAll(_dbModel.database, maps!);
            },
        );
      }

    }

  }

}
