part of av;
/// => GREAT
class _AvRead {
  // --------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> readSingle({
    required String? uploadPath,
    required bool skipMeta,
    required String docName,
  }) async {
    AvModel? _output;

    if (uploadPath != null){

      final bool _exists = await _AvRead.checkExists(
        uploadPath: uploadPath,
      );

      final String _id = AvPathing.createID(uploadPath: uploadPath)!;

      if (_exists == true){

        _output = await AvBobOps.findByModelID(
            modelID: _id,
            docName: docName
        );

      }

      else {
        await AvBobOps.delete(modelID: _id, docName: docName);
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> readMany({
    required List<String> uploadPaths,
    required String docName,
    required bool skipMeta,
    Function(AvModel avModel)? onRead,
  }) async {
    final List<AvModel> _output = [];

    await Lister.loop(
      models: uploadPaths,
      onLoop: (int index, String? uploadPath) async {

        final AvModel? _avModel = await readSingle(
          uploadPath: uploadPath,
          skipMeta: skipMeta,
          docName: docName,
        );

        if (_avModel != null){
          onRead?.call(_avModel);
          _output.add(_avModel);
        }

        },
    );

    return _output;
  }
  // --------------------------------------------------------------------------

  /// CHECK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists({
    required String? uploadPath,
  }) async {

    return DirectoryOperator.checkExists(
        xFilePath: AvPathing.createID(uploadPath: uploadPath),
    );

  }
  // --------------------------------------------------------------------------
}
