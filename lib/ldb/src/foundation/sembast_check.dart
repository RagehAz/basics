// ignore_for_file: avoid_redundant_argument_values

part of ldb;
/// => TAMAM
class SembastCheck {
  // -----------------------------------------------------------------------------

  const SembastCheck();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    bool _output = false;

    if (docName != null && id != null && primaryKey != null) {

      final DBModel? _dbModel = await SembastInit.getDBModel(docName);

      if (_dbModel != null) {

        await tryAndCatch(
            invoker: 'checkMapExists',
            timeout: SembastInfo.theTimeOutS,
            functions: () async {

              final Finder _finder = Finder(
                filter: Filter.equals(primaryKey, id,
                  anyInList: false,
                ),
              );

              final int? _val = await _dbModel.doc.findKey(
                _dbModel.database,
                finder: _finder,
              );

              _output = _val != null;

            },
        );

      }

    }

    blog('checkMapExists.($docName).($id):$_output');

    return _output;
  }
  // -----------------------------------------------------------------------------
}
