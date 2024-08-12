part of pixel_color_picker;

class ColorPickerController {
  // -----------------------------------------------------------------------------

  /// VARIABLES

  // --------------------
  final Wire<Color?> color = Wire<Color?>(null);
  final Wire<Offset> offset = Wire<Offset>(Offset.zero);
  final Wire<img.Image?> photo = Wire<img.Image?>(null);
  final Wire<Uint8List?> bytes = Wire<Uint8List?>(null);
  final Wire<bool> isPicking = Wire<bool>(false);
  final Wire<bool> indicatorIsVisible = Wire<bool>(false);
  final Wire<bool> loading = Wire<bool>(false);
  GlobalKey paintKey = GlobalKey();
  // --------------------
  void dispose(){
    color.clear();
    offset.clear();
    photo.clear();
    bytes.clear();
    isPicking.clear();
    indicatorIsVisible.clear();
    loading.clear();
  }
  // --------------------
  /*
  void _onDidUpdateWidget({
    required PixelColorPicker oldWidget,
    required PixelColorPicker newWidget,
    required bool mounted,
    required BuildContext context,
  }){

    // if (widget.child != oldWidget.child){
    //   blog('-pixel picker : child changed');
    // }
    // if (widget.initialColor != oldWidget.initialColor){
    //   blog('-pixel picker : initialColor changed');
    // }
    // if (widget.onColorChanged != oldWidget.onColorChanged){
    //   blog('-pixel picker : onColorChanged changed');
    // }
    // if (widget.child.key != oldWidget.child.key){
    //   blog('-pixel picker : child keys changed');
    // }

    if (
          newWidget.child.key != oldWidget.child.key
        || newWidget.initialColor != oldWidget.initialColor
        || newWidget.indicatorSize != oldWidget.indicatorSize
        || newWidget.showIndicator != oldWidget.showIndicator
        || newWidget.showCrossHair != oldWidget.showCrossHair
    // || widget.onColorChanged != oldWidget.onColorChanged
    ) {

      Future.delayed(const Duration(milliseconds: 100), () {
        photo.set(value: null, mounted: mounted);
        awaiter(
          wait: false,
          function: () => snapshotWidgetTree(
            // context: context,
            mounted: mounted,
          ),
        );
      });

    }

  }
   */
  // -----------------------------------------------------------------------------

  /// SCREENSHOT

  // --------------------
  Future<Uint8List?> snapshotWidgetTree({
    required bool mounted,
    // required BuildContext context,
  }) async {
    Uint8List? _output;

    await Future.delayed(const Duration(milliseconds: 500));

    if (photo.value == null){

      if (mounted){

        loading.set(value: true, mounted: mounted);

        _output = await Pixelizer.snapshotWidget(
          key: paintKey,
        );

        if (_output != null){

          final bool _identical = Byter.checkBytesAreIdentical(
            bytes1: _output,
            bytes2: bytes.value,
          );

          if (_identical == false){
            bytes.set(mounted: mounted, value: _output);
            photo.set(value: img.decodeImage(_output), mounted: mounted);
          }

        }

        loading.set(value: false, mounted: mounted);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COLOR CALCULATION

  // --------------------
  Future<Color?> _calculatePixel({
    required Offset? globalPosition,
    required bool autoHideIndicator,
    required bool mounted,
    required BuildContext context,
    Function? onColorChanged,
  }) async {
    Color? _color;

    indicatorIsVisible.set(value: true, mounted: mounted);

    // if (photo.value == null) {
    //   await snapshotWidgetTree(
    //     mounted: mounted,
    //     // context: context,
    //   );
    // }

    final img.Pixel? _pixel = Pixelizer.getPixelFromGlobalPosition(
      key: paintKey,
      image: photo.value,
      globalPosition: globalPosition,
      scaleToImage: true,
    );

    if (_pixel != null){

      offset.set(
        value: Offset(_pixel.x.toDouble(), _pixel.y.toDouble()),
        mounted: mounted,
      );

      _color = Pixelizer.getPixelColor(pixel: _pixel);

      onColorChanged?.call(_color);

      if (_color != null){
        color.set(value: _color, mounted: mounted);
      }

    }

    if (autoHideIndicator == true){
      await awaiter(
        wait: true,
        function: () => _hideIndicator(mounted: mounted),
      );
    }

    return _color;
  }
  // --------------------
  Future<void> _hideIndicator({
    required bool mounted,
  }) async {
    await Future.delayed(const Duration(seconds: 1), () {
      indicatorIsVisible.set(value: false, mounted: mounted);
    });
  }
  // -----------------------------------------------------------------------------

  /// GESTURES

  // --------------------
  Future<void> _onPanUpdate({
    required Offset? globalPosition,
    required BuildContext context,
    required bool mounted,
    required Function? onColorChanged,
  }) async {
    await _calculatePixel(
      globalPosition: globalPosition,
      autoHideIndicator: false,
      context: context,
      mounted: mounted,
      onColorChanged: onColorChanged,
    );
  }
  // --------------------
  Future<void> _onPanEnd({
    required Offset? globalPosition,
    required BuildContext context,
    required bool mounted,
    Function(Color? color)? onColorChangeEnded,
  }) async {

    await _calculatePixel(
      globalPosition: globalPosition,
      autoHideIndicator: true,
      context: context,
      mounted: mounted,
      onColorChanged: onColorChangeEnded,
    );

  }
  // -----------------------------------------------------------------------------
}
