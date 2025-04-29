part of av;

abstract class AvFromBytes {
  // -----------------------------------------------------------------------------

  /// CREATE FROM BYTES + INSERT IN DIRECTORY + CACHE META DATA

  // --------------------
  ///
  static Future<AvModel?> create({
    required Uint8List? bytes,
    required String? id,
    required bool skipMeta,
    List<String>? ownersIDs,
    String? uploadPath,
    String? caption,
    String? originalURL,
    MediaOrigin? origin,
    String? name,
  }) async {
    AvModel? _output;

    if (id != null && bytes != null){

      final XFile? _xFile = await XFiler.createFromBytes(
        bytes: bytes,
        fileName: id,
        directoryType: AvMaker.avDirectory,
        // mimeType: _mime,
        // includeFileExtension: false,
      );

      if (_xFile != null){

        final int _sideB = bytes.length;
        AvModel _avModel = AvModel(
          id: id,
          xFile: _xFile,
          ownersIDs: ownersIDs,
          uploadPath: uploadPath,
          caption: caption,
          name: name,
          origin: origin,
          originalURL: originalURL,
          sizeB: _sideB,
        );

        if (skipMeta == false){

          final double? _mega = FileSizer.calculateSize(_sideB, FileSizeUnit.megaByte);
          FileExtType? _fileType;
          Dimensions? _dims;

          await Future.wait(<Future>[

            /// FILE TYPE
            awaiter(
              wait: true,
              function: () async {
                _fileType = await FormatDetector.detectXFile(
                  xFile: _xFile,
                  bytesIfThere: bytes,
                  invoker: 'AvMaker.fromBytes',
                );
              },
            ),

            /// DIMS
            awaiter(
              wait: true,
              function: () async {
                _dims = await DimensionsGetter.fromXFile(
                  xFile: _xFile,
                  bytesIfThere: bytes,
                  invoker: 'AvMaker.fromBytes',
                );
              },
            ),

          ]);

          _avModel = _avModel.copyWith(
            // id: ,
            // xFile: ,
            width: _dims?.width,
            height: _dims?.height,
            name: name,
            sizeMB: _mega,
            sizeB: _sideB,
            fileExt: _fileType,
            origin: origin,
            ownersIDs: ownersIDs,
            uploadPath: uploadPath,
            caption: caption,
            originalURL: originalURL,
            // data: ,
          );

        }

        final bool _success = await AvBobOps.insert(
          avModel: _avModel,
        );

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
}
