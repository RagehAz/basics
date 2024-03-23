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
  }) async {

    if (object is MediaModel){
      return fromMediaModel(mediaModel: object);
    }

    else if (object is SuperFile){
      return fromSuperFile(file: object);
    }

    /// X FILE
    else if (ObjectCheck.objectIsXFile(object) == true){
      return fromXFile(file: object);
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

      final XFile? _xFile = await XFiler.createFromBytes(
        bytes: _bytes,
        fileName: file?.getFileName(withExtension: true),
      );

      _output = await _getVideoDimensions(
        xFile: _xFile,
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

    Dimensions? _output = await _getImageDimensions(
      bytes: bytes,
    );

    if (_output == null){

      final XFile? _xFile = await XFiler.createFromBytes(
        bytes: bytes,
        fileName: fileName,
      );

      _output = await _getVideoDimensions(
        xFile: _xFile,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromLocalAsset({
    required String? localAsset,
  }) async {

    final SuperFile? _file = await SuperFile.createFromLocalAsset(
      localAsset: localAsset,
    );

    return fromSuperFile(file: _file);
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromMediaModel({
    required MediaModel? mediaModel,
  }) async {
    return fromSuperFile(file: mediaModel?.file);
  }
  // --------------------
  /// TASK : WILL_NOT_WORK_ON_WEB
  static Future<Dimensions?> fromURL({
    required String? url,
    required String? fileName,
  }) async {

    final SuperFile? _file = await SuperFile.createFromURL(
      url: url,
      fileName: fileName,
    );

    return fromSuperFile(file: _file);
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

    return fromXFile(file: _xFile);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> fromXFile({
    required XFile? file,
  }) async {

    final Uint8List? _bytes = await Byter.fromXFile(file);

    Dimensions? _output = await _getImageDimensions(
      bytes: _bytes,
    );

    _output ??= await _getVideoDimensions(
      xFile: file,
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

      await tryAndCatch(
        invoker: 'getImageDimensions',
        functions: () async {

          final img.Decoder? _decoder = FileTyper.getImageDecoderFromBytes(
            bytes: bytes,
          );

          // blog('decoder.runtimeType : ${_decoder?.runtimeType}');

          if (_decoder != null){

            final img.Image? _image = await Imager.getImgImageFromUint8List(bytes);
            final int? width = _image?.width;
            final int? height = _image?.height;

            if (width != null && height != null){
              _output = Dimensions(
                width: width.toDouble(),
                height: height.toDouble(),
              );
            }

          }

        },
      );

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

      /// '<file path or url>'
      final MediaInformationSession session = await FFprobeKit.getMediaInformation(xFile.path);
      final MediaInformation? information = session.getMediaInformation();

      // await VideoOps.blogMediaInformationSession(session: session);

      if (information == null) {
        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        // final state = FFmpegKitConfig.sessionStateToString(await session.getState());
        // final returnCode = await session.getReturnCode();
        // final failStackTrace = await session.getFailStackTrace();
        // final duration = await session.getDuration();
        // final output = await session.getOutput();
      }

      else {
        final Map<dynamic, dynamic>? _maw = information.getAllProperties();
        final Map<String, dynamic> _map = Mapper.convertDynamicMap(_maw);
        final List<Object?> _objects = _map['streams'];
        final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(dynamics: _objects);

        if( Lister.checkCanLoop(_maps) == true){
          final Map<String, dynamic>? _data = _maps.first;
          final int? height = _data?['height'];
          final int? _width = _data?['width'];
          _output = Dimensions(width: _width?.toDouble(), height: height?.toDouble());
        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}