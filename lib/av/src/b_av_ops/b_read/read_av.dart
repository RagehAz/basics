part of av;

class _AvRead {
  // --------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  ///
  static Future<AvModel?> readSingle({
    required String? uploadPath,
    required bool skipMeta,
    required String docName,
  }) async {
    AvModel? _output;

    if (uploadPath != null){

      final String? _fileNameWithoutExtension = AvPathing.createFileNameWithoutExtension(
        uploadPath: uploadPath,
      );

      final String? _xFilePath = await AvPathing.createXFilePath(
        uploadPath: uploadPath,
      );

      final bool _exists = await DirectoryOperator.checkExists(
        xFilePath: _xFilePath,
      );

      if (_exists == true){

        final String _id = AvPathing.createID(uploadPath: uploadPath)!;

        /// NO META
        if (skipMeta == true){
          _output = AvModel(
            id: _id,
            uploadPath: uploadPath,
            xFilePath: _xFilePath,
            bobDocName: docName,
            nameWithoutExtension: _fileNameWithoutExtension,

          );
        }

        /// WITH META
        else {

          _output = await AvBobOps.findByModelID(
              modelID: _id,
              docName: docName
          );

          _output = _output?.copyWith(
            xFilePath: _xFilePath,
          );

        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  ///
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
  ///
  static Future<bool> checkExists({
    required String uploadPath,
  }) async {

    final String? _filePath = await AvPathing.createXFilePath(
      uploadPath: uploadPath,
    );

    return DirectoryOperator.checkExists(
        xFilePath: _filePath,
    );

  }
  // --------------------------------------------------------------------------
  void x(){}
}
