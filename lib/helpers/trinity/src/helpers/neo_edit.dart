part of trinity;

abstract class NeoEdit {
  // -----------------------------------------------------------------------------

  /// EDIT

  // --------------------
  ///
  static Matrix4 edit({
    required BuildContext context,
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    Offset? focalPoint,
    double scale = 1.0,
    Offset translation = Offset.zero,
    double rotation = 0.0,
    bool canMove = true,
    bool canScale = true,
    bool canRotate = true,
    Alignment? focalPointAlignment,
  }) {
    Matrix4 _output = matrix;

    Offset _focalPoint = focalPoint ?? NeoPoint.center(
        matrix: matrix,
        width: viewWidth,
        height: viewHeight,
    );

    /// TRANSLATION
    _output = _updateTheTranslation(
      matrix: _output,
      newFocalPoint: _focalPoint,
      canMove: canMove,
      newTranslation: translation,
    );

    _focalPoint = _cureFocalPoint(
      context: context,
      givenPoint: _focalPoint,
      focalPointAlignment: focalPointAlignment,
    );

    /// SCALING
    _output = _updateTheScale(
      newScale: scale,
      point: _focalPoint,
      input: _output,
      canScale: canScale,
    );

    /// ROTATION
    _output = _updateTheRotation(
      newRotation: rotation,
      point: _focalPoint,
      matrix: _output,
      canRotate: canRotate,
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PART

  // --------------------
  static Matrix4 _updateTheTranslation({
    required Offset newFocalPoint,
    required Matrix4 matrix,
    required bool canMove,
    required Offset newTranslation,
  }){
    Matrix4 _output = matrix;
    if (canMove) {
      // final Offset _oldTranslation = NeoMove.getOffset(matrix)!;
      // final Offset _newTranslation = newFocalPoint - _oldTranslation;
      _output = NeoMove.createDelta(translation: newTranslation) * _output;
    }
    return _output;
  }
  // --------------------
  ///
  static Matrix4 _updateTheRotation({
    required double newRotation,
    required Offset point,
    required Matrix4 matrix,
    required bool canRotate,
  }){
    Matrix4 _output = matrix;

    if (canRotate && newRotation != 0.0) {

      double _oldRotation = NeoRotate.getRotationInRadians(matrix)!;

      if (_oldRotation.isNaN == true) {
        _oldRotation = newRotation;
      }

      else {
        final double _newRotation = newRotation - _oldRotation;
        _output = NeoRotate.createDelta(angle: _newRotation, focalPoint: point) * _output;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset _cureFocalPoint({
    required BuildContext context,
    required Offset givenPoint,
    required Alignment? focalPointAlignment,
  }){

    if (focalPointAlignment != null && context.size != null) {
      return focalPointAlignment.alongSize(context.size!);
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
  // --------------------
  static Matrix4 _updateTheScale({
    required Matrix4 input,
    required double newScale,
    required Offset point,
    required bool canScale,
  }){
    Matrix4 _output = input;
    if (canScale && newScale != 1.0) {
      double _oldScale = NeoScale.getXScale(input)!;
      final double _newScale = newScale / _oldScale;
      _oldScale = newScale;
      _output = NeoScale.createDelta(scale: _newScale, focalPoint: point) * _output;
    }
    return _output;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
