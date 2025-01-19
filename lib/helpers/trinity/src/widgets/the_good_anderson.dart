part of trinity;

class GoodAnderson extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GoodAnderson({
    required this.onMatrixUpdate,
    required this.child,
    this.initialMatrix,
    this.shouldTranslate = true,
    this.shouldScale = true,
    this.shouldRotate = true,
    this.clipChild = true,
    this.focalPointAlignment,
    Key? key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final MatrixGestureDetectorCallback onMatrixUpdate;
  final Widget child;
  final Matrix4? initialMatrix;
  final bool shouldTranslate;
  final bool shouldScale;
  final bool shouldRotate;
  final bool clipChild;
  final Alignment? focalPointAlignment;
  /// --------------------------------------------------------------------------
  @override
  _GoodAndersonState createState() => _GoodAndersonState();
  /// --------------------------------------------------------------------------
}

class _GoodAndersonState extends State<GoodAnderson> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initialize();

  }
  // -----------------------------------------------------------------------------
  @override
  void didUpdateWidget(GoodAnderson oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool _identical = Trinity.checkMatrixesAreIdentical(
        matrix1: oldWidget.initialMatrix,
        matrixReloaded: widget.initialMatrix,
    );
    blog('identical : $_identical');

    if (_identical == false) {

      setState(() {

        // final double _radians = NeoRotate.getRotationInRadians(widget.initialMatrix)!;
        // if (_radians != _oldRotation){
          _oldRotation = 0;
          _newRotation = 0; //_radians;
        // }

        // final double _scale = NeoScale.getXScale(widget.initialMatrix)!;
        // if (_scale != _oldScale){
          _oldScale = 1;
          _newScale = 1; //_scale;
        // }

        // final Offset _offset = NeoMove.getOffset(widget.initialMatrix)!;
        // if (_offset != _oldTranslation){
          _oldTranslation = Offset.zero;
          _newTranslation = Offset.zero; //_offset;
        // }

        matrix = widget.initialMatrix!;
        blog('enta ebn metnaka ? 𓀀');

      });

    }

  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  Matrix4 matrix = Matrix4.identity();
  // --------------------
  void _initialize(){

    if (widget.initialMatrix != null) {

      matrix = widget.initialMatrix!;

      final Offset initialTranslation = Offset(matrix.storage[12], matrix.storage[13]);
      _oldTranslation = initialTranslation;

    }
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  Offset _oldTranslation = Offset.zero;
  Offset _newTranslation = Offset.zero;
  // --------------------
  void _updateTheTranslation(Offset newValue){
    if (widget.shouldTranslate) {
      _newTranslation = newValue - _oldTranslation;
      _oldTranslation = newValue;
      matrix = _getTranslationDelta(_newTranslation) * matrix;
    }
  }
  // --------------------
  Matrix4 _getTranslationDelta(Offset translation) {
    final double dx = translation.dx;
    final double dy = translation.dy;

    // blog('_translate : (x $dx: y $dy)');

    //  ..[0]  = 1       # x scale
    //  ..[5]  = 1       # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------------------------------------------------------------

  /// SCALE

  // --------------------
  double _oldScale = 1;
  double _newScale = 1;
  // --------------------
  void _updateTheScale(double newScale, Offset focalPoint){
    if (widget.shouldScale && newScale != 1.0) {
      _newScale = newScale / _oldScale;
      _oldScale = newScale;
      final Offset _point = _cureFocalPoint(focalPoint);
      matrix = _getScaleDelta(_newScale, _point) * matrix;
    }
  }
  // --------------------
  Matrix4 _getScaleDelta(double scale, Offset point) {
    final double dx = (1 - scale) * point.dx;
    final double dy = (1 - scale) * point.dy;

    //  ..[0]  = scale   # x scale
    //  ..[5]  = scale   # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------------------------------------------------------------

  /// ROTATION

  // --------------------
  double _oldRotation = 0;
  double _newRotation = 0;
  // --------------------
  void _updateTheRotation(double newRotation, Offset focalPoint){

    if (widget.shouldRotate && newRotation != 0.0) {

      if (_oldRotation.isNaN == true) {
        _oldRotation = newRotation;
      }

      else {
        _newRotation = newRotation - _oldRotation;
        _oldRotation = newRotation;
        final Offset _point = _cureFocalPoint(focalPoint);
        matrix = _getRotationDelta(_newRotation, _point) * matrix;
      }

    }

  }
  // --------------------
  Matrix4 _getRotationDelta(double angle, Offset point) {
    final double c = cos(angle);
    final double s = sin(angle);
    final double dx = (1 - c) * point.dx + s * point.dy;
    final double dy = (1 - c) * point.dy - s * point.dx;

    //  ..[0]  = c       # x scale
    //  ..[1]  = s       # y skew
    //  ..[4]  = -s      # x skew
    //  ..[5]  = c       # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(c, s, 0, 0, -s, c, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------------------------------------------------------------

  /// FOCAL POINT

  // --------------------
  Offset _cureFocalPoint(Offset givenPoint){
    Offset focalPoint = Offset.zero;

    if (widget.focalPointAlignment != null && context.size != null) {
      focalPoint = widget.focalPointAlignment!.alongSize(context.size!);
    }

    else {

      final RenderObject? renderObject = context.findRenderObject();

      if (renderObject != null) {
        final RenderBox renderBox = renderObject as RenderBox;
        focalPoint = renderBox.globalToLocal(givenPoint);
      }

    }

    return focalPoint;
  }
  // -----------------------------------------------------------------------------

  /// ON GESTURES

  // --------------------
  void onScaleStart(ScaleStartDetails details) {
    _oldTranslation = details.focalPoint;
    _oldScale = 1.0;
    _oldRotation = 0;
  }
  // --------------------
  void onScaleUpdate(ScaleUpdateDetails details) {

    /// TRANSLATION
    _updateTheTranslation(details.focalPoint);

    /// SCALING
    _updateTheScale(details.scale, details.focalPoint);

    /// ROTATION
    _updateTheRotation(details.rotation, details.focalPoint);

    /// CALL BACK
    widget.onMatrixUpdate(matrix, Matrix4.identity(), Matrix4.identity(), Matrix4.identity());

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (
        widget.shouldRotate == false
        &&
        widget.shouldScale == false
        &&
        widget.shouldTranslate == false
    ){
      return widget.child;
    }

    else {
      return GestureDetector(
        onScaleStart: onScaleStart,
        onScaleUpdate: onScaleUpdate,
        child: widget.clipChild ? ClipRect(child: widget.child) : widget.child,
      );
    }

  }
// -----------------------------------------------------------------------------
}
