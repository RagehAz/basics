part of media_models;

class MediaModelCreator {
  // -----------------------------------------------------------------------------

  const MediaModelCreator();

  // -----------------------------------------------------------------------------

  /// BYTES

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromBytes({
    required Uint8List? bytes,
    required String? fileName,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {

    final XFile? _file = await XFiler.createFromBytes(
      bytes: bytes,
      fileName: fileName,
    );

    return MediaModelCreator.fromXFile(
      file: _file,
      mediaOrigin: mediaOrigin,
      uploadPath: uploadPath,
      ownersIDs: ownersIDs,
      renameFile: fileName,
    );

  }
  // -----------------------------------------------------------------------------

  /// URL

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromURL({
    required String? url,
    required String? fileName,
    String? uploadPath,
    List<String>? ownersIDs,
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == false){
      return null;
    }
    else {

      final XFile? _file = await XFiler.createFromURL(
        url: url,
        fileName: fileName,
      );

      final MediaModel? _mediaModel = await  MediaModelCreator.fromXFile(
        file: _file,
        mediaOrigin: MediaOrigin.downloaded,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        renameFile: fileName,
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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromAssetEntity({
    required AssetEntity? asset,
    required String? renameFile,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {

    final XFile? _xFile = await XFiler.createFromAssetEntity(
      assetEntity: asset,
    );

    final MediaModel? _model = await fromXFile(
      file: _xFile,
      mediaOrigin: mediaOrigin,
      uploadPath: uploadPath,
      ownersIDs: ownersIDs,
      renameFile: renameFile,
    );

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// FROM LOCAL ASSET

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromLocalAsset({
    required String localAsset,
    String? uploadPath,
    List<String>? ownersIDs,
    String? renameFile,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final XFile? _file = await XFiler.createFromLocalAsset(
        localAsset: localAsset,
      );

      _output = await fromXFile(
        file: _file,
        mediaOrigin: MediaOrigin.generated,
        uploadPath: uploadPath ?? '',
        ownersIDs: ownersIDs,
        renameFile: renameFile,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<List<MediaModel>> fromLocalAssets({
    required List<String> localAssets,
    // required int width,
  }) async {
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets){

        final MediaModel? _pic = await fromLocalAsset(
          localAsset: asset,
          // ownersIDs: ,
          // uploadPath: ,
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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> fromXFile({
    required XFile? file,
    required MediaOrigin? mediaOrigin,
    required String? uploadPath,
    required List<String>? ownersIDs,
    required String? renameFile,
  }) async {
    MediaModel? _output;

    // blog('  1.combinePicModel start : ${bytes?.length} bytes : picMakerType $picMakerType : '
    //     'assignPath : $assignPath : name : $name');

    if (file != null){

      // blog('  2.combinePicModel bytes exists bytes != null');

      final Uint8List _bytes = await file.readAsBytes();

      if (_bytes.isNotEmpty == true){

        final Dimensions? _dims =  await DimensionsGetter.fromXFile(file: file);
        final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
        final double? _mega = FileSizer.calculateSize(_bytes.length, FileSizeUnit.megaByte);
        final double? _kilo = FileSizer.calculateSize(_bytes.length, FileSizeUnit.kiloByte);
        final String? _deviceID = await DeviceChecker.getDeviceID();
        final String? _deviceName = await DeviceChecker.getDeviceName();
        final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;
        final String? _fileName = FileTyper.fixFileName(fileName: renameFile ?? file.fileName, bytes: _bytes);
        final XFile? _xFile = await XFiler.renameFile(file: file, newName: _fileName);
        final String? _extension = FileTyper.getExtension(object: _xFile);
        final FileExtType? _fileExtensionType = FileTyper.getTypeByExtension(_extension);

        _output = MediaModel(
          file: _xFile,
          meta: MediaMetaModel(
            sizeMB: _mega,
            width: _dims?.width,
            height: _dims?.height,
            fileExt: _fileExtensionType,
            name: _fileName,
            ownersIDs: ownersIDs ?? [],
            uploadPath: uploadPath,
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

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
// -----------------------------------------------------------------------------
}
