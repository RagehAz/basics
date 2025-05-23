// ignore_for_file: join_return_with_assignment
part of av;
/// => TAMAM
abstract class DimensionsGetter {
  // -----------------------------------------------------------------------------

  /// SUPER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromDynamic({
    required dynamic object,
    required bool? isVideo,
    required String invoker,
  }) async {

    if (object is AvModel){
      return fromAvModel(avModel: object);
    }

    /// X FILE
    else if (ObjectCheck.objectIsXFile(object) == true){
      return fromXFile(xFile: object, isVideo:isVideo, invoker: 'DimensionsGetter.fromDynamic.invoker', bytesIfThere: null);
    }

    /// FILE
    else if (ObjectCheck.objectIsFile(object) == true){
      return fromFile(file: object, isVideo: isVideo, bytesIfThere: null);
    }

    /// BYTES
    else if (ObjectCheck.objectIsUint8List(object) == true){
      return fromBytes(bytes: object, invoker: 'fromDynamic', isVideo: isVideo);
    }

    /// URL
    else if (ObjectCheck.isAbsoluteURL(object) == true){
      return fromURL(url: object, isVideo: isVideo);
    }

    /// LOCAL ASSET
    else if (ObjectCheck.objectIsJPGorPNG(object) == true || ObjectCheck.objectIsSVG(object) == true){
      return fromLocalAsset(localAsset: object);
    }

    /// OTHERWISE
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromBytes({
    required Uint8List? bytes,
    required bool? isVideo,
    required String invoker,
  }) async {
    Dimensions? _output;

    if (bytes != null){

      Uint8List? _bytes;

      if (Booler.boolIsTrue(isVideo) == true){
        await XFiler.getOrCreateTempXFile(
            invoker: 'fromBytes',
            fileName: 'temp',
            bytes: bytes,
            ops: (XFile xFile) async {
              _bytes = await Byter.getVideoThumb(filePath: xFile.path);
              _bytes ??= bytes;
            });
      }

      else {
        _bytes = bytes;
      }

      if (_bytes != null){

        const bool _isDecodable = true;
        // Decoding.checkImageIsDecodable(
        //   bytes: _bytes,
        // );

        if (_isDecodable == true){

          final img.Image? _image = await Imager.getImgImageFromUint8List(_bytes);
          final int? width = _image?.width;
          final int? height = _image?.height;

          // blog('_getImageDimensions.isDecodable($_isDecodable).width($width).height($height)');

          if (width != null && height != null){
            _output = Dimensions(
              width: width.toDouble(),
              height: height.toDouble(),
            );
          }

        }


      }

    }

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
      invoker: 'fromLocalAsset',
      isVideo: false,
    );
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromAvModel({
    required AvModel? avModel,
  }) async {
    return Dimensions(width: avModel?.width, height: avModel?.height);
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromURL({
    required String? url,
    required bool? isVideo,
  }) async {

    final Uint8List? _bytes = await Byter.fromURL(url);

    return fromBytes(
      invoker: 'fromURL',
      bytes: _bytes,
      isVideo: isVideo,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromFile({
    required File? file,
    required bool? isVideo,
    required Uint8List? bytesIfThere,
  }) async {
    XFile? _xFile;

    if (file != null){
      _xFile = XFiler.readFile(file: file);
    }

    return fromXFile(xFile: _xFile, invoker: 'DG.fromFile', isVideo: isVideo, bytesIfThere: bytesIfThere);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromXFile({
    required XFile? xFile,
    required String invoker,
    required bool? isVideo,
    required Uint8List? bytesIfThere,
  }) async {
    Dimensions? _output;

    if (xFile != null || bytesIfThere != null){

      Uint8List? _bytes = bytesIfThere;

      if (Booler.boolIsTrue(isVideo) == true){
        _bytes = await Byter.getVideoThumb(filePath: xFile?.path);
        _bytes ??= bytesIfThere;
        /*
      final Map<String, dynamic>? _map = await XFiler.readXFileInfo(
        xFile: xFile,
      );

      if (_map != null) {
        final List<Object?> _objects = _map['streams'] ?? <Object?>[];
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
       */
      }

      else {
        _bytes = bytesIfThere;
        _bytes ??= await Byter.fromXFile(xFile, 'DimensionsGetter.fromXFile($invoker})');
      }

      if (_bytes != null){

        const bool _isDecodable = true;
        // Decoding.checkImageIsDecodable(
        //   bytes: _bytes,
        // );

        if (_isDecodable == true){

          final img.Image? _image = await Imager.getImgImageFromUint8List(_bytes);
          final int? width = _image?.width;
          final int? height = _image?.height;

          // blog('_getImageDimensions.isDecodable($_isDecodable).width($width).height($height)');

          if (width != null && height != null){
            _output = Dimensions(
              width: width.toDouble(),
              height: height.toDouble(),
            );
          }

        }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
