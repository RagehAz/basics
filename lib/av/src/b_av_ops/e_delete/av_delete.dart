part of av;
/// => GREAT
class _AvDelete {
  // --------------------------------------------------------------------------

  /// TITLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteSingle({
    required String? uploadPath,
    required String? docName,
  }) async {
    bool _deleted = false;

    if (docName != null && uploadPath != null){

      final bool _bobDeleted = await AvBobOps.delete(
          modelID: AvPathing.createID(uploadPath: uploadPath),
          docName: docName,
      );

      if (_bobDeleted == true){

        final String? _filePath = await AvPathing.createXFilePath(
          uploadPath: uploadPath,
        );

        if (_filePath != null){
          _deleted = await XFiler.deleteFile(XFile(_filePath), 'deleteSingle');
        }

      }

    }

    return _deleted;
  }
  // --------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMany({
    required List<String> uploadPaths,
    required String docName,
  }) async {
    bool _allDeleted = false;

    await Lister.loop(
      models: uploadPaths,
      onLoop: (int index, String? uploadPath) async {

        final bool _deleted = await deleteSingle(
          uploadPath: uploadPath,
          docName: docName,
        );

        if (_allDeleted == true && _deleted == false){
          _allDeleted = false;
        }
        else {
          _allDeleted = true;
        }

      },
    );

    return _allDeleted;
  }
  // --------------------------------------------------------------------------

  /// ALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAll({
    required String docName,
  }) async {

    final List<AvModel> _avs = await AvBobOps.readAll(docName: docName);

    int _count = 0;

    await Lister.loop(
        models: _avs,
        onLoop: (int index, AvModel? avModel) async {

          await Future.wait(<Future>[

            if (avModel?.xFilePath != null)
            XFiler.deleteFile(XFile(avModel!.xFilePath!), 'deleteAll'),

            AvBobOps.delete(modelID: avModel?.id, docName: docName),

          ]);

          _count++;

        },
    );


    return _avs.length == _count;
  }
  // --------------------------------------------------------------------------
}
