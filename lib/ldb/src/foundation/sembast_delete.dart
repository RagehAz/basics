part of ldb;
/// => TAMAM
class SembastDelete {
  // -----------------------------------------------------------------------------

  const SembastDelete();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMap({
    required String? id,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (id != null && docName != null && primaryKey != null){

      /// NOTE : Deletes all maps with the given primary key,
      /// as LDB allows duplicate maps of same ID "same value of the primary key"

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await tryAndCatch(
          invoker: 'deleteMap',
          functions: () async {

            await _dbModel.doc.delete(
              _dbModel.database,
              finder: Finder(
                filter: Filter.equals(primaryKey, id),
              ),
            );

            _success = true;

          },
        );

        // blog('Sembast : deleteMap : $docName : $primaryKey : $objectID');

      }

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMaps({
    required String? primaryKey,
    required List<String>? ids,
    required String? docName,
  }) async {

    if (
        primaryKey != null &&
        Lister.checkCanLoop(ids) == true &&
        docName != null
    ){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await _dbModel.doc.delete(
          _dbModel.database,
          finder: Finder(
            filter: Filter.inList(primaryKey, ids!),
          ),
        );

        // blog('Sembast : deleteDocs : $docName : $primaryKeyName : $ids');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllAtOnce({
    required String? docName,
  }) async {

    final DBModel? _dbModel = await SembastInit.getDBModel(docName);

    if (_dbModel != null){
      await _dbModel.doc.delete(_dbModel.database);
    }

  }
  // -----------------------------------------------------------------------------
}
