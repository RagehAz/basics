part of ldb;
/// => TAMAM
class SembastRead {
  // -----------------------------------------------------------------------------

  const SembastRead();

  // -----------------------------------------------------------------------------

  /// READ SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>? > readMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    Map<String, dynamic>? _output;

    if (docName != null && id != null && primaryKey != null){

      _output = await SembastSearch.searchFirst(
          docName: docName,
          invoker: 'readMap',
          finder: Finder(
            filter: Filter.equals(primaryKey, id),
          ),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) async {
    dynamic _output;

    if (docName != null && id != null && primaryKey != null && fieldName != null) {
      final Map<String, dynamic>? map = await readMap(
        docName: docName,
        id: id,
        primaryKey: primaryKey,
      );

      _output = map?[fieldName];
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map <String, dynamic>>> readMaps({
    required String? docName,
    required List<String>? ids,
    required String? primaryKey,
  }) async {

    List<Map<String, dynamic>> _output = [];

    if (
        docName != null &&
        Lister.checkCanLoop(ids) == true &&
        primaryKey != null
    ){

      _output = await SembastSearch.searchMaps(
          docName: docName,
          finder: Finder(
            filter: Filter.inList(primaryKey, ids!),
          ),
      );

      // blog('Sembast : readMaps : $docName : $primaryKeyName : ${_output.length} maps');

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAll({
    required String? docName,
  }) async {

    return SembastSearch.searchMaps(
      docName: docName,
      finder: null,
    );

  }
  // -----------------------------------------------------------------------------
}
