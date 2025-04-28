part of av;

abstract class AvMaker {
  // --------------------------------------------------------------------------
  static DirectoryType avDirectory = DirectoryType.app;
  // --------------------------------------------------------------------------

  /// FROM BYTES

  // --------------------
  ///
  static Future<AvModel?> fromBytes({
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
        directoryType: avDirectory,
        // mimeType: _mime,
        // includeFileExtension: false,
      );

      if (_xFile != null){

        _output = AvModel(
          id: id,
          xFile: _xFile,
          ownersIDs: ownersIDs,
          uploadPath: uploadPath,
          caption: caption,
          name: name,
          origin: origin,
          originalURL: originalURL,
        );

        if (skipMeta == false){

          final int _sideB = bytes.length;
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

          _output = _output.copyWith(
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

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FROM ASSET ENTITY

  // --------------------
  ///
  static Future<AvModel?> fromAssetEntity() async {
    return null;
  }
  // --------------------------------------------------------------------------

  /// FROM URL

  // --------------------
  ///
  static Future<AvModel?> fromURL() async {
    return null;
  }
  // --------------------------------------------------------------------------

  /// FROM BYTES

  // --------------------
  void x(){}
}
