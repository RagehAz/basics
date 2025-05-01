part of av;

abstract class AvFromBytes {
  // -----------------------------------------------------------------------------

  /// CREATE FROM BYTES + INSERT IN DIRECTORY + CACHE META DATA

  // --------------------
  ///
  static Future<AvModel?> create({
    required Uint8List? bytes,
    required String uploadPath,
    required bool skipMeta,
    required String bobDocName,
    List<String>? ownersIDs,
    String? caption,
    String? originalURL,
    AvOrigin? origin,
    bool includeFileExtension = false,
    int? durationMs,
  }) async {
    AvModel? _output;

    if (TextCheck.isEmpty(uploadPath) == false && bytes != null){

      final Map<String, String?> _adjustedPaths = await AvPathing.adjustPathAndName(
        includeFileExtension: includeFileExtension,
        bytes: bytes,
        uploadPath: uploadPath,
      );

      final String? _fileName = _adjustedPaths['fileName'];
      final String? _uploadPath = _adjustedPaths['uploadPath'];
      final String? _id = _adjustedPaths['id'];

      if (_id != null){

        final XFile? _xFile = await XFiler.createFromBytes(
          bytes: bytes,
          fileName: _fileName,
          directoryType: AvBobOps.avDirectory,
          // mimeType: _mime,
          // includeFileExtension: false,
        );

        if (_xFile != null){

          final int _sideB = bytes.length;
          final double? _mega = FileSizer.calculateSize(_sideB, FileSizeUnit.megaByte);

          AvModel _avModel = AvModel(
            id: _id,
            xFile: _xFile,
            ownersIDs: ownersIDs,
            uploadPath: _uploadPath,
            caption: caption,
            name: _fileName,
            origin: origin,
            originalURL: originalURL,
            sizeB: _sideB,
            sizeMB: _mega,
            durationMs: durationMs,
          );

          if (skipMeta == false){

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
              // name: _fileName,
              // sizeMB: _mega,
              // sizeB: _sideB,
              fileExt: _fileType,
              // origin: origin,
              // ownersIDs: ownersIDs,
              // uploadPath: _uploadPath,
              // caption: caption,
              // originalURL: originalURL,
              // data: ,

              // durationMs: ,

              // deviceID: await DeviceChecker.getDeviceID(),
              // deviceName: await DeviceChecker.getDeviceName(),
              // platform': kIsWeb == true ? 'web' : Platform.operatingSystem,
            );

          }

          final bool _success = await AvBobOps.insert(
            model: _avModel,
            docName: bobDocName,
          );

          if (_success == true){
            _output = _avModel;
          }

          else {
            await XFiler.deleteFile(_xFile);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
