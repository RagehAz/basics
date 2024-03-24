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
    required String id,
    required Uint8List? bytes,
    required String? fileName,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {
    MediaModel? _output;

    if (bytes != null){

      final Dimensions? _dims =  await DimensionsGetter.fromBytes(
        bytes: bytes,
        fileName: fileName,
      );
      final double? _aspectRatio = Numeric.roundFractions(_dims?.getAspectRatio(), 2);
      final double? _mega = FileSizer.calculateSize(bytes.length, FileSizeUnit.megaByte);
      final double? _kilo = FileSizer.calculateSize(bytes.length, FileSizeUnit.kiloByte);
      final String? _deviceID = await DeviceChecker.getDeviceID();
      final String? _deviceName = await DeviceChecker.getDeviceName();
      final String _devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;
      final String? _fileName = FileTyper.fixFileName(fileName: fileName, bytes: bytes);
      final String? _extension = FileTyper.getExtension(object: bytes);
      final FileExtType? _fileExtensionType = FileTyper.getTypeByExtension(_extension);

      _output = MediaModel(
        id: id,
        bytes: bytes,
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

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SUPER FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromSuperFile({
    required String id,
    required SuperFile? file,
    String? rename,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {
    MediaModel? _output;

    SuperFile? _file = await file?.rename(newName: rename);
    _file ??= file;

    if (_file != null){

      _output = await fromBytes(
        id: id,
        fileName: _file.getFileName(withExtension: true),
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
    required String? fileName,
    required String? id,
    String? uploadPath,
    List<String>? ownersIDs,
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == false){
      return null;
    }
    else {

      final Uint8List? _bytes = await Byter.fromURL(url);

      final MediaModel? _mediaModel = await  MediaModelCreator.fromBytes(
        id: id ?? TextMod.idifyString(url)!,
        bytes: _bytes,
        fileName: fileName,
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
    required AssetEntity? asset,
    required String? rename,
    required String? id,
    String? uploadPath,
    MediaOrigin? mediaOrigin,
    List<String>? ownersIDs,
  }) async {

    final Uint8List? _bytes = await asset?.originBytes;

    final MediaModel? _model = await fromBytes(
      bytes: _bytes,
      mediaOrigin: mediaOrigin,
      uploadPath: uploadPath,
      ownersIDs: ownersIDs,
      fileName: rename,
      id: id ?? TextMod.idifyString(asset?.title)!,
    );

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// FROM LOCAL ASSET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromLocalAsset({
    required String localAsset,
    required String? id,
    String? uploadPath,
    List<String>? ownersIDs,
    String? rename,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      String? _id = id;
      _id ??= TextMod.idifyString(FilePathing.getNameFromLocalAsset(localAsset));

      _output = await fromBytes(
        id: _id!,
        mediaOrigin: MediaOrigin.generated,
        uploadPath: uploadPath ?? '',
        ownersIDs: ownersIDs,
        fileName: rename,
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
          id: null,
          // rename:
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
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fromXFile({
    required XFile? file,
    required String? id,
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

      XFile? _xFile = file;
      if (renameFile != null){
        _xFile = await XFiler.renameFile(
            file: file,
            newName: renameFile,
        );
      }

      _output = await fromBytes(
        id: id ?? TextMod.idifyString(_xFile?.name) ?? Numeric.createRandomIndex().toString(),
        bytes: _bytes,
        fileName: _xFile?.name,
        mediaOrigin: mediaOrigin,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
      );

    }

    // blog('  3.combinePicModel _output is null ${_output == null}');

    return _output;
  }
// -----------------------------------------------------------------------------
}
