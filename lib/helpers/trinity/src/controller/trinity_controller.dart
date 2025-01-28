part of trinity;

class TrinityController {
  // --------------------------------------------------------------------------
  bool mounted = false;
  double viewWidth = 0;
  double viewHeight = 0;
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  void init({
    required double viewWidth,
    required double viewHeight,
    Matrix4? viewMatrix,
    Matrix4? normalMatrix,
    bool shouldTranslate = true,
    bool shouldScale = true,
    bool shouldRotate = true,
    Alignment? focalPointAlignment,
  }){

    this.viewWidth = viewWidth;
    this.viewHeight = viewHeight;
    
    _initMatrix(
      viewMatrix: viewMatrix,
      normalMatrix: normalMatrix,
    );

    this.focalPointAlignment = focalPointAlignment;
    canMove.set(value: shouldTranslate);
    canScale.set(value: shouldScale);
    canRotate.set(value: shouldRotate);

    _oldTranslation = Offset.zero;
    _newTranslation = Offset.zero;
    _oldScale = 1;
    _newScale = 1;
    _oldRotation = 0;
    _newRotation = 0;

    mounted = true;
  }
  // --------------------
  void _initMatrix({
    required Matrix4? viewMatrix,
    required Matrix4? normalMatrix,
  }){

    Matrix4? _initialViewMatrix = viewMatrix;

    _initialViewMatrix ??= NeoRender.toView(
      normalMatrix: normalMatrix,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );

    _initialViewMatrix ??= Matrix4.identity();

    this.viewMatrix.set(value: _initialViewMatrix, mounted: mounted);
    initialViewMatrix.set(value: _initialViewMatrix, mounted: mounted);

  }
  // --------------------
  void reInit({
    double? viewWidth,
    double? viewHeight,
    Matrix4? viewMatrix,
    Matrix4? normalMatrix,
    bool? shouldTranslate,
    bool? shouldScale,
    bool? shouldRotate,
    Alignment? focalPointAlignment,
  }){
    if (mounted == true){

      this.viewWidth = viewWidth ?? this.viewWidth;
      this.viewHeight = viewHeight ?? this.viewHeight;

      _initMatrix(
        viewMatrix: viewMatrix,
        normalMatrix: normalMatrix,
      );

      if (focalPointAlignment != null){
        this.focalPointAlignment = focalPointAlignment;
      }

      if (shouldTranslate != null){
        canMove.set(value: shouldTranslate, mounted: mounted);
      }
      if (shouldScale != null){
        canScale.set(value: shouldScale, mounted: mounted);
      }
      if (shouldRotate != null){
        canRotate.set(value: shouldRotate, mounted: mounted);
      }

      _oldTranslation = NeoMove.getOffset(this.viewMatrix.value) ?? Offset.zero;
      _newTranslation = _oldTranslation;
      _oldScale = NeoScale.getXScale(this.viewMatrix.value) ?? 1;
      _newScale = _oldScale;
      _oldRotation = NeoRotate.getRotationInRadians(this.viewMatrix.value) ?? 0;
      _newRotation = _oldRotation;

      // _oldTranslation = Offset.zero;
      // _newTranslation = Offset.zero;
      // _oldScale = 1;
      // _newScale = 1;
      // _oldRotation = 0;
      // _newRotation = 0;

    }
  }
  // --------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  ///
  void dispose(){
    mounted = false;
    viewMatrix.dispose();
    initialViewMatrix.dispose();
    focalPoint.dispose();
    canMove.dispose();
    canScale.dispose();
    canRotate.dispose();
  }
  // --------------------------------------------------------------------------

  /// MATRIX

  // --------------------
  final Wire<Matrix4> viewMatrix = Wire<Matrix4>(Matrix4.identity());
  // --------------------
  void setViewMatrix(Matrix4? newMatrix){
    if (newMatrix != null){
      viewMatrix.set(value: newMatrix, mounted: mounted);
    }
  }
  // --------------------------------------------------------------------------

  /// INITIAL MATRIX

  // --------------------
  final Wire<Matrix4> initialViewMatrix = Wire<Matrix4>(Matrix4.identity());
  // --------------------
  void setInitialViewMatrix(Matrix4? newMatrix){
    if (newMatrix != null){
      initialViewMatrix.set(value: newMatrix, mounted: mounted);
    }
  }
  // --------------------------------------------------------------------------

  /// CAN MOVE

  // --------------------
  final Wire<bool> canMove = Wire<bool>(true);
  // --------------------
  void setCanMove(bool value){
    canMove.set(value: value, mounted: mounted);
  }
  // --------------------------------------------------------------------------

  /// CAN SCALE

  // --------------------
  final Wire<bool> canScale = Wire<bool>(true);
  // --------------------
  void setCanScale(bool value){
    canScale.set(value: value, mounted: mounted);
  }
  // --------------------------------------------------------------------------

