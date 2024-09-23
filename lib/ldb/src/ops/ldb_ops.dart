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
  }) => SembastInsertSingle.insert(
    map: input,
    docName: docName,
    primaryKey: primaryKey,
    allowDuplicateIDs: allowDuplicateIDs,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMaps({
    required List<Map<String, dynamic>>? inputs,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) => SembastInsertMultiple.insertAll(
    maps: inputs,
    docName: docName,
    primaryKey: primaryKey,
    allowDuplicateIDs: allowDuplicateIDs,
  );
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) => SembastRead.readField(
    docName: docName,
    id: id,
    primaryKey: primaryKey,
    fieldName: fieldName,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) => SembastRead.readMap(
    docName: docName,
    id: id,
    primaryKey: primaryKey,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) => SembastRead.readMaps(
    primaryKey: primaryKey,
    ids: ids,
    docName: docName,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllMaps({
    required String? docName,
  }) => SembastRead.readAll(
    docName: docName,
  );
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMap({
    required String? objectID,
    required String? docName,
    required String? primaryKey,
  }) => SembastDelete.deleteMap(
    docName: docName,
    id: objectID,
    primaryKey: primaryKey,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMaps ({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) => SembastDelete.deleteMaps(
    docName: docName,
    primaryKey: primaryKey,
    ids: ids,
  );
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
  }) => SembastDelete.deleteAllAtOnce(
      docName: docName
  );
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? id,
    required String? docName,
    required String? primaryKey,
  }) => SembastCheck.checkMapExists(
    docName: docName,
    id: id,
    primaryKey: primaryKey,
  );
  // -----------------------------------------------------------------------------
}
