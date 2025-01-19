part of trinity;

class OldAnderson extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OldAnderson({
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
  _OldAndersonState createState() => _OldAndersonState();
  /// --------------------------------------------------------------------------
  // static Matrix4 compose(
  //     Matrix4? matrix,
  //     Matrix4? translationMatrix,
  //     Matrix4? scaleMatrix,
  //     Matrix4? rotationMatrix,
  //     ) {
  //   Matrix4 _output = matrix ?? Matrix4.identity();
  //
  //   if (translationMatrix != null){
  //     _output = translationMatrix * _output;
  //   }
  //
  //   if (scaleMatrix != null){
  //     _output = scaleMatrix * _output;
  //   }
  //
  //   if (rotationMatrix != null){
  //     _output = rotationMatrix * _output;
  //   }
  //
  //   return _output;
  // }
  // /// --------------------------------------------------------------------------
  // static MatrixDecomposedValues decomposeToValues(Matrix4 matrix) {
  //   final List<double> array = matrix.applyToVector3Array([0, 0, 0, 1, 0, 0]);
  //   final Offset translation = Offset(array[0], array[1]);
  //   final Offset delta = Offset(array[3] - array[0], array[4] - array[1]);
  //   final double scale = delta.distance;
  //   final double rotation = delta.direction;
  //   return MatrixDecomposedValues(translation, scale, rotation);
  // }
  /// --------------------------------------------------------------------------
}

class _OldAndersonState extends State<OldAnderson> {
  // -----------------------------------------------------------------------------
  // Matrix4 translationDeltaMatrix = Matrix4.identity();
  Matrix4 scaleDeltaMatrix = Matrix4.identity();
  Matrix4 rotationDeltaMatrix = Matrix4.identity();
  Matrix4 matrix = Matrix4.identity();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initialize();

  }
  // -----------------------------------------------------------------------------
  @override
  void didUpdateWidget(OldAnderson oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.key != widget.key) {
    //   setState(() {
    //     _initialize();
    //   });
    // }

    // if (oldWidget.initialMatrix != widget.initialMatrix) {
    //   setState(() {
    //     _initialize();
    //   });
    // }

  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  void _initialize(){

    if (widget.initialMatrix != null) {

      // translationDeltaMatrix = Matrix4.identity();
      // scaleDeltaMatrix = Matrix4.identity();
      // rotationDeltaMatrix = Matrix4.identity();
      matrix = widget.initialMatrix!;

      // Trinity.blogMatrix(
      //   matrix: matrix,
      //   roundDigits: 5,
      // );

      final Offset initialTranslation = Offset(matrix.storage[12], matrix.storage[13]);
      translationUpdater.value = initialTranslation;

    }
  }
  // -----------------------------------------------------------------------------

  /// VALUE UPDATERS

  // --------------------
  _ValueUpdater<Offset> translationUpdater = _ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal - (oldVal ?? Offset.zero),
  );
  // --------------------
  _ValueUpdater<double> scaleUpdater = _ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal / (oldVal ?? 1),
  );
  // --------------------
  _ValueUpdater<double> rotationUpdater = _ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal - (oldVal ?? 0),
  );
  // -----------------------------------------------------------------------------

  /// ON SCALING

  // --------------------
  void onScaleStart(ScaleStartDetails details) {
    translationUpdater.value = details.focalPoint;
    scaleUpdater.value = 1.0;
    rotationUpdater.value = double.nan;
  }
  // --------------------
  void onScaleUpdate(ScaleUpdateDetails details) {

    Matrix4 _translationDelta = Matrix4.identity();
    final Matrix4 _scaleDelta = Matrix4.identity();
    final Matrix4 _rotationDelta = Matrix4.identity();

    /// handle matrix translating
    if (widget.shouldTranslate) {
      final Offset translationDelta = translationUpdater.update(details.focalPoint);
      _translationDelta = _translate(translationDelta);
      matrix = _translationDelta * matrix;
    }

    /// adjust focal point
    Offset? focalPoint;
    if (widget.focalPointAlignment != null && context.size != null) {
      focalPoint = widget.focalPointAlignment!.alongSize(context.size!);
    } else {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject != null) {
        final RenderBox renderBox = renderObject as RenderBox;
        focalPoint = renderBox.globalToLocal(details.focalPoint);
      }
    }

    /// handle matrix scaling
    if (widget.shouldScale && details.scale != 1.0 && focalPoint != null) {
      final double scaleDelta = scaleUpdater.update(details.scale);
      scaleDeltaMatrix = _scale(scaleDelta, focalPoint);
      matrix = scaleDeltaMatrix * matrix;
    }

    /// handle matrix rotating
    if (widget.shouldRotate && details.rotation != 0.0) {
      if (rotationUpdater.value == null || rotationUpdater.value!.isNaN) {
        rotationUpdater.value = details.rotation;
      } else {
        if (focalPoint != null) {
          final double rotationDelta = rotationUpdater.update(details.rotation);
          rotationDeltaMatrix = _rotate(rotationDelta, focalPoint);
          matrix = rotationDeltaMatrix * matrix;
        }
      }
    }

    // Trinity.blogMatrix(
    //   matrix: matrix,
    //   roundDigits: 5,
    //   invoker: 'fuck',
    // );

    widget.onMatrixUpdate(matrix, _translationDelta, _scaleDelta, _rotationDelta);
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  Matrix4 _translate(Offset translation) {
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
  // --------------------
  Matrix4 _scale(double scale, Offset focalPoint) {
    final double dx = (1 - scale) * focalPoint.dx;
    final double dy = (1 - scale) * focalPoint.dy;

    //  ..[0]  = scale   # x scale
    //  ..[5]  = scale   # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------
  Matrix4 _rotate(double angle, Offset focalPoint) {
    final double c = cos(angle);
    final double s = sin(angle);
    final double dx = (1 - c) * focalPoint.dx + s * focalPoint.dy;
    final double dy = (1 - c) * focalPoint.dy - s * focalPoint.dx;

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
  // --------------------
  /// Updated onScaleUpdate
  Offset oldMove = Offset.zero;
  Offset newMove = Offset.zero;
  // --------------------
  double oldScale = 1;
  double oldRotation = 0;
  void onNewScaleUpdate(ScaleUpdateDetails details) {

    /// MOVE
    if (widget.shouldTranslate) {

      newMove = details.focalPoint - oldMove;
      oldMove = details.focalPoint;
      // _translationDelta = _translate(translationDelta);
      // matrix = _translationDelta * matrix;
      // Matrix4 _translationDelta = Matrix4.identity();
      // final Offset translationDelta = translationUpdater.update(details.focalPoint);
      // _translationDelta = _translate(translationDelta);
      // matrix = _translationDelta * matrix;
      // final Offset _offset = details.focalPoint - oldMove;
      // oldMove = details.focalPoint ;
      matrix = NeoMove.translate(
        matrix: matrix,
        translation: newMove,
      );
    }

    /// FOCAL POINT
    Offset? focalPoint;
    if (widget.focalPointAlignment != null && context.size != null) {
      focalPoint = widget.focalPointAlignment!.alongSize(context.size!);
    }
    else {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject != null) {
        final RenderBox renderBox = renderObject as RenderBox;
        focalPoint = renderBox.globalToLocal(details.focalPoint);
      }
    }

    /// SCALE
    if (widget.shouldScale && details.scale != 1.0 && focalPoint != null) {
      final double _newScale = details.scale / oldScale;
      oldScale = details.scale;
      matrix = NeoScale.newScale(
        matrix: matrix,
        x: _newScale,
        y: _newScale,
        focalPoint: focalPoint,
      );
    }

    /// ROTATION
    if (widget.shouldRotate && details.rotation != 0.0 && focalPoint != null) {
      final double rotationDelta = details.rotation - oldRotation;
      oldRotation = details.rotation; // Update oldRotation
      matrix = NeoRotate.rotate(
        matrix: matrix,
        radians: rotationDelta,
        focalPoint: focalPoint,
      )!;
    }

    // Trigger the callback with updated matrix data
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
        onScaleUpdate: onNewScaleUpdate, // onScaleUpdate,
        child: widget.clipChild ? ClipRect(child: widget.child) : widget.child,
      );
    }

  }
  // -----------------------------------------------------------------------------
}



class _ValueUpdater<T> {

  _ValueUpdater({required this.onUpdate});

  final _OnUpdate<T> onUpdate;
  T? value;

  T update(T newValue) {
    final T updated = onUpdate(value, newValue);
    value = newValue;
    return updated;
  }
}

class MatrixDecomposedValues {

  MatrixDecomposedValues(this.translation, this.scale, this.rotation);

  final Offset translation;
  final double scale;
  final double rotation;

  @override
  String toString() {
    return 'MatrixDecomposedValues(translation: $translation, scale: ${scale.toStringAsFixed(3)}, rotation: ${rotation.toStringAsFixed(3)})';
  }

}

typedef MatrixGestureDetectorCallback = void Function(
    Matrix4 matrix,
    Matrix4 translationDeltaMatrix,
    Matrix4 scaleDeltaMatrix,
    Matrix4 rotationDeltaMatrix);

typedef _OnUpdate<T> = T Function(T? oldValue, T newValue);
