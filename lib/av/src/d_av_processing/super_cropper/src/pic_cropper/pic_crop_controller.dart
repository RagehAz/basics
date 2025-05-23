part of super_cropper;
/// => TAMAM
class AvCropController {
  // -----------------------------------------------------------------------------
  final Wire<AvModel?> originalPic = Wire<AvModel?>(null);
  final Wire<AvModel?> theCroppedPic = Wire<AvModel?>(null);
  final Wire<bool> isCropping = Wire<bool>(false);
  final Wire<Rect> croppedRect = Wire<Rect>(Rect.zero);
  final Wire<Rect> currentRect = Wire<Rect>(Rect.zero);
  final Wire<double> viewWidth = Wire<double>(0);
  final Wire<double> viewHeight = Wire<double>(0);
  bool mounted = true;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void setPicAndRect({
    required AvModel? theOriginalPic,
    required Rect theCropRect,
    required double theViewWidth,
    required double theViewHeight,
    required double? aspectRatio, /// MAKE CROPPER USE A PREDEFINED ASPECT RATIO IN BASICS
  }){
    setNotifier(notifier: originalPic, mounted: mounted, value: theOriginalPic);
    setNotifier(notifier: currentRect, mounted: mounted, value: theCropRect);
    setNotifier(notifier: viewWidth, mounted: mounted, value: theViewWidth);
    setNotifier(notifier: viewHeight, mounted: mounted, value: theViewHeight);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    mounted = false;
    originalPic.dispose();
    theCroppedPic.dispose();
    currentRect.dispose();
    croppedRect.dispose();
    isCropping.dispose();
    viewWidth.dispose();
    viewHeight.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeMultiple({
    required List<AvCropController> controllers,
  }){
    if (Lister.checkCanLoop(controllers) == true){
      for (final AvCropController controller in controllers){
        controller.dispose();
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// CROP

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<AvModel?> cropPic() async {
    AvModel? _output = originalPic.value;

    if (mounted == true && originalPic.value != null){

      final Uint8List? _bytes = await _output?.getBytes();

      final bool _isDecodable = Decoding.checkImageIsDecodable(
        bytes: _bytes,
      );

      if (_isDecodable == true){

        isCropping.set(value: true, mounted: mounted);
        croppedRect.set(value: currentRect.value, mounted: mounted);

        final Uint8List? _cropped = await _cropBytes(
          bytes: _bytes,
          cropRect: croppedRect.value,
          viewWidth: viewWidth.value,
          imageWidth: originalPic.value!.getDimensions()!.width!,
        );

        if (mounted == true){

          _output = await _output?.replaceBytes(
            bytes: _cropped,
            newDims: null,
          );

          theCroppedPic.set(value: _output, mounted: mounted);
          isCropping.set(value: false, mounted: mounted);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _cropBytes({
    required Uint8List? bytes,
    required double imageWidth,
    required double viewWidth,
    required Rect? cropRect,
  }) async {
    Uint8List? _output;

    if (cropRect != null && bytes != null){

      final ui.Image? _image = await Imager.getUiImageFromBytes(bytes);

      if (_image != null){

        await tryAndCatch(
          invoker: 'cropImage',
          functions: () async {

            final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
            final ui.Canvas canvas = ui.Canvas(pictureRecorder);

            final Rect _areaToCropOnImage = _scaleRect(
              imageWidth: imageWidth,
              viewCropRect: cropRect,
              viewWidth: viewWidth,
            );

            canvas.drawImageRect(
              _image,
              _areaToCropOnImage,
              Rect.fromLTWH(0, 0, _areaToCropOnImage.width, _areaToCropOnImage.height),
              ui.Paint(),
            );


            final ui.Image croppedImage = await pictureRecorder
                .endRecording()
                .toImage(_areaToCropOnImage.width.toInt(), _areaToCropOnImage.height.toInt());

            _output = await Byter.fromUiImage(croppedImage);

          },
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Rect _scaleRect({
    required double imageWidth,
    required double viewWidth,
    required Rect viewCropRect,
  }){

    /// assuming we scaled down the image
    /// viewWidth * scalingFactor = imageWidth
    /// scalingFactor = imageWidth / viewWidth
    final double scalingFactor = imageWidth / viewWidth;

    return Rect.fromLTWH(
      viewCropRect.left * scalingFactor,
      viewCropRect.top * scalingFactor,
      viewCropRect.width * scalingFactor,
      viewCropRect.height * scalingFactor,
    );

  }
  // -----------------------------------------------------------------------------

  /// SCALING BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions scaleCroppedDimensionsToFit({
    required Dimensions? croppedImageDimensions,
  }){

    final double _cropWidth = croppedRect.value.width;

    final Dimensions? _croppedImageDims = croppedImageDimensions;
    final double _croppedImageWidth = _croppedImageDims?.width ?? 1;
    final double _croppedImageHeight = _croppedImageDims?.height ?? 1;

    final double scaleFactor = _cropWidth / _croppedImageWidth;
    final double _width = _croppedImageWidth * scaleFactor;
    final double _height = _croppedImageHeight * scaleFactor;

    return Dimensions(
      width: _width,
      height: _height,
    );
  }
  // -----------------------------------------------------------------------------

  /// CANVAS SCALING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions getImageDimsFitToCanvas({
    required Dimensions? canvasDims,
    required Dimensions? imageDims,
  }){
    Dimensions _output = Dimensions.zero;

    if (canvasDims?.width != null && canvasDims?.height != null && imageDims?.width != null && imageDims?.height != null){

      /// FITTING WIDTH
      if (Numeric.isLesserThanOrEqual(number: imageDims?.getHeightForWidth(width: canvasDims?.width), isLesserThan: canvasDims?.height)){
        _output = Dimensions(
          width: canvasDims!.width,
          height: imageDims!.getHeightForWidth(width: canvasDims.width),
        );
      }

      /// FITTING HEIGHT
      if (Numeric.isLesserThanOrEqual(number: imageDims?.getWidthForHeight(height: canvasDims?.height), isLesserThan: canvasDims?.width)){
        _output = Dimensions(
          width: imageDims!.getWidthForHeight(height: canvasDims!.height),
          height: canvasDims.height,
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
