part of media_models;
/// => TAMAM
class MediaModelCreator {
  // -----------------------------------------------------------------------------

  const MediaModelCreator();

  // -----------------------------------------------------------------------------

  /// BYTES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromBytes({
    required Uint8List? bytes,
    required String uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {
    MediaModel? _output;

    if (bytes != null && TextCheck.isEmpty(uploadPath) == false){

      final String? _lastPathNode = FilePathing.getNameFromPath(
          path: uploadPath,
          withExtension: false,
      );
      final String? _fileName = FilePathing.fixFileName(
        fileName: _lastPathNode,
        bytes: bytes,
        includeFileExtension: false,
      );
      final String? _uploadPath = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileName,
      );
      final String? _id = MediaModel.createID(
        uploadPath: _uploadPath,
      );

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
        final String? _extension = FileTyper.getExtension(object: bytes);
        final FileExtType? _fileExtensionType = FileTyper.getTypeByExtension(_extension);

        _output = MediaModel(
          id: _id,
          bytes: bytes,
          meta: MediaMetaModel(
            sizeMB: _mega,
            width: _dims?.width,
            height: _dims?.height,
            fileExt: _fileExtensionType,
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
  }) async {
    MediaModel? _output;

    final Uint8List? _bytes = await Byter.fromFile(file);

    if (file != null && _bytes != null && TextCheck.isEmpty(uploadPath) == false){

      final String? _fileName = file.fileNameWithoutExtension;

      final String? _uploadPath = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileName,
      );

      final String? _id = MediaModel.createID(
        uploadPath: _uploadPath,
      );

      if (_id != null){

        final Dimensions? _dims =  await DimensionsGetter.fromFile(
          file: file,
        );
        final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
        final double? _mega = FileSizer.getFileSizeWithUnit(
          file: file,
          unit: FileSizeUnit.megaByte,
        );
        final double? _kilo = FileSizer.getFileSizeWithUnit(
          file: file,
          unit: FileSizeUnit.kiloByte,
        );
        final String? _deviceID = await DeviceChecker.getDeviceID();
        final String? _deviceName = await DeviceChecker.getDeviceName();
        final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;
        // final String? _extension = FileTyper.getExtension(object: bytes);

        final FileExtType? _fileExtensionType = FileTyper.detectFileExtType(
          file: file,
          bytes: _bytes,
        );

        _output = MediaModel(
          id: _id,
          bytes: _bytes,
          meta: MediaMetaModel(
            sizeMB: _mega,
            width: _dims?.width,
            height: _dims?.height,
            fileExt: _fileExtensionType,
            name: _fileName,
            ownersIDs: ownersIDs ?? [],
            uploadPath: _uploadPath,
            data: MapperSS.cleanNullPairs(
              map: {
                'aspectRatio': _aspectRatio.toString(),
                'sizeB': _bytes.length.toString(),
                'sizeKB': _kilo.toString(),
                'source': MediaModel.cipherMediaOrigin(mediaOrigin),
                'deviceID': _deviceID,
                'deviceName': _deviceName,
                'platform': _devicePlatform,
              },
            ),
          ),
        );
      }

    }

    return _output;
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
  }) async {
    MediaModel? _output;

    final String? _fileName = FilePathing.getNameFromPath(
        path: uploadPath,
        withExtension: false,
    );
    SuperFile? _file = await file?.rename(newName: _fileName);
    _file ??= file;

    if (_file != null){

      _output = await fromBytes(
        bytes: await _file.readBytes(),
        ownersIDs: ownersIDs,
        uploadPath: uploadPath,
        mediaOrigin: mediaOrigin,
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
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == false){
      return null;
    }
    else {

      final Uint8List? _bytes = await Byter.fromURL(url);

      final MediaModel? _mediaModel = await  MediaModelCreator.fromBytes(
        bytes: _bytes,
        mediaOrigin: MediaOrigin.downloaded,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
      );

      return _mediaModel?.copyWith(
        meta: _mediaModel.meta?.copyWith(
            data: MapperSS.insertPairInMapWithStringValue(
              map: _mediaModel.meta?.data,
              key: 'original_url',
              value: url!,
              overrideExisting: true,
            )
        ),
      );

    }

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
  }) async {
    MediaModel? _output;

    if (entity != null){

      final Uint8List? _bytes = await entity.originBytes;

      _output = await fromBytes(
        bytes: _bytes,
        mediaOrigin: mediaOrigin,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
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
        bytes: _bytes
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fromLocalAssets({
    required List<String> localAssets,
    // required int width,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets){

        final MediaModel? _pic = await fromLocalAsset(
          localAsset: asset,
          uploadPath: FilePathing.getNameFromLocalAsset(asset)!,
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
  }) async {
    MediaModel? _output;

    // blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
    //     'assignPath : $assignPath : name : $name');

    if (file != null){

      // blog('  2.combinePicModel bytes exists bytes != null');

      final String? _fileName = FilePathing.getNameFromPath(
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
        );

      }

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
// -----------------------------------------------------------------------------
}
