part of ldb;
/// => TAMAM
class SembastInsert {
  // -----------------------------------------------------------------------------

  const SembastInsert();

  // -----------------------------------------------------------------------------

  /// INSERT SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insert({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {
    bool _success = false;

    /// Note : either updates all existing maps with this primary key "ID"
    /// or inserts new map

    if (
        map != null &&
        docName != null &&
        primaryKey != null &&
        map[primaryKey] != null
    ){

      // print('SEMBAST : insert : docName : $docName : primaryKey : $primaryKey : allowDuplicateIDs : $allowDuplicateIDs');

      if (allowDuplicateIDs == true){
        _success = await _addMap(
          docName: docName,
          map: map,
        );
      }

      else {

        final bool _exists = await SembastCheck.checkMapExists(
          docName: docName,
          id: map[primaryKey],
          primaryKey: primaryKey,
        );

        /// ADD IF NOT FOUND
        if (_exists == false){
          _success = await _addMap(
            docName: docName,
            map: map,
          );
        }

        /// UPDATE IF FOUND
        else {
          _success = await _updateExistingMap(
            docName: docName,
            map: map,
            primaryKey: primaryKey,
          );
        }

      }

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _addMap({
    required Map<String, dynamic>? map,
    required String? docName,
  }) async {
    bool _success = false;

    if (map != null && docName != null){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await tryAndCatch(
          invoker: 'Sembast._addMap',
          functions: () async {

            /// NOTE : this ignores if there is an existing map with same ID
            await _dbModel.doc.add(_dbModel.database, map);
            _success = true;

            },
        );

      }
      // blog('SEMBAST : _addMap : added to ($docName) : map has (${map.keys.length}) : _db : $_db');

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _updateExistingMap({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (map != null && docName != null && primaryKey != null){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await tryAndCatch(
          invoker: 'Sembast._updateExistingMap',
          functions: () async {

            final String? _objectID = map[primaryKey] as String;

            // final int _result =
            await _dbModel.doc.update(
              _dbModel.database,
              map,
              finder: Finder(
                filter: Filter.equals(primaryKey, _objectID),
              ),
            );

            _success = true;

          },
        );

      }

    }
    // blog('SEMBAST : _updateExistingMap : updated in ( $docName ) : result : $_result : map has ${map?.keys?.length} keys');

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// INSERT MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAll({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    if (
        Lister.checkCanLoop(maps) == true &&
        docName != null &&
        primaryKey != null
    ) {

      if (allowDuplicateIDs == true){
        await _addMaps(
          docName: docName,
          maps: maps!,
        );
      }

      else {

        /// old slow solution
        // final List<Map<String, dynamic>> _existingMaps = await readAll(
        //   docName: docName,
        // );
        //
        // final List<Map<String, dynamic>> _cleanedMaps = Mapper.cleanMapsOfDuplicateIDs(
        //   /// do not change this order of maps to overwrite the new values
        //   maps: [...maps!,..._existingMaps,],
        //   idFieldName: primaryKey,
        // );
        //
        // await _deleteAllThenAddAll(
        //     maps: _cleanedMaps,
        //     docName: docName
        // );

        /// new fast solution
        await _updateMaps(
          primaryKey: primaryKey,
          docName: docName,
          maps: maps!,
        );

      }

      // blog('SEMBAST : insertAll : inserted ${maps.length} maps into ( $docName ) ');

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMaps({
    required List<Map<String, dynamic>> maps,
    required String? docName,
  }) async {
    /// NOTE : this allows duplicate IDs

    if (Lister.checkCanLoop(maps) == true && docName != null) {

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){
        await _dbModel.doc.addAll(_dbModel.database, maps);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

        return insert(
          map: _map,
          docName: docName,
          primaryKey: primaryKey,
          // allowDuplicateIDs: false,
        );

      }),

    ]);

  }
  // -----------------------------------------------------------------------------

  /// INSERT ON CLEAN SLATE

  // --------------------
  /// TESTED : WORKS PERFECT ( SLOW MOTHER FUCKER )
  static Future<void> insertAllOnCleanSlate({
    required List<Map<String, dynamic>> maps,
    required String? docName,
  }) async {

    if (
        Lister.checkCanLoop(maps) == true &&
        docName != null
    ){

      await SembastDelete.deleteAllAtOnce(
        docName: docName,
      );

      await SembastInsert._addMaps(
        maps: maps,
        docName: docName,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
