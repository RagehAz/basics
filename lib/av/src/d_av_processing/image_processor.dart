part of av;
/// => GREAT
class ImageProcessor {
  // -----------------------------------------------------------------------------
  /// NO IMAGE WILL EVER BE WIDER THAN THIS TO BE PROCESSED IN THE APP
  static const double maxPicWidthBeforeCrop = 1500;
  // -----------------------------------------------------------------------------

  /// VARIABLES

  // --------------------
  AvModel? avModel;
  Uint8List? bytes;
  int? compressionQuality;
  double? resizeToWidth;
  // --------------------------------------------------------------------------

  /// PROCESS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> processImage({
    required AvModel? avModel,
    required double? resizeToWidth,
    required int? quality,
    required Future<AvModel?> Function(AvModel tempModel)? onCrop,
  }) async {
    if (avModel == null){
      return null;
    }
    else {
      return ImageProcessor()._process(
        avModel: avModel,
        resizeToWidth: resizeToWidth,
        quality: quality,
        onCrop: onCrop,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> processAvModels({
    required List<AvModel>? avModels,
    required int? quality,
    required double? resizeToWidth,
    required Future<List<AvModel>> Function(List<AvModel> avModels)? onCrop,
  }) async {
    List<AvModel> _output = avModels ?? [];

    if (Lister.checkCanLoop(_output) == true){

      final List<AvModel>? _cropped = await onCrop?.call(_output);
      _output = _cropped ?? _output;

      final List<AvModel> _finalList = [];

      await Lister.loop(
          models: _output,
          onLoop: (int index, AvModel? avModel) async {

            final AvModel? _processes = await processImage(
              quality: quality,
              resizeToWidth: resizeToWidth,
              avModel: avModel,
              onCrop: null,
            );

            if (_processes != null){
              _finalList.add(_processes);
            }

          },
      );

      _output = _finalList;

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FOUNDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> _process({
    required AvModel? avModel,
    required double? resizeToWidth,
    required int? quality,
    required Future<AvModel?> Function(AvModel tempModel)? onCrop,
  }) async {

    /// ASSIGN AV MODEL
    this.avModel = avModel;

    /// ASSIGN COMPRESSION QUALITY
    compressionQuality = quality;

    /// ASSIGN RESIZE TO WIDTH
    this.resizeToWidth = resizeToWidth;

    /// CROP
    await _crop(onCrop: onCrop);

    /// RESIZE
    await _resize();

    /// COMPRESS
    await _compress();

    /// EXPORT
    return export();
  }
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> readBytesIfAbsent() async {

    if (avModel != null){

      /// BYTES
      bytes ??= await avModel!.getBytes();

      /// DIMENSIONS
      if (avModel!.width == null || avModel!.height == null){

        final Dimensions? _dims = await DimensionsGetter.fromBytes(
          invoker: 'readBytesIfAbsent',
          bytes: bytes,
          isVideo: false,
        );

        avModel = avModel!._copyWith(
          width: _dims?.width,
          height: _dims?.height,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> export() async {
    return AvOps.completeAv(avModel: avModel, bytesIfExisted: bytes);
  }
  // --------------------------------------------------------------------------

  /// STEPS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _crop({
    required Future<AvModel?> Function(AvModel tempModel)? onCrop,
  }) async {

    if (avModel != null && onCrop != null){

      final AvModel? _received = await onCrop.call(avModel!);

      if (_received != null){
        avModel = _received;
        bytes = null;
        await readBytesIfAbsent();
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _resize() async {

    await readBytesIfAbsent();

    if (avModel != null && bytes != null && resizeToWidth != null){

      final bool _canResize = Numeric.isLesserThan(
        number: resizeToWidth,
        isLesserThan: avModel?.width,
      );

      if (_canResize == true){

        final Dimensions? _dims = avModel?.getDimensions();
        final double? _aspectRatio = _dims?.getAspectRatio();
        final double? _resizeToHeight = Dimensions.getHeightByAspectRatio(
          aspectRatio: _aspectRatio,
          width: resizeToWidth,
        );

        final Uint8List? _newBytes = await Isolate.run(() async {

          Uint8List? _bytes;

          await tryAndCatch(
            invoker: 'ImageProcessor._resize',
            functions: () async {

              final img.Image? _img = img.decodeImage(bytes!);

              if (_img != null && _resizeToHeight != null){

                final img.Image resizedImage = img.copyResize(
                  _img,
                  width: resizeToWidth?.toInt(),
                  height: _resizeToHeight.toInt(),
                );

                /// PNG ENCODING
                if (avModel!.isPNG() == true){
                  _bytes = img.encodePng(resizedImage);
                }

                /// JPG ENCODING
                else {
                  _bytes = img.encodeJpg(resizedImage);
                }

              }

            },
          );

          return _bytes;
        });

        if (_newBytes != null){
          bytes = _newBytes;
          avModel = await _AvUpdate.overrideBytes(
            bytes: bytes,
            avModel: avModel,
            newDims: Dimensions(width: resizeToWidth, height: _resizeToHeight),
          );
        }

      }

    }

    else {
      blog('_resize: PASSES . avModel.Exists(${avModel != null}).bytes.Exists(${bytes != null}).resizeToWidth.Exists(${resizeToWidth != null})');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _compress() async {

    await readBytesIfAbsent();

    if (bytes != null && compressionQuality != null){

      await tryAndCatch(
        invoker: 'ImageProcessor._compress',
        functions: () async {

          bytes = await FlutterImageCompress.compressWithList(
            bytes!,
            minWidth: avModel!.width!.toInt(),
            minHeight: avModel!.height!.toInt(),
            quality: compressionQuality!,
            format: avModel!.isPNG() == true ? CompressFormat.png : CompressFormat.jpeg,
            // rotate: 0,
            // autoCorrectionAngle: false,
            // inSampleSize: ,
            // keepExif: true,
          );

          avModel = await _AvUpdate.overrideBytes(
            bytes: bytes,
            avModel: avModel,
            newDims: Dimensions(width: avModel!.width, height: avModel!.height),
          );

        },
        // onError: (String error) async {},
      );

    }

    else {
      blog('_compress: PASSES . bytes.Exists(${bytes != null}).bytes.compressionQuality(${compressionQuality != null})');
    }

  }
  // --------------------------------------------------------------------------
}
