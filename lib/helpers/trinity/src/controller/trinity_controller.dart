part of trinity;

class TrinityController {
  // --------------------------------------------------------------------------
  bool mounted = false;
  // --------------------------------------------------------------------------

  /// CANVAS DIMS

  // --------------------
  double canvasWidth = 0;
  double canvasHeight = 0;
  final ScrollController scrollController = ScrollController();
  // --------------------------------------------------------------------------

  /// STANDARD MATRICES

  // --------------------
  /// DO_WIDER_CHECKER
  /*
  Matrix4? _coverFitMatrix;
  Matrix4? _mediumFitMatrix;
  final Matrix4? _containedFitMatrix = Matrix4.identity();
   */
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  void init({
    required double canvasWidth,
    required double canvasHeight,
    Matrix4? viewMatrix,
    Matrix4? normalMatrix,
    bool canMoveHorizontal = true,
    bool canMoveVertical = true,
    bool shouldScale = true,
    bool shouldRotate = true,
    Alignment? focalPointAlignment,
  }){

    this.canvasWidth = canvasWidth;
    this.canvasHeight = canvasHeight;
    
    _initMatrix(
      viewMatrix: viewMatrix,
      normalMatrix: normalMatrix,
    );

    this.focalPointAlignment = focalPointAlignment;
    this.canMoveHorizontal.set(value: canMoveHorizontal);
    this.canMoveVertical.set(value: canMoveVertical);
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
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    );

    _initialViewMatrix ??= Matrix4.identity();

    this.viewMatrix.set(value: _initialViewMatrix, mounted: mounted);
    initialViewMatrix.set(value: _initialViewMatrix, mounted: mounted);

  }
  // --------------------
  void reInit({
    double? canvasWidth,
    double? canvasHeight,
    Matrix4? viewMatrix,
    Matrix4? normalMatrix,
    bool? canMoveHorizontal,
    bool? canMoveVertical,
    bool? shouldScale,
    bool? shouldRotate,
    Alignment? focalPointAlignment,
  }){
    if (mounted == true){

      this.canvasWidth = canvasWidth ?? this.canvasWidth;
      this.canvasHeight = canvasHeight ?? this.canvasHeight;

      _initMatrix(
        viewMatrix: viewMatrix,
        normalMatrix: normalMatrix,
      );

      if (focalPointAlignment != null){
        this.focalPointAlignment = focalPointAlignment;
      }

      if (canMoveHorizontal != null){
        this.canMoveHorizontal.set(value: canMoveHorizontal, mounted: mounted);
      }
      if (canMoveVertical != null){
        this.canMoveVertical.set(value: canMoveVertical, mounted: mounted);
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
    canMoveHorizontal.dispose();
    canMoveVertical.dispose();
    canScale.dispose();
    canRotate.dispose();
    scrollController.dispose();
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
  final Wire<bool> canMoveHorizontal = Wire<bool>(true);
  final Wire<bool> canMoveVertical = Wire<bool>(true);
  // --------------------
  void setCanMoveHorizontal(bool value){
    canMoveHorizontal.set(value: value, mounted: mounted);
  }
  // --------------------
  void setCanMoveVertical(bool value){
    canMoveVertical.set(value: value, mounted: mounted);
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
  /// TESTED : WORKS PERFECT
  Matrix4 _updateTheTranslation({
    required Offset newFocalPoint,
    required Matrix4 input,
    required bool canMoveHorizontal,
    required bool canMoveVertical,
  }){
    Matrix4 _output = input;

    _newTranslation = newFocalPoint - _oldTranslation;
    _oldTranslation = newFocalPoint;

    if (canMoveHorizontal == true && canMoveVertical == true) {
      _output = NeoMove.createDelta(
        translation: _newTranslation,
      ) * _output;
    }

    else {
      final double _radian = NeoRotate.getRotationInRadians(_output)!;
      _output = _output * NeoMove.createDelta(
          translation: Offset(
            canMoveHorizontal ? _newTranslation.dx : -_newTranslation.dy * tan(_radian),
            canMoveVertical ? _newTranslation.dy : _newTranslation.dx * tan(_radian),
          )
      );

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
    required bool canMoveHorizontal,
    required bool canMoveVertical,
    required bool canScale,
  }) {

    /// TRANSLATION
    Matrix4 _newViewMatrix = _updateTheTranslation(
      input: viewMatrix.value,
      newFocalPoint: details.focalPoint,
      canMoveHorizontal: canMoveHorizontal,
      canMoveVertical: canMoveVertical,
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
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    )!;
  }
  // --------------------
  Matrix4? getDeadViewMatrix(){
    return viewMatrix.value;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// DO_WIDER_CHECKER
  /*
  bool checkIsCoverFit ({
    required Matrix4? matrix,
    required Dimensions picDims,
    required Dimensions canvasDims,
  }){
    bool _isCover = false;

    // if (matrix != null){
    //
    //   final double _radians = NeoRotate.getRotationInDegrees(matrix)!;
    //
    //   if (_radians == 0){
    //
    //     final double _canvasWidth =  canvasDims.width ?? 0;
    //     final double _canvasHeight = canvasDims.height ?? 0;
    //
    //     final Dimensions? _identityGraphicDims = NeoPointGraphic.getContainedGraphicDims(
    //       picDims: picDims,
    //       canvasDims: canvasDims,
    //     );
    //
    //     final double _scaleFactor = NeoScale.getScaleFactor(
    //       matrix: matrix,
    //       canvasWidth: _canvasWidth,
    //     ) ?? 1;
    //     final double _viewGraphicWidth = (_identityGraphicDims?.width ?? 0) * _scaleFactor;
    //     final double _viewGraphicHeight = (_identityGraphicDims?.height ?? 0) * _scaleFactor;
    //
    //     final bool _widthIsGood = _viewGraphicWidth >= _canvasWidth;
    //     final bool _heightIsGood = _viewGraphicHeight >= _canvasHeight;
    //
    //     blog('[$_scaleFactor] is cover : $_isCover [$_viewGraphicWidth] >= [$_canvasWidth] : [$_viewGraphicHeight] >= [$_canvasHeight]');
    //
    //     _isCover = _widthIsGood && _heightIsGood;
    //   }
    //
    // }

    return _isCover;
  }
  // --------------------
  bool checkIsMediumFit(){
    return false;
  }
  // --------------------
  bool checkIsContainedFit(){
    return false;
  }
  // --------------------
  bool checkIsLeveledFitWidth(){
    return false;
  }
  // --------------------
  bool checkIsLeveledFitHeight(){
    return false;
  }
  // --------------------
  bool checkIsWiderFit(){
    return false;
  }
  // --------------------
  bool checkIsHigherFit(){
    return false;
  }
   */
  // --------------------
  void xx(){}
  // --------------------------------------------------------------------------
}
