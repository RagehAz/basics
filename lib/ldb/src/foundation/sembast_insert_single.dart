// ignore_for_file: avoid_redundant_argument_values

part of ldb;

class SembastInsertSingle {
  // -----------------------------------------------------------------------------

  const SembastInsertSingle();

  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insert({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
    required bool allowDuplicateIDs,
  }) async {

    if (allowDuplicateIDs == true) {
      return _insertAllowingDuplicateIDs(
        docName: docName,
        map: map,
        primaryKey: primaryKey,
        report: true,
      );
    }

    else {
      return _insertWithoutAllowingDuplicateIDs(
        docName: docName,
        map: map,
        primaryKey: primaryKey,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _insertAllowingDuplicateIDs({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
    required bool report,
  }) async {
    bool _success = false;

    if (map != null && docName != null && primaryKey != null){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await tryAndCatch(
          invoker: 'Sembast._addMap',
          timeout: SembastInfo.theTimeOutS,
          functions: () async {

            /// NOTE : this ignores if there is an existing map with same ID
            await _dbModel.doc.add(_dbModel.database, map);
            _success = true;

          },
        );

      }

    }

    if (report){
      SembastInfo.report(
          invoker: 'insertAllowingDuplicateIDs',
          success: _success,
          docName: docName,
          key: map?[primaryKey] ?? 'id',
      );
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _insertWithoutAllowingDuplicateIDs({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (map != null && docName != null && primaryKey != null){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        final int? _val = await SembastSearch.findRecordKey(
            docName: docName,
            primaryKey: primaryKey,
            id: map[primaryKey]
        );

        /// ADD NEW MAP
        if (_val == null){
          _success = await _insertAllowingDuplicateIDs(
            docName: docName,
            map: map,
            primaryKey: primaryKey,
            report: false,
          );
        }

        /// UPDATE EXISTING MAP
        else {
          final RecordRef<int, Map<String, dynamic>> _snap = _dbModel.doc.record(_val);
          final Map<String, dynamic>? _maw = await _snap.update(_dbModel.database, map);
          _success = _maw != null;
        }

      }

    }

    SembastInfo.report(
      invoker: '_insertWithoutAllowingDuplicateIDs',
      success: _success,
      docName: docName,
      key: map?[primaryKey??'id'],
    );

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  // static Future<bool> _addMap({
  //   required Map<String, dynamic>? map,
  //   required String? docName,
  // }) async {
  //   bool _success = false;
  //
  //   if (map != null && docName != null){
  //
  //     final DBModel? _dbModel = await SembastInit.getDBModel(docName);
  //
  //     if (_dbModel != null){
  //
  //       await tryAndCatch(
  //         invoker: 'Sembast._addMap',
  //         functions: () async {
  //
  //           /// NOTE : this ignores if there is an existing map with same ID
  //           await _dbModel.doc.add(_dbModel.database, map);
  //           _success = true;
  //
  //         },
  //       );
  //
  //     }
  //     // blog('SEMBAST : _addMap : added to ($docName) : map has (${map.keys.length}) : _db : $_db');
  //
  //   }
  //
  //   return _success;
  // }
  // --------------------
  // /// TESTED : WORKS PERFECT
  // static Future<bool> _updateExistingMap({
  //   required Map<String, dynamic>? map,
  //   required String? docName,
  //   required String? primaryKey,
  // }) async {
  //   bool _success = false;
  //
  //   if (map != null && docName != null && primaryKey != null){
  //
  //     final DBModel? _dbModel = await SembastInit.getDBModel(docName);
  //
  //     if (_dbModel != null){
  //
  //       await tryAndCatch(
  //         invoker: 'Sembast._updateExistingMap',
  //         functions: () async {
  //
  //           final String? _objectID = map[primaryKey] as String;
  //
  //           // final int _result =
  //           await _dbModel.doc.update(
  //             _dbModel.database,
  //             map,
  //             finder: Finder(
  //               filter: Filter.equals(primaryKey, _objectID),
  //             ),
  //           );
  //
  //           _success = true;
  //
  //         },
  //       );
  //
  //     }
  //
  //   }
  //   // blog('SEMBAST : _updateExistingMap : updated in ( $docName ) : result : $_result : map has ${map?.keys?.length} keys');
  //
  //   return _success;
  // }
  // -----------------------------------------------------------------------------
}
