part of media_models;
/// => TAMAM
abstract class MediaModelCreator {
  // -----------------------------------------------------------------------------

  /// FILE NAME ADJUSTMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String?>> _adjustPathAndName({
    required String uploadPath,
    required bool includeFileExtension,
    required Uint8List? bytes,
  }) async {
    String? _uploadPathOutput;
    String? _fileNameOutput;
    String? _fileExtension = FileExtensioning.getExtensionFromPath(uploadPath);

    // blog('1. _adjustPathAndName : start');

    /// WITH FILE EXTENSION : WILL NEED DETECTION
    if (includeFileExtension == true){

      // blog('2. _adjustPathAndName : includeFileExtension : $includeFileExtension');

      final String? _fileNameWithoutExtension = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: true,
      );

      // blog('3. _adjustPathAndName : _fileNameWithoutExtension : $_fileNameWithoutExtension');

      _fileNameOutput = await FormatDetector.fixFileNameByBytes(
        fileName: _fileNameWithoutExtension,
        bytes: bytes,
        includeFileExtension: true,
      );

      // blog('4. _adjustPathAndName : _fileNameOutput : $_fileNameOutput');

      /// REPLACE IT IN PATH ANYWAYS : NAME MIGHT ORIGINALLY WAS WITH EXTENSION IN THE PATH
      _uploadPathOutput = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileNameOutput,
      );

      // blog('5. _adjustPathAndName : _uploadPathOutput : $_uploadPathOutput');

      _fileExtension = FileExtensioning.getExtensionFromPath(_uploadPathOutput);

      // blog('6. _adjustPathAndName : _fileExtension : $_fileExtension');

    }

    /// WITHOUT FILE EXTENSION : NO DETECTION NEEDED
    else {

      /// GET NAME WITHOUT EXTENSION
      _fileNameOutput = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: false,
      );

      /// REPLACE IT IN PATH ANYWAYS : NAME MIGHT ORIGINALLY WAS WITH EXTENSION IN THE PATH
      _uploadPathOutput = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileNameOutput,
      );

    }

    return {
      'id': MediaModel.createID(uploadPath: _uploadPathOutput),
      'uploadPath': _uploadPathOutput,
      'fileName': _fileNameOutput,
      'fileExtension': _fileExtension,
    };
  }
  // -----------------------------------------------------------------------------

  /// BYTES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromBytes({
    required Uint8List? bytes,
    required String uploadPath,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    // blog('fromBytes : START : bytes != null : ${bytes != null} : TextCheck.isEmpty(uploadPath) == false : ${TextCheck.isEmpty(uploadPath) == false}');

    if (bytes != null && TextCheck.isEmpty(uploadPath) == false){

      final Map<String, String?> _adjustedPaths = await _adjustPathAndName(
        includeFileExtension: includeFileExtension,
        bytes: bytes,
        uploadPath: uploadPath,
      );

      final String? _fileName = _adjustedPaths['fileName'];
      final String? _uploadPath = _adjustedPaths['uploadPath'];
      final String? _id = _adjustedPaths['id'];
      // final String? _fileExtension = _adjustedPaths['fileExtension'];

      // Mapper.blogMap(_adjustedPaths, invoker: 'fromBytes');

      if (_id != null){

        MediaMetaModel? _meta;

        if (skipMetaData == false){

          final Map<String?, dynamic> _map = await _getDimsAndFileType(
            id: _id,
            bytes: bytes,
          );
          final Dimensions? _dims = _map['dims'];
          final FileExtType? _fileExtensionType = _map['fileExtensionType'];

          _meta = MediaMetaModel(
            sizeMB: FileSizer.calculateSize(bytes.length, FileSizeUnit.megaByte),
            width: _dims?.width,
            height: _dims?.height,
            fileExt: _fileExtensionType,
            /// RULE : should be exactly the name in the upload path
            name: _fileName,
            ownersIDs: ownersIDs ?? [],
            uploadPath: _uploadPath,
            data: MapperSS.cleanNullPairs(
              map: {
                'aspectRatio': Numeric.roundFractions(_dims?.getAspectRatio(), 2)?.toString(),
                'sizeB': bytes.length.toString(),
                'sizeKB': FileSizer.calculateSize(bytes.length, FileSizeUnit.kiloByte)?.toString(),
                'source': MediaModel.cipherMediaOrigin(mediaOrigin),
                'deviceID': await DeviceChecker.getDeviceID(),
                'deviceName': await DeviceChecker.getDeviceName(),
                'platform': kIsWeb == true ? 'web' : Platform.operatingSystem,
                'caption': caption,
              },
            ),
          );

        }

        _output = MediaModel(
          id: _id,
          bytes: bytes,
          meta: _meta,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> _getDimsAndFileType({
    required String id,
    required Uint8List bytes,
  }) async {

    Dimensions? _dims;
    FileExtType? _fileExtensionType;

    await XFiler.getOrCreateTempXFile(
      invoker: '_getDimsAndFileType',
      fileName: id,
      bytes: bytes,
      ops: (XFile xFile) async {

        /// DEPRECATED
        // await tryAndCatch(
        //   invoker: 'FormatDetector._byInfo',
        //   functions: () async {
        //
        //     final FlutterVideoInfo videoInfo = FlutterVideoInfo();
        //     final VideoData? info = await videoInfo.getVideoInfo(xFile.path);
        //
        //     if (info != null){
        //       _dims = Dimensions(width: info.width?.toDouble(), height: info.height?.toDouble());
        //       _fileExtensionType = FileMiming.getTypeByMime(info.mimetype);
        //     }
        //
        //   },
        // );

        await Future.wait(<Future>[

          /// DIMS
          awaiter(
            wait: true,
            function: () async {
              _dims =  await DimensionsGetter.fromXFile(
                xFile: xFile,
                invoker: 'createTheMediaModelFromBytes',
              );
            },
          ),

          /// FILE TYPE
          awaiter(
            wait: true,
            function: () async {
              _fileExtensionType = await FormatDetector.detectXFile(
                xFile: xFile,
                invoker: 'createTheMediaModelFromBytes',
                bytesIfThere: bytes,
              );
            },
          ),

        ]);

      },
    );

    return {
      'dims': _dims,
      'fileExtensionType': _fileExtensionType,
    };

  }
  // -----------------------------------------------------------------------------

  /// FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromFile({
    required File? file,
    required String uploadPath,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    final Uint8List? _bytes = await Byter.fromFile(file);

    _output = await fromBytes(
      bytes: _bytes,
      uploadPath: uploadPath,
      caption: caption,
      mediaOrigin: mediaOrigin,
      ownersIDs: ownersIDs,
      includeFileExtension: includeFileExtension,
      skipMetaData: skipMetaData,
    );


    // if (file != null && _bytes != null && TextCheck.isEmpty(uploadPath) == false){
    //
    //   final String? _originalFileName = file.fileNameWithoutExtension;
    //
    //   final String? _uploadPath = FilePathing.replaceFileNameInPath(
    //     oldPath: uploadPath,
    //     fileName: _originalFileName,
    //   );
    //
    //   final String? _id = MediaModel.createID(
    //     uploadPath: _uploadPath,
    //   );
    //
    //   if (_id != null){
    //
    //     final Dimensions? _dims =  await DimensionsGetter.fromFile(
    //       file: file,
    //     );
    //     final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
    //     final double? _mega = FileSizer.getFileSizeWithUnit(
    //       file: file,
    //       unit: FileSizeUnit.megaByte,
    //     );
    //     final double? _kilo = FileSizer.getFileSizeWithUnit(
    //       file: file,
    //       unit: FileSizeUnit.kiloByte,
    //     );
    //     final String? _deviceID = await DeviceChecker.getDeviceID();
    //     final String? _deviceName = await DeviceChecker.getDeviceName();
    //     final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;
    //     // final String? _extension = FileTyper.getExtension(object: bytes);
    //
    //     final FileExtType? _fileExtensionType = await FormatDetector.detectFile(
    //       file: file,
    //     );
    //
    //     _output = MediaModel(
    //       id: _id,
    //       bytes: _bytes,
    //       meta: MediaMetaModel(
    //         sizeMB: _mega,
    //         width: _dims?.width,
    //         height: _dims?.height,
    //         fileExt: _fileExtensionType,
    //         name: _originalFileName,
    //         ownersIDs: ownersIDs ?? [],
    //         uploadPath: _uploadPath,
    //         data: MapperSS.cleanNullPairs(
    //           map: {
    //             'aspectRatio': _aspectRatio.toString(),
    //             'sizeB': _bytes.length.toString(),
    //             'sizeKB': _kilo.toString(),
    //             'source': MediaModel.cipherMediaOrigin(mediaOrigin),
    //             'deviceID': _deviceID,
    //             'deviceName': _deviceName,
    //             'platform': _devicePlatform,
    //             'file_path': file.path,
    //             'caption': caption,
    //           },
    //         ),
    //       ),
    //     );
    //   }
    //
    // }

    return _output?.setFilePath(filePath: file?.path);
  }
  // -----------------------------------------------------------------------------

  /// SUPER FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromSuperFile({
    required SuperFile? file,
    required String uploadPath,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    // final String? _fileName = FileNaming.getNameFromPath(
    //     path: uploadPath,
    //     withExtension: false,
    // );
    // SuperFile? _file = await file?.rename(newName: _fileName);
    // _file ??= file;

    if (file != null){

      _output = await fromBytes(
        bytes: await file.readBytes(),
        ownersIDs: ownersIDs,
        uploadPath: uploadPath,
        mediaOrigin: mediaOrigin,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMetaData: skipMetaData,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromURL({
    required String? url,
    required String uploadPath,
    required bool skipMetaData,
    List<String>? ownersIDs,
    MediaOrigin? mediaOrigin,
    String? caption,
    bool includeFileExtension = false,
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == false){
      return null;
    }

    else {

      final Uint8List? _bytes = await Byter.fromURL(url);

      final MediaModel? _mediaModel = await  MediaModelCreator.fromBytes(
        bytes: _bytes,
        mediaOrigin: mediaOrigin ?? MediaOrigin.downloaded,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMetaData: skipMetaData,
      );

      return _mediaModel?.setOriginalURL(originalURL: url);

      // return _mediaModel?.copyWith(
      //   meta: _mediaModel.meta?.copyWith(
      //       data: MapperSS.insertPairInMapWithStringValue(
      //         map: _mediaModel.meta?.data,
      //         key: 'original_url',
      //         value: url!,
      //         overrideExisting: true,
      //       )
      //   ),
      // );

    }

  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromURLs({
    required List<String>? urls,
    required String Function(int index) uploadPathGenerator,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
    List<String>? captions,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(urls) == true){

      for (int i = 0; i < urls!.length; i++){

        final String _url = urls[i];

        final MediaModel? _model = await MediaModelCreator.fromURL(
          url: _url,
          mediaOrigin: mediaOrigin,
          uploadPath: uploadPathGenerator.call(i),
          ownersIDs: ownersIDs,
          includeFileExtension: includeFileExtension,
          caption: captions?[i],
          skipMetaData: skipMetaData,
        );

        if (_model != null){
          _output.add(_model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ASSET ENTITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromAssetEntity({
    required AssetEntity? entity,
    required String uploadPath,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    if (entity != null){

      File? _file = await entity.originFile;

      _file = await _fixFileIfHeic(
        file: _file,
        entity: entity,
      );

      _output = await fromFile(
        file: _file,
        mediaOrigin: mediaOrigin,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMetaData: skipMetaData,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> _fixFileIfHeic({
    required File? file,
    required AssetEntity entity,
  }) async {
    File? _output = file;

    /// IF_PIC_IS_HEIC_TRANSFORM_INTO_JPEG
    final FileExtType? _type = FileMiming.getTypeByMime(entity.mimeType);

    /// HEIC OR HEIF
    if (_type == FileExtType.heic || _type == FileExtType.heif){

      await tryAndCatch(
        invoker: '_fixFileIfHeic',
        functions: () async {

          Uint8List? _bytes = await Byter.fromFile(file);

          if (_bytes != null){

            _bytes = await FlutterImageCompress.compressWithList(
              _bytes,
              minWidth: entity.width,
              minHeight: entity.height,
              quality: 100,
              // format: CompressFormat.jpeg,
              // rotate: 0,
              // autoCorrectionAngle: false,
              // inSampleSize: ,
              // keepExif: true,
            );

          }

          _output = await Filer.createFromBytes(bytes: _bytes, fileName: TextMod.idifyString(entity.title));

        },
        onError: (String error) async {
          blog(error);
          // _output = await FlutterImageCompress.compressWithList(
          //   bytes,
          //   minWidth: compressToWidth.toInt(),
          //   minHeight: _compressToHeight.toInt(),
          //   quality: quality,
          //   // autoCorrectionAngle: ,
          //   // format: ,
          //   // inSampleSize: ,
          //   // keepExif: ,
          //   // rotate: ,
          // );
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromAssetEntities({
    required List<AssetEntity>? entities,
    required String Function(int index, String? title) uploadPathGenerator,
    required bool skipMetaData,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(entities) == true){

      await Lister.loop(
          models: entities,
          onLoop: (int i, AssetEntity? entity) async {

            if (entity != null){

              final AssetEntity _entity = entity;

              final MediaModel? _model = await MediaModelCreator.fromAssetEntity(
                entity: _entity,
                mediaOrigin: mediaOrigin,
                uploadPath: uploadPathGenerator.call(i, _entity.title),
                ownersIDs: ownersIDs,
                includeFileExtension: includeFileExtension,
                skipMetaData: skipMetaData,
                // caption: null,
              );

              _model?.setOriginalURL(
                originalURL: await Entities.getAssetEntityURL(_entity),
              );

              if (_model != null){
                _output.add(_model);
              }

            }

          },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FROM LOCAL ASSET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromLocalAsset({
    required String localAsset,
    required String uploadPath,
    required bool skipMetaData,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      _output = await fromBytes(
        mediaOrigin: MediaOrigin.generated,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        bytes: _bytes,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMetaData: skipMetaData,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromLocalAssets({
    required List<String> localAssets,
    required bool skipMetaData,
    bool includeFileExtension = false,
    // required int width,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets){

        final MediaModel? _pic = await fromLocalAsset(
          localAsset: asset,
          uploadPath: FileNaming.getNameFromLocalAsset(asset)!,
          includeFileExtension: includeFileExtension,
          skipMetaData: skipMetaData,
          // caption: null,
          // ownersIDs: ,
        );

        if (_pic != null){
          _output.add(_pic);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FROM X FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromXFile({
    required XFile? file,
    required MediaOrigin? mediaOrigin,
    required String uploadPath,
    required List<String>? ownersIDs,
    required bool skipMetaData,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    // blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
    //     'assignPath : $assignPath : name : $name');

    if (file != null){

      // blog('  2.combinePicModel bytes exists bytes != null');

      final String? _fileName = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: false,
      );

      final XFile? _xFile = await XFiler.renameFile(
        file: file,
        newName: _fileName,
      );

      if (_xFile != null){

        _output = await fromBytes(
          bytes: await _xFile.readAsBytes(),
          ownersIDs: ownersIDs,
          uploadPath: uploadPath,
          mediaOrigin: mediaOrigin,
          caption: caption,
          includeFileExtension: includeFileExtension,
          skipMetaData: skipMetaData,
        );

      }

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
// -----------------------------------------------------------------------------
}
