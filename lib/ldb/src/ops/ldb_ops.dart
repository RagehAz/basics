part of ldb;
/// => TAMAM
/// Storage-agnostic key-value document API -- every method here is scoped
/// purely by `docName` + `primaryKey`, with no sembast- or ObjectBox-
/// specific concept leaking through. That's what made it possible to swap
/// the entire backing store from sembast to ObjectBox (see LdbBobOps in
/// basics/lib/ldbob/src/models/ldb_bob.dart) without touching any of this
/// class's 30+ callers across the app.
abstract class LDBOps {
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMap({
    required Map<String, dynamic>? input,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) => LdbBobOps.insert(
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
  }) => LdbBobOps.insertMany(
    maps: inputs,
    docName: docName,
    primaryKey: primaryKey,
    allowDuplicateIDs: allowDuplicateIDs,
  );
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) => LdbBobOps.readField(
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
  }) => LdbBobOps.readMap(
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
  }) => LdbBobOps.readMaps(
    primaryKey: primaryKey,
    ids: ids,
    docName: docName,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllMaps({
    required String? docName,
  }) => LdbBobOps.readAll(
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
  }) => LdbBobOps.deleteMap(
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
  }) => LdbBobOps.deleteMaps(
    docName: docName,
    primaryKey: primaryKey,
    ids: ids,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAllMapsAtOnce({
    required String? docName,
  }) => LdbBobOps.deleteAllAtOnce(
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
  }) => LdbBobOps.checkMapExists(
    docName: docName,
    id: id,
    primaryKey: primaryKey,
  );
  // -----------------------------------------------------------------------------
}
