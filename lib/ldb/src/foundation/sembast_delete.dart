// ignore_for_file: avoid_redundant_argument_values

part of ldb;
/// => TAMAM
abstract class SembastDelete {
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
          timeout: SembastInfo.theTimeOutS,
          functions: () async {

            final Finder _finder = Finder(
              filter: Filter.equals(primaryKey, id),
            );

            await _dbModel.doc.delete(
              _dbModel.database,
              finder: _finder,
            );

            _success = true;

          },
        );

        // blog('Sembast : deleteMap : $docName : $primaryKey : $objectID');

      }

    }

    SembastInfo.report(
      invoker: 'deleteMap',
      success: _success,
      docName: docName,
      key: id,
    );

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMaps({
    required String? primaryKey,
    required List<String>? ids,
    required String? docName,
  }) async {
    bool _success = false;

    if (
        primaryKey != null &&
        Lister.checkCanLoop(ids) == true &&
        docName != null
    ){

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null){

        await tryAndCatch(
            invoker: 'deleteMaps',
          timeout: SembastInfo.theTimeOutS,
            functions: () async {

              final Finder _finder = Finder(
                filter: Filter.inList(primaryKey, ids!),
              );

              await _dbModel.doc.delete(
                _dbModel.database,
                finder: _finder,
              );

              _success = true;

            },
        );

        // blog('Sembast : deleteDocs : $docName : $primaryKeyName : $ids');
      }

    }

    SembastInfo.report(
      invoker: 'deleteMap',
      success: _success,
      docName: docName,
      key: ids.toString(),
    );

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAllAtOnce({
    required String? docName,
  }) async {
    bool _success = false;

    final DBModel? _dbModel = await SembastInit.getDBModel(docName);

    if (_dbModel != null){
      await tryAndCatch(
        invoker: 'deleteAllAtOnce',
        timeout: SembastInfo.theTimeOutS,
        functions: () async {

          await _dbModel.doc.delete(_dbModel.database);
          _success = true;

          },

      );
    }

    SembastInfo.report(
      invoker: 'deleteMap',
      success: _success,
      docName: docName,
      key: '...',
    );

    return _success;
  }
  // -----------------------------------------------------------------------------
}
