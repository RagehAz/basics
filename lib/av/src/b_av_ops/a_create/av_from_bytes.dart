part of av;
/// => GREAT
abstract class _AvFromBytes {
  // -----------------------------------------------------------------------------

  /// CREATE FROM BYTES + INSERT IN DIRECTORY + CACHE META DATA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createSingle({
    required Uint8List? bytes,
    required CreateSingleAVConstructor data,
  }) async {
    AvModel? _output;

    if (TextCheck.isEmpty(data.uploadPath) == false && bytes != null){

      /// MAIN
      final String _uploadPath = data.uploadPath;
      final String _id = AvPathing.createID(uploadPath: data.uploadPath)!;
      final String _fileNameWithoutExtension = AvPathing.createFileNameWithoutExtension(
          uploadPath: _uploadPath,
      )!;

      /// FILE TYPE : IF WE WILL FORCE FILES TO HAVE EXTENSION
      // final FileExtType? _type = data.fileExt ?? detectExtension(...)

      final XFile? _xFile = await XFiler.createFromBytes(
        bytes: bytes,
        fileName: _fileNameWithoutExtension,
        directoryType: AvBobOps.avDirectory,
        mimeType: FileMiming.getMimeByType(data.fileExt),
        // includeFileExtension: false,
      );

      if (_xFile != null){

        final int _sideB = bytes.length;
        final double? _mega = FileSizer.calculateSize(_sideB, FileSizeUnit.megaByte);

        AvModel? _avModel = AvModel(
          id: _id,
          uploadPath: _uploadPath,
          xFilePath: _xFile.path,
          ownersIDs: data.ownersIDs,
          caption: data.caption,
          nameWithoutExtension: _fileNameWithoutExtension,
          nameWithExtension: AvPathing.createFileNameWithExtension(uploadPath: _uploadPath, type: data.fileExt),
          fileExt: data.fileExt,
          origin: data.origin,
          originalURL: data.originalURL,
          sizeB: _sideB,
          sizeMB: _mega,
          durationMs: data.durationMs,
          bobDocName: data.bobDocName,
          width: data.width,
          height: data.height,
          originalXFilePath: data.originalXFilePath,
          lastEdit: DateTime.now(),
          // data: ,
        );

        if (data.skipMeta == false){

          _avModel = await _AvEdit.completeAv(
            avModel: _avModel,
            bytesIfExisted: bytes,
          );

          _avModel = await _AvEdit._fixHeicAndHeif(
            bytes: bytes,
            avModel: _avModel,
          );

        }

        final bool _success = await AvBobOps.insert(
          model: _avModel,
          docName: data.bobDocName,
        );
        blog('AvBobOps.insert._success($_success)._fileNameWithoutExtension($_fileNameWithoutExtension)._uploadPath($_uploadPath)');

        if (_success == true){
          _output = _avModel;
        }

        else {
          await XFiler.deleteFile(_xFile);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createMany({
    required List<Uint8List> bytesList,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(bytesList) == true){

      await Lister.loop(
        models: bytesList,
        onLoop: (int i, Uint8List? bytes) async {

          if (bytes != null){

            final AvModel? _pic = await createSingle(
              bytes: bytes,
              data: CreateSingleAVConstructor(
                origin: data.origin,
                uploadPath: data.uploadPathGenerator.call(i, null),
                ownersIDs: data.ownersIDs,
                skipMeta: data.skipMeta,
                bobDocName: data.bobDocName,
                caption: data.captionGenerator?.call(i, null),
                // durationMs: ,
                // originalURL: ,
                // originalXFilePath: ,
                // fileExt: ,
                // height: ,
                // width: ,
              ),

            );

            if (_pic != null){
              _output.add(_pic);
            }
          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
