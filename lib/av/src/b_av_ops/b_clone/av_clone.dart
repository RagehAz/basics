part of av;
/// => GREAT
class _AvClone {
  // --------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> cloneAvWithNewName({
    required AvModel? avModel,
    required String? newName,
    required String? bobDocName,
  }) async {
    AvModel? _output;

    if (newName != null && avModel != null){

      final String? _newPath = FilePathing.replaceFileNameInPath(
        oldPath: avModel.uploadPath,
        fileName: newName,
      );

      if (_newPath != null){

        _output = await cloneAv(
          avModel: avModel,
          uploadPath: _newPath,
          bobDocName: bobDocName,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> cloneAv({
    required AvModel? avModel,
    required String? uploadPath,
    required String? bobDocName,
    List<String>? ownersIDs,
  }) async {
    AvModel? _output;

    if (avModel != null && uploadPath != null){

      if (avModel.uploadPath == uploadPath){
        _output = avModel;
      }
      else {
        _output = await AvOps.createFromBytes(
          bytes: await avModel.getBytes(),
          data: CreateSingleAVConstructor(
            uploadPath: uploadPath,
            bobDocName: bobDocName ?? avModel.bobDocName,
            skipMeta: false,
            fileExt: avModel.fileExt,
            caption: avModel.caption,
            durationMs: avModel.durationMs,
            originalURL: avModel.originalURL,
            height: avModel.height,
            width: avModel.width,
            origin: avModel.origin,
            ownersIDs: ownersIDs ?? avModel.ownersIDs,
            originalXFilePath: avModel.originalXFilePath,
          ),
        );
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FILE NAME ADJUSTMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> cloneFileToHaveExtension({
    required AvModel avModel,
  }) async {
    File? _output;

    /// IN SUPER_VIDEO_CONTROLLER FILE MUST HAVE EXTENSION IN FILE NAME INSIDE THE FILE PATH

    await tryAndCatch(
      invoker: 'AvClone.cloneFileToHaveExtension',
      functions: () async {
        final String _unitId = Idifier.createUniqueIDString();
        final String? _cloneUploadPath = FilePathing.replaceFileNameInPath(
          oldPath: avModel.uploadPath,
          fileName: 'clone_${_unitId}_${avModel.nameWithExtension}',
        );
        blog('cloneFileToHaveExtension._cloneUploadPath($_cloneUploadPath)');
        final File? _file = avModel.getFile();
        blog('cloneFileToHaveExtension._file($_file)');
        final String? _cloneXFilePathWithout = await AvPathing.createXFilePath(uploadPath: _cloneUploadPath);
        final String? _ext = FileExtensioning.getExtensionByType(avModel.fileExt);
        final String _cloneXFilePath = '$_cloneXFilePathWithout.$_ext';
        blog('cloneFileToHaveExtension._cloneXFilePath($_cloneXFilePath)');
        if (_cloneXFilePathWithout != null){
          _output = await _file?.copy(_cloneXFilePath);
          blog('cloneFileToHaveExtension._output($_output)');
          await DirectoryOperator.addPath(xFilePath: _cloneXFilePath);
        }
      },
    );

    // blog('cloneFileToHaveExtension._clone(${_clone?.nameWithExtension})');
    blog('cloneFileToHaveExtension._output(${_output?.fileName})');

    return _output;

    // final String? _originalPath = avModel.xFilePath;
    // blog('cloneFileToHaveExtension._originalPath($_originalPath)');
    //
    // if (_originalPath != null){
    //
    //   final String? _fileName = FileNaming.getNameFromPath(path: _originalPath, withExtension: true);
    //   final bool _hasExtension = FileExtensioning.checkNameHasExtension(_fileName);
    //
    //   blog('cloneFileToHaveExtension._fileName($_fileName)');
    //   blog('cloneFileToHaveExtension._hasExtension($_hasExtension)');
    //
    //   if (_hasExtension == true){
    //     _output = File(_originalPath);
    //   }
    //   else {
    //
    //     final Uint8List? _bytes = await avModel.getBytes();
    //
    //
    //     final AvModel? _complete = await AvOps.completeAv(
    //       avModel: avModel,
    //       bytesIfExisted: _bytes,
    //     );
    //
    //     blog('cloneFileToHaveExtension._complete?.nameWithExtension(${_complete?.nameWithExtension})');
    //
    //     _output = await Filer.createFromBytes(
    //       bytes: _bytes,
    //       fileName: _complete?.nameWithExtension,
    //       includeFileExtension: true,
    //     );
    //
    //   }
    //
    // }

    // return _output;
  }
  // --------------------------------------------------------------------------
}
