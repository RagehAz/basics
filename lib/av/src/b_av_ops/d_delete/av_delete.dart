part of av;

class _AvDelete {
  // --------------------------------------------------------------------------

  /// TITLE

  // --------------------
  ///
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
          _deleted = await XFiler.deleteFile(XFile(_filePath));
        }

      }

    }

    return _deleted;
  }
  // --------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  ///
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
  ///
  static Future<bool> deleteAll({
    required String docName,
  }) async {

    /// FILES
    /// HOW_CAN_WE_DELETE_ALL_FILES_HERE

    /// BOB
    await AvBobOps.deleteAll(
      docName: docName,
    );

    return false;
  }
  // --------------------------------------------------------------------------
  void x(){}
}
