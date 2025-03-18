part of ldb;
/// => TAMAM
abstract class SembastRead {
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

      final Finder _finder = Finder(
        filter: Filter.equals(primaryKey, id),
      );

      _output = await SembastSearch.searchFirst(
          docName: docName,
          invoker: 'readMap',
          finder: _finder,
      );

    }

    SembastInfo.report(
      invoker: 'readMap',
      success: _output != null,
      docName: docName,
      key: id,
    );

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

    SembastInfo.report(
      invoker: 'readField',
      success: _output != null,
      docName: docName,
      key: id,
    );

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

      final Finder _finder = Finder(
        filter: Filter.inList(primaryKey, ids!),
      );

      _output = await SembastSearch.searchMaps(
          docName: docName,
          finder: _finder,
      );

    }

    // SembastInfo.report(
    //   invoker: 'readMaps',
    //   success: _output.isNotEmpty,
    //   docName: docName,
    //   key: ids.toString(),
    // );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAll({
    required String? docName,
  }) async {

    final List<Map<String, dynamic>> _output = await SembastSearch.searchMaps(
      docName: docName,
      finder: null,
    );

    // SembastInfo.report(
    //   invoker: 'readMaps',
    //   success: _output.isNotEmpty,
    //   docName: docName,
    //   key: '...',
    // );

    return _output;

  }
  // -----------------------------------------------------------------------------
}