  /// CAN ROTATE

  // --------------------
  final Wire<bool> canRotate = Wire<bool>(false);
  // --------------------
  void setCanRotate(bool value){
    canRotate.set(value: value, mounted: mounted);
  }
  // --------------------------------------------------------------------------

  /// FOCAL POINT ALIGNMENT

  // --------------------
  Alignment? focalPointAlignment;
  // --------------------
  void setFocalPointAlignment(Alignment value){
    if (mounted == true && value != focalPointAlignment){
      focalPointAlignment = value;
    }
  }
  // --------------------------------------------------------------------------

  /// FOCAL POINT

  // --------------------
  final Wire<Offset> focalPoint = Wire<Offset>(Offset.zero);
  // --------------------
  void setFocalPoint(Offset point){
    focalPoint.set(value: point, mounted: mounted);
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  Offset _oldTranslation = Offset.zero;
  Offset _newTranslation = Offset.zero;
  // --------------------
  Matrix4 _updateTheTranslation({
    required Offset newFocalPoint,
    required Matrix4 input,
    required bool canMove,
  }){
    Matrix4 _output = input;
    if (canMove) {
      _newTranslation = newFocalPoint - _oldTranslation;
      _oldTranslation = newFocalPoint;
      _output = NeoMove.createDelta(translation: _newTranslation) * _output;
    }
    return _output;
  }
  // --------------------------------------------------------------------------

  /// SCALE

  // --------------------
  double _oldScale = 1;
  double _newScale = 1;
  // --------------------
  Matrix4 _updateTheScale({
    required Matrix4 input,
    required double newScale,
    required Offset point,
    required bool canScale,
  }){
    Matrix4 _output = input;
    if (canScale && newScale != 1.0) {
      _newScale = newScale / _oldScale;
      _oldScale = newScale;
      _output = NeoScale.createDelta(scale: _newScale, focalPoint: point) * _output;
    }
    return _output;
  }
  // --------------------------------------------------------------------------

  /// ROTATION

  // --------------------
  double _oldRotation = 0;
  double _newRotation = 0;
  // --------------------
  Matrix4 _updateTheRotation({
    required double newRotation,
    required Offset point,
    required Matrix4 input,
    required bool canRotate,
  }){
    Matrix4 _output = input;

    if (canRotate && newRotation != 0.0) {

      if (_oldRotation.isNaN == true) {
        _oldRotation = newRotation;
      }

      else {
        _newRotation = newRotation - _oldRotation;
        _oldRotation = newRotation;
        _output = NeoRotate.createDelta(angle: _newRotation, focalPoint: point) * _output;
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FOCAL POINT

  // --------------------
  /// TESTED : WORKS PERFECT
  Offset _cureFocalPoint(BuildContext context, Offset givenPoint){

    if (focalPointAlignment != null && context.size != null) {
      return focalPointAlignment!.alongSize(context.size!);
    }

    else {

      final RenderObject? renderObject = context.findRenderObject();

      if (renderObject == null) {
        return Offset.zero;
      }

      else {
        final RenderBox renderBox = renderObject as RenderBox;
        return renderBox.globalToLocal(givenPoint);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// ON GESTURES

  // --------------------
  /// TESTED : WORKS PERFECT
  void onScaleStart(ScaleStartDetails details) {
    _oldTranslation = details.focalPoint;
    _oldScale = 1.0;
    _oldRotation = 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onScaleUpdate({
    required ScaleUpdateDetails details,
    required BuildContext context,
    required Function(Matrix4 matrix)? onViewMatrixUpdate,
    required bool canRotate,
    required bool canMove,
    required bool canScale,
  }) {

    /// TRANSLATION
    Matrix4 _newViewMatrix = _updateTheTranslation(
      input: viewMatrix.value,
      newFocalPoint: details.focalPoint,
      canMove: canMove,
    );

    final Offset _point = _cureFocalPoint(context, details.focalPoint);
    setFocalPoint(_point);

    /// SCALING
    _newViewMatrix = _updateTheScale(
      newScale: details.scale,
      point: _point,
      input: _newViewMatrix,
      canScale: canScale,
    );

    /// ROTATION
    _newViewMatrix = _updateTheRotation(
      newRotation: details.rotation,
      point: _point,
      input: _newViewMatrix,
      canRotate: canRotate,
    );

    /// SET MATRIX
    setViewMatrix(_newViewMatrix);

    /// CALL BACK
    onViewMatrixUpdate?.call(_newViewMatrix);
    
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  Matrix4 getDeadNormalMatrix(){
    return NeoRender.toNormal(
      viewMatrix: viewMatrix.value,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    )!;
  }
  // --------------------
  Matrix4? getDeadViewMatrix(){
    return viewMatrix.value;
  }
  // --------------------------------------------------------------------------
}
