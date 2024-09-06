// ignore_for_file: join_return_with_assignment
part of media_models;
/// => TAMAM
abstract class DimensionsGetter {
  // -----------------------------------------------------------------------------

  const DimensionsGetter();

  // -----------------------------------------------------------------------------

  /// SUPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromDynamic({
    required dynamic object,
    required String fileName,
    required String invoker,
  }) async {

    if (object is MediaModel){
      return fromMediaModel(mediaModel: object);
    }

    else if (object is SuperFile){
      return fromSuperFile(file: object);
    }

    /// X FILE
    else if (ObjectCheck.objectIsXFile(object) == true){
      return fromXFile(xFile: object, invoker: 'DimensionsGetter.fromDynamic.invoker');
    }

    /// FILE
    else if (ObjectCheck.objectIsFile(object) == true){
      return fromFile(file: object);
    }

    /// BYTES
    else if (ObjectCheck.objectIsUint8List(object) == true){
      return fromBytes(bytes: object, fileName: fileName);
    }

    /// URL
    else if (ObjectCheck.isAbsoluteURL(object) == true){
      return fromURL(url: object, fileName: fileName);
    }

    /// LOCAL ASSET
    else if (ObjectCheck.objectIsJPGorPNG(object) == true || ObjectCheck.objectIsSVG(object) == true){
      return fromLocalAsset(localAsset: object);
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromSuperFile({
    required SuperFile? file,
  }) async {

    final Uint8List? _bytes = await file?.readBytes();

    Dimensions? _output = await _getImageDimensions(
      bytes: _bytes,
    );

    if (_output == null){

      await XFiler.getOrCreateTempXFile(
          fileName: file?.getFileName(withExtension: true),
          bytes: _bytes,
          ops: (XFile xFile) async {

            _output = await _getVideoDimensions(
              xFile: xFile,
            );

          }
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromBytes({
    required Uint8List? bytes,
    required String? fileName,
  }) async {
    Dimensions? _output;

    await XFiler.getOrCreateTempXFile(
        fileName: fileName,
        bytes: bytes,
        ops: (XFile xFile) async {

          _output = await fromXFile(
            xFile: xFile,
            invoker: 'DimensionsGetter.fromBytes(getOrCreateTempXFile)',
          );

        }
    );

    return _output;
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromLocalAsset({
    required String? localAsset,
  }) async {

    final Uint8List? _bytes = await Byter.fromLocalAsset(
      localAsset: localAsset,
    );

    return fromBytes(
      bytes: _bytes,
      fileName: FileNaming.getNameFromLocalAsset(localAsset),
    );
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromMediaModel({
    required MediaModel? mediaModel,
  }) async {
    return fromBytes(
      bytes: mediaModel?.bytes,
      fileName: mediaModel?.getName(
          // withExtension: true
      ),
    );
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromURL({
    required String? url,
    required String? fileName,
  }) async {

    final Uint8List? _bytes = await Byter.fromURL(url);

    return fromBytes(
      bytes: _bytes,
      fileName: fileName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromFile({
    required File? file,
  }) async {
    XFile? _xFile;

    if (file != null){
      _xFile = XFiler.readFile(file: file);
    }

    return fromXFile(xFile: _xFile, invoker: 'DG.fromFile');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromXFile({
    required XFile? xFile,
    required String invoker,
  }) async {

    final Uint8List? _bytes = await Byter.fromXFile(xFile, 'DimensionsGetter.fromXFile.$invoker');

    Dimensions? _output = await _getImageDimensions(
      bytes: _bytes,
    );

    _output ??= await _getVideoDimensions(
      xFile: xFile,
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> _getImageDimensions({
    required Uint8List? bytes,
  }) async {
    Dimensions? _output;

    if (bytes != null){

      final bool _isDecodable = Decoding.checkImageIsDecodable(
        bytes: bytes,
      );

      blog('_getImageDimensions  _isDecodable($_isDecodable)');

      if (_isDecodable == true){

        final img.Image? _image = await Imager.getImgImageFromUint8List(bytes);
        final int? width = _image?.width;
        final int? height = _image?.height;

        blog('==> _width : $width : _height : $height');

        if (width != null && height != null){
          _output = Dimensions(
            width: width.toDouble(),
            height: height.toDouble(),
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// VIDEO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> _getVideoDimensions({
    required XFile? xFile,
  }) async {
    Dimensions? _output;

    if (xFile != null){

      final Map<String, dynamic>? _map = await XFiler.readXFileInfo(
        xFile: xFile,
      );

      if (_map != null) {
        final List<Object?> _objects = _map['streams'];
        final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(dynamics: _objects);
        if(Lister.checkCanLoop(_maps) == true){
          for (final Map<String, dynamic> _data in _maps){
            final int? height = _data['height'];
            final int? _width = _data['width'];
            if (height != null && _width != null){
              _output = Dimensions(width: _width.toDouble(), height: height.toDouble());
              break;
            }
          }
        }
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
