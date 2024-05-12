part of media_models;
/// => TAMAM
class MediaModelCreator {
  // -----------------------------------------------------------------------------

  const MediaModelCreator();

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
      final String? _fileExtension = _adjustedPaths['fileExtension'];

      // Mapper.blogMap(_adjustedPaths, invoker: 'fromBytes');

      if (_id != null){

        final Dimensions? _dims =  await DimensionsGetter.fromBytes(
          bytes: bytes,
          fileName: _fileName,
        );
        final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
        final double? _mega = FileSizer.calculateSize(bytes.length, FileSizeUnit.megaByte);
        final double? _kilo = FileSizer.calculateSize(bytes.length, FileSizeUnit.kiloByte);
        final String? _deviceID = await DeviceChecker.getDeviceID();
        final String? _deviceName = await DeviceChecker.getDeviceName();
        final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;

        FileExtType? _fileExtensionType = FileExtensioning.getTypeByExtension(_fileExtension);
        _fileExtensionType ??= await FormatDetector.detectBytes(bytes: bytes, fileName: _fileName);

        _output = MediaModel(
          id: _id,
          bytes: bytes,
          meta: MediaMetaModel(
            sizeMB: _mega,
            width: _dims?.width,
            height: _dims?.height,
            fileExt: _fileExtensionType,
            /// RULE : should be exactly the name in the upload path
            name: _fileName,
            ownersIDs: ownersIDs ?? [],
            uploadPath: _uploadPath,
            data: MapperSS.cleanNullPairs(
              map: {
                'aspectRatio': _aspectRatio.toString(),
                'sizeB': bytes.length.toString(),
                'sizeKB': _kilo.toString(),
                'source': MediaModel.cipherMediaOrigin(mediaOrigin),
                'deviceID': _deviceID,
                'deviceName': _deviceName,
                'platform': _devicePlatform,
                'caption': caption,
              },
            ),
          ),
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromFile({
    required File? file,
    required String uploadPath,
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
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    MediaModel? _output;

    if (entity != null){

      final File? _file = await entity.originFile;

      _output = await fromFile(
        file: _file,
        mediaOrigin: mediaOrigin,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        caption: caption,
        includeFileExtension: includeFileExtension,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromAssetEntities({
    required List<AssetEntity>? entities,
    required String Function(int index, String? title) uploadPathGenerator,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(entities) == true){

      for (int i = 0; i < entities!.length; i++){

        final AssetEntity _entity = entities[i];

        final MediaModel? _model = await MediaModelCreator.fromAssetEntity(
          entity: _entity,
          mediaOrigin: mediaOrigin,
          uploadPath: uploadPathGenerator.call(i, _entity.title),
          ownersIDs: ownersIDs,
          includeFileExtension: includeFileExtension,
          // caption: null,
        );

        _model?.setOriginalURL(
            originalURL: await _entity.getMediaUrl(),
        );

        if (_model != null){
          _output.add(_model);
        }

      }

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
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromLocalAssets({
    required List<String> localAssets,
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
        );

      }

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
// -----------------------------------------------------------------------------
}
