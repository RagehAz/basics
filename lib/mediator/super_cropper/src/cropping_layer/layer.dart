part of super_cropper;

class CroppingLayer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const CroppingLayer({
    required this.width,
    required this.height,
    this.radius = 0,
    this.initialRect,
    this.initialSize,
    this.aspectRatio,
    this.onMoved,
    this.onStarted,
    this.maskColor = Colorz.black80,
    this.child,
    this.image,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final double radius;
  final double? initialSize;
  final Rect? initialRect;
  final double? aspectRatio;
  final Function(Rect rect)? onMoved;
  final Function(Rect rect)? onStarted;
  final Color maskColor;
  final Widget? child;
  final dynamic image;
  // --------------------
  @override
  _CroppingLayerState createState() => _CroppingLayerState();
  // --------------------------------------------------------------------------
}

class _CroppingLayerState extends State<CroppingLayer> {
  // --------------------
  double dotTotalSize = 32;
  // --------------------
  late Rect _rect;
  late Rect _maxRect;
  // --------------------
  final  bool _isFitVertically = false;
  // --------------------
  set rect(Rect newRect) {
    setState(() {
      _rect = newRect;
    });
    widget.onMoved?.call(_rect);
  }
  // --------------------
  Rect get rect => _rect;
  // --------------------
  _Calculator get calculator => _isFitVertically ?
  const _VerticalCalculator()
      :
  const _HorizontalCalculator();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initializeRect();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {
        widget.onStarted?.call(_rect);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(CroppingLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
        oldWidget.aspectRatio != widget.aspectRatio
        || oldWidget.initialSize != widget.initialSize
        || oldWidget.initialRect != widget.initialRect
        || oldWidget.width != widget.width
        || oldWidget.height != widget.height
        || oldWidget.maskColor != widget.maskColor
        || Imager.checkImagesAreIdentical(oldWidget.image, widget.image) == false
    ) {

      setState(() {
        _initializeRect();
      });

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeRect(){
    _maxRect = Rect.fromLTRB(0, 0, widget.width, widget.height);
    _rect = widget.initialRect ?? _getRectByScale();
  }
  // --------------------
  /*
  Rect _getInitialRect(){

    // print('LAYER : _getInitialRect : widget.initialRect : ${widget.initialRect}');

    if (_rect == null){
      return _getRectByScale();
    }

    else {
      return _rect;
    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  Rect _getRectByScale(){

    // blog('getting rect by scaleeeee');

    final double _scale = widget.initialSize ?? 0.7;

    final Dimensions _fillBox = getMaxCropBoxRespectingAspectRatio(
      imageDims: Dimensions(
        width: widget.width,
        height: widget.height,
      ),
      cropAspectRatio: widget.aspectRatio ?? 1,
    );

    // final double _fillXSub = widget.width * _scale;
    // final double _fillYSub = widget.aspectRatio == null ? widget.height * _scale : _fillXSub / widget.aspectRatio!;

    final double _fillX = _fillBox.width! * _scale;
    final double _fillY = _fillBox.height! * _scale;

    final double _totalMarginX = widget.width - _fillX;
    final double _totalMarginY = widget.height - _fillY;

    final double _left = _totalMarginX / 2;
    final double _right = widget.width - _left;
    final double _top = _totalMarginY / 2;
    final double _bottom = widget.height - _top;

    return Rect.fromLTRB(_left, _top, _right, _bottom);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions getMaxCropBoxRespectingAspectRatio({
    required Dimensions imageDims,
    required double cropAspectRatio,
  }){

    // aspectRatio = width / height

    /// RESPECT WIDTH
    final double _heightWhenFitWidth = imageDims.width! / cropAspectRatio;
    final bool _respectWidth = _heightWhenFitWidth <=  imageDims.height!;

    /// RESPECT HEIGHT
    final double _widthOnFitHeight = cropAspectRatio * imageDims.height!;
    final bool _respectHeight = _widthOnFitHeight <= imageDims.width!;

    if (_respectWidth == true){
      return Dimensions(
          width: imageDims.width,
          height: _heightWhenFitWidth
      );
    }

    else if (_respectHeight == true){
      return Dimensions(
          width: _widthOnFitHeight,
          height: imageDims.height
      );
    }

    else {
      return Dimensions.zero;
    }

  }
  // --------------------
  /*
  Rect _getRectFromInitialRect(){

    final double _initialRectAspectRatio = widget.initialRect!.width / widget.initialRect!.height;

    if (widget.initialRect == null){
      return _getRectByScale();
    }

    // else if (widget.aspectRatio == null){
    //   return widget.initialRect!;
    // }

    else if (widget.aspectRatio != _initialRectAspectRatio){

      final double _fillX = widget.initialRect!.width;
      final double _fillY = _fillX / widget.aspectRatio!;

      final double _totalMarginX = widget.width - _fillX;
      final double _totalMarginY = widget.height - _fillY;

      final double _left = _totalMarginX / 2;
      final double _right = widget.width - _left;

      final double _top = _totalMarginY / 2;
      final double _bottom = widget.height - _top;

      return Rect.fromLTRB(_left, _top, _right, _bottom);

    }

    else {
      return widget.initialRect!;
    }

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[

          /// CHILD
          if (widget.child != null)
          widget.child!,

          /// IMAGE
          if (widget.image != null)
            SuperImage(
              width: widget.width,
              height: widget.height,
              pic: widget.image,
              loading: false,
            ),

          /// CLIPPED LAYER
          IgnorePointer(
            child: ClipPath(
              clipper: _CropAreaClipper(_rect, widget.radius),
              child: Container(
                  width: widget.width,
                  height: widget.height,
                  color: widget.maskColor,
              ),
            ),
          ),

          /// MOVING LAYER
          Positioned(
            left: _rect.left,
            top: _rect.top,
            child: GestureDetector(
              onPanUpdate: (details) {
                rect = calculator.moveRect(
                  _rect,
                  details.delta.dx,
                  details.delta.dy,
                  _maxRect,
                );
              },
              child: Container(
                width: _rect.width,
                height: _rect.height,
                color: Colors.transparent,
              ),
            ),
          ),

          /// TOP LEFT
          Positioned(
            left: _rect.left - (dotTotalSize / 2),
            top: _rect.top - (dotTotalSize / 2),
            child: GestureDetector(
              onPanUpdate: (details) {
                rect = calculator.moveTopLeft(
                  _rect,
                  details.delta.dx,
                  details.delta.dy,
                  _maxRect,
                  widget.aspectRatio,
                );
              },
              child: const CropperCorner(),
            ),
          ),

          /// TOP RIGHT
          Positioned(
            left: _rect.right - (dotTotalSize / 2),
            top: _rect.top - (dotTotalSize / 2),
            child: GestureDetector(
              onPanUpdate: (details) {
                rect = calculator.moveTopRight(
                  _rect,
                  details.delta.dx,
                  details.delta.dy,
                  _maxRect,
                  widget.aspectRatio,
                );
              },
              child: const CropperCorner(),
            ),
          ),

          /// BOTTOM LEFT
          Positioned(
            left: _rect.left - (dotTotalSize / 2),
            top: _rect.bottom - (dotTotalSize / 2),
            child: GestureDetector(
              onPanUpdate: (details) {
                rect = calculator.moveBottomLeft(
                  _rect,
                  details.delta.dx,
                  details.delta.dy,
                  _maxRect,
                  widget.aspectRatio,
                );
              },
              child: const CropperCorner(),
            ),
          ),

          /// BOTTOM RIGHT
          Positioned(
            left: _rect.right - (dotTotalSize / 2),
            top: _rect.bottom - (dotTotalSize / 2),
            child: GestureDetector(
              onPanUpdate: (details) {
                rect = calculator.moveBottomRight(
                  _rect,
                  details.delta.dx,
                  details.delta.dy,
                  _maxRect,
                  widget.aspectRatio,
                );
              },
              child: const CropperCorner(),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
