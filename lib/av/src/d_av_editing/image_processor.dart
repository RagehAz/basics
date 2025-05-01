part of av;

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
  ///
  static Future<AvModel?> processImage({
    required AvModel? avModel,
    required double? resizeToWidth,
    required int? quality,
    required Future<AvModel> Function(AvModel tempModel)? onCrop,
  }) async {
    return ImageProcessor()._process(
      avModel: avModel,
      resizeToWidth: resizeToWidth,
      quality: quality,
      onCrop: onCrop,
    );
  }
  // --------------------
  ///
  static Future<List<AvModel>> processAvModels({
    required List<AvModel> avModels,
    required int? quality,
    required double? resizeToWidth,
    required Future<List<AvModel>> Function(List<AvModel> avModels)? onCrop,
  }) async {
    List<AvModel> _output = await onCrop?.call(avModels) ?? [...avModels];

    if (Lister.checkCanLoop(_output) == true){

      final List<AvModel> _finalList = [];

      for (final AvModel avModel in _output){

        final AvModel? _processes = await processImage(
          quality: quality,
          resizeToWidth: resizeToWidth,
          avModel: avModel,
          onCrop: null,
        );

        if (_processes != null){
          _finalList.add(_processes);
        }

      }

      _output = _finalList;

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FOUNDATION

  // --------------------
  Future<AvModel?> _process({
    required AvModel? avModel,
    required double? resizeToWidth,
    required int? quality,
    required Future<AvModel> Function(AvModel tempModel)? onCrop,
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
  ///
  Future<void> readBytesIfAbsent() async {

    if (avModel != null){

      /// BYTES
      bytes ??= await avModel!.getBytes();

      /// DIMENSIONS
      if (avModel!.width == null || avModel!.height == null){

        final Dimensions? _dims = await DimensionsGetter.fromBytes(
          invoker: 'readBytesIfAbsent',
          bytes: bytes,
          fileName: Idifier.createUniqueIDString(),
        );

        avModel = avModel!.copyWith(
          width: _dims?.width,
          height: _dims?.height,
        );

      }

    }

  }
  // --------------------
  /// TASK_DO_ME
  Future<AvModel?> export() async {
    return null;
  }
  // --------------------------------------------------------------------------

  /// STEPS

  // --------------------
  ///
  Future<void> _crop({
    required Future<AvModel> Function(AvModel tempModel)? onCrop,
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
  ///
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
          avModel = await AvModelEditor.overrideBytes(
            bytes: bytes,
            newDims: Dimensions(width: resizeToWidth, height: _resizeToHeight),
          );
        }

      }

    }

    else {
      blog('could not resize image');
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

        },
        onError: (String error) async {

        },
      );

    }

    else {
      blog('could not compress image');
    }

  }
  // --------------------------------------------------------------------------
}
