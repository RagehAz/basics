part of ldb;

/// => TAMAM
class LDBOps {
  // -----------------------------------------------------------------------------

  const LDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMap({
    required Map<String, dynamic>? input,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    final bool _success = await _Sembast.insert(
      map: input,
      docName: docName,
      primaryKey: primaryKey,
      allowDuplicateIDs: allowDuplicateIDs,
    );

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMaps({
    required List<Map<String, dynamic>>? inputs,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    await _Sembast.insertAll(
      maps: inputs,
      docName: docName,
      primaryKey: primaryKey,
      allowDuplicateIDs: allowDuplicateIDs,
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) async {

    final Map<String, dynamic>? map = await readMap(
      docName: docName,
      id: id,
      primaryKey: primaryKey,
    );

    if (map == null){
      return null;
    }
    else {
      return map[fieldName];
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {

    Map<String, dynamic>? _output;

    if (id != null && docName != null && primaryKey != null){

      final List<Map<String, dynamic>> _maps = await readMaps(
        docName: docName,
        ids: <String>[id],
        primaryKey: primaryKey,
      );

      if (Lister.checkCanLoop(_maps) == true){
        _output = _maps[0];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) async {

    final List<Map<String, dynamic>> _maps = await _Sembast.readMaps(
      primaryKeyName: primaryKey,
      ids: ids,
      docName: docName,
    );

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllMaps({
    required String? docName,
  }) async {

    final List<Map<String, dynamic>> _result = await _Sembast.readAll(
      docName: docName,
    );

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMap({
    required String? objectID,
    required String? docName,
    required String? primaryKey,
  }) async {

    await _Sembast.deleteMap(
      docName: docName,
      id: objectID,
      primaryKey: primaryKey,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMaps ({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) async {

    await _Sembast.deleteMaps(
      docName: docName,
      primaryKey: primaryKey,
      ids: ids,
    );

  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsOneByOne({
    required String docName,
  }) async {

    await Sembast.deleteAllOneByOne(
      docName: docName,
    );

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsAtOnce({
    required String? docName,
  }) async {

    await _Sembast.deleteAllAtOnce(docName: docName);

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? id,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _exists = false;

    if (id != null) {
      _exists = await _Sembast.checkMapExists(
        docName: docName,
        id: id,
        primaryKey: primaryKey,
      );
    }

    return _exists;
  }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH - DAILY WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkShouldRefreshLDB({
    int refreshDurationInMinutes = 60,
  }) async {
    bool _shouldRefresh = true;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final List<Map<String, dynamic>> _maps = await readMaps(
      ids: ['theLastWipeMap'],
      docName: 'theLastWipeMap',
      primaryKey: 'id',
    );

    if (Lister.checkCanLoop(_maps) == true){

      final DateTime? _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
      );

      double? _diff = Timers.calculateTimeDifferenceInMinutes(
          from: _lastWipe,
          to: DateTime.now(),
      ).toDouble();

      _diff = Numeric.modulus(_diff);

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff < refreshDurationInMinutes){
        _shouldRefresh = false;
      }
      else {
        _shouldRefresh = true;
      }

    }

    if (_shouldRefresh == true){
      await insertMap(
        // allowDuplicateIDs: false,
        docName: 'theLastWipeMap',
        primaryKey: 'id',
        input: {
          'id': 'theLastWipeMap',
          'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
        },
      );
    }

    return _shouldRefresh;
  }
  // -----------------------------------------------------------------------------
}
