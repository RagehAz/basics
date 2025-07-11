part of av;
/// => GREAT
class _AvUpdate {
  // -----------------------------------------------------------------------------

  /// OVERRIDE BYTES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> overrideBytes({
    required Uint8List? bytes,
    required Dimensions? newDims,
    required AvModel? avModel,
  }) async {
    AvModel? _output = avModel;

    if (avModel != null && bytes != null){

      _output = await _AvFromBytes.createSingle(
        // invoker: 'overrideBytes',
          bytes: bytes,
          data: CreateSingleAVConstructor(
            skipMeta: false,
            uploadPath: avModel.uploadPath,
            bobDocName: avModel.bobDocName,
            originalURL: avModel.originalURL,
            originalXFilePath: avModel.originalXFilePath,
            origin: avModel.origin,
            caption: avModel.caption,
            ownersIDs: avModel.ownersIDs,
            width: newDims?.width,
            height: newDims?.height,
            durationMs: avModel.durationMs,
            // fileExt: may change,
          ),
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PATH UPDATING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> renameFile({
    required AvModel? avModel,
    required String? newName,
  }) async {
    AvModel? _output;

    if (newName != null && avModel != null){

      final String? _newPath = FilePathing.replaceFileNameInPath(
        oldPath: avModel.uploadPath,
        fileName: newName,
      );

      if (_newPath != null){

        _output = await overrideUploadPath(
          avModel: avModel,
          newUploadPath: _newPath,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> overrideUploadPath({
    required AvModel? avModel,
    required String? newUploadPath,
  }) async {
    AvModel? _output;

    if (avModel != null){

      final String _oldPath = avModel.uploadPath;
      final String? _newPath = newUploadPath;

      if (_oldPath == _newPath){
        _output = avModel;
      }
      
      else if (_newPath != null){

        _output = await AvOps.createFromBytes(
          bytes: await avModel.getBytes(),
          data: CreateSingleAVConstructor(
            uploadPath: _newPath,
            bobDocName: avModel.bobDocName,
            skipMeta: false,
            fileExt: avModel.fileExt,
            caption: avModel.caption,
            durationMs: avModel.durationMs,
            originalURL: avModel.originalURL,
            height: avModel.height,
            width: avModel.width,
            origin: avModel.origin,
            ownersIDs: avModel.ownersIDs,
            originalXFilePath: avModel.originalXFilePath,
          ),
        );

        if (_output != null){
          await _AvDelete.deleteSingle(
              uploadPath: _oldPath,
              docName: avModel.bobDocName,
              // invoker: 'overrideUploadPath',
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MOVE TO BOB

  // --------------------
  ///
  static Future<AvModel?> moveToBob({
    required AvModel? avModel,
    required String? bobDocName,
  }) async {
    AvModel? _output = avModel;

    if (avModel != null && bobDocName != null && avModel.bobDocName != bobDocName){

      final bool _newInserted = await AvBobOps.insert(
        model: avModel._copyWith(bobDocName: bobDocName),
        docName: bobDocName,
      );

      if (_newInserted == true){

        final bool _oldIsDeleted = await AvBobOps.delete(
            modelID: avModel.id,
            docName: avModel.bobDocName,
        );

        if (_oldIsDeleted == true){
          _output = avModel._copyWith(
            bobDocName: bobDocName,
          );
        }
        else {
          await AvBobOps.delete(
            modelID: avModel.id,
            docName: bobDocName,
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// LIGHT EDIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> metaEdit({
    required AvModel? avModel,
    String? caption,
    AvOrigin? origin,
    String? originalXFilePath,
    String? originalURL,
    Map<String, String>? data,
    int? durationMs,
    List<String>? ownersIDs,
  }) async {
    AvModel? _output = avModel;

    if (avModel != null){

      if (
          caption != null ||
          origin != null ||
          originalXFilePath != null ||
          originalURL != null ||
          data != null ||
          durationMs != null ||
          ownersIDs != null
      ){

        final AvModel? _new = avModel._copyWith(
          /// PATHS ARE FIXED
          // xFilePath: ,
          // id: ,
          // bobDocName: ,
          // uploadPath: ,
          // nameWithExtension: ,
          // nameWithoutExtension: ,

          /// BYTES ARE FIXED
          // fileExt: ,
          // height: ,
          // width: ,
          // sizeB: ,
          // sizeMB: ,

          lastEdit: DateTime.now(),
          caption: caption,
          origin: origin,
          originalXFilePath: originalXFilePath,
          originalURL: originalURL,
          data: data,
          durationMs: durationMs,
          ownersIDs: ownersIDs,
        );

        if (_new != null){

          final bool _success = await AvBobOps.insert(
            model: _new,
            docName: _new.bobDocName,
          );

          if (_success == true){
            _output = _new;
          }

        }

      }



    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMPLETE META

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> completeAv({
    required AvModel? avModel,
    required Uint8List? bytesIfExisted,
  }) async {
    AvModel? _output = avModel;

    if (avModel != null){

      /// CONSTANTS
      // String id;
      // String uploadPath;
      // String bobDocName;

      /// GIVENS
      // List<String>? ownersIDs;
      // Map<String, String>? data;
      // AvOrigin? origin;
      // String? originalURL;
      // String? caption;
      // int? durationMs;

      /// TO BE CONCLUDED
      // String? xFilePath;
      // double? width;
      // double? height;
      // String? nameWithoutExtension;
      // String? nameWithExtension;
      // double? sizeMB;
      // int? sizeB;
      // FileExtType? fileExt;

      if (
          avModel.xFilePath == null ||
          avModel.width == null ||
          avModel.height == null ||
          avModel.nameWithoutExtension == null ||
          avModel.nameWithExtension == null ||
          avModel.sizeMB == null ||
          avModel.sizeB == null ||
          avModel.fileExt == null
      ){

        /// NAME WITHOUT EXTENSION
        final String? nameWithoutExtension = avModel.nameWithoutExtension ?? AvPathing.createFileNameWithoutExtension(
          uploadPath: avModel.uploadPath,
        );

        /// FILE AND EXTENSION
        String? xFilePath = avModel.xFilePath;
        XFile? _xFile;
        Uint8List? _bytes = bytesIfExisted;
        FileExtType? fileExt = avModel.fileExt;

        /// XFILE AND X FILE PATH
        if (xFilePath == null){
          if (_bytes != null){
            _xFile = await XFiler.createFromBytes(
              invoker: 'completeAv',
              bytes: _bytes,
              fileName: avModel.id,
              includeFileExtension: true,
              directoryType: AvBobOps.avDirectory,
              mimeType: FileMiming.getMimeByType(fileExt),
            );
            xFilePath = _xFile?.path;
          }
        }
        else {
          _xFile = XFile(xFilePath, bytes: _bytes);
        }

        /// EXTENSION
        if (fileExt == null){

          _bytes ??= await Byter.fromXFile(_xFile, 'completeAv');

          fileExt = await FormatDetector.detectXFile(
            xFile: _xFile,
            bytesIfThere: _bytes,
            invoker: 'AvMaker.fromBytes',
          );

        }

        double? width = avModel.width;
        double? height = avModel.height;
        String? nameWithExtension = avModel.nameWithExtension;
        double? sizeMB = avModel.sizeMB;
        int? sizeB = avModel.sizeB;

        if (width == null || height == null || sizeB == null){
          _bytes ??= await Byter.fromXFile(_xFile, 'completeAv');
        }

        await Future.wait(<Future>[

          /// DIMS : MAY NEED BYTES
          if (width == null || height == null)
            awaiter(
              wait: true,
              function: () async {

                final Dimensions? _dims = await DimensionsGetter.fromXFile(
                  xFile: _xFile,
                  bytesIfThere: _bytes,
                  invoker: 'AvMaker.fromBytes',
                  isVideo: FileTyper.checkTypeIsVideo(fileExt),
                );

                width = _dims?.width ?? width;
                height = _dims?.height ?? height;

              },
            ),

          /// nameWithExtension : MUST HAVE EXT
          if (nameWithExtension == null)
            awaiter(
              wait: true,
              function: () async {

                nameWithExtension = AvPathing.createFileNameWithExtension(
                  uploadPath: avModel.uploadPath,
                  type: fileExt,
                );

              },
            ),

          /// sizeB - sizeMB : MUST HAVE BYTES
          if (sizeB == null || sizeMB == null)
            awaiter(
              wait: true,
              function: () async {
                sizeB = _bytes?.length;
                sizeMB ??=  FileSizer.calculateSize(sizeB, FileSizeUnit.megaByte);
              },
            ),

        ]);



        _output = _output?._copyWith(
          // id: ,

          xFilePath: xFilePath,
          nameWithoutExtension: nameWithoutExtension,
          nameWithExtension: nameWithExtension,
          width: width,
          height: height,
          sizeMB: sizeMB,
          sizeB: sizeB,
          fileExt: fileExt,
          lastEdit: DateTime.now(),
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

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> _fixHeicAndHeif({
    required Uint8List? bytes,
    required AvModel? avModel,
  }) async {
    AvModel? _output = avModel;

    if (avModel != null){

      final FileExtType? _type = avModel.fileExt;

      /// HEIC OR HEIF
      if (_type == FileExtType.heic || _type == FileExtType.heif){

        final Dimensions? _dims = avModel.getDimensions();

        if (_dims != null && _dims.width != null && _dims.height != null){

          final Uint8List? _bytes = await avModel.getBytes();

          if (_bytes != null){

            await tryAndCatch(
              invoker: '_fixFileIfHeic',
              functions: () async {

                final Uint8List _newBytes = await FlutterImageCompress.compressWithList(
                  _bytes,
                  minWidth: _dims.width!.toInt(),
                  minHeight: _dims.height!.toInt(),
                  quality: 100,
                  // format: CompressFormat.jpeg,
                  // rotate: 0,
                  // autoCorrectionAngle: false,
                  // inSampleSize: ,
                  // keepExif: true,
                );

                final FileExtType _type = await FormatDetector.detectBytes(
                  bytes: _newBytes,
                  fileName: 'theNewBytesTemp',
                );

                if (_type == FileExtType.jpeg){
                  _output = await _AvFromBytes.createSingle(
                    bytes: _newBytes,
                    data: CreateSingleAVConstructor(
                      bobDocName: avModel.bobDocName,
                      skipMeta: false,
                      uploadPath: avModel.uploadPath,
                      durationMs: avModel.durationMs,
                      ownersIDs: avModel.ownersIDs,
                      data: avModel.data,
                      originalURL: avModel.originalURL,
                      originalXFilePath: avModel.originalXFilePath,
                      origin: avModel.origin,
                      height: _dims.height,
                      width: _dims.width,
                      caption: avModel.caption,
                      fileExt: FileExtType.jpeg,
                    ),
                  );
                }

              },
              onError: (String error) async {
                blog(error);
              },
            );

          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
