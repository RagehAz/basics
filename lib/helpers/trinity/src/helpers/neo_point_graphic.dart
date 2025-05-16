part of trinity;
/// => TAMAM
abstract class NeoPointGraphic {
  // -----------------------------------------------------------------------------

  /// CONTAINED GRAPHIC SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions getContainedGraphicDims({
    required Dimensions? picDims,
    required Dimensions? canvasDims,
  }){
    Dimensions _output = Dimensions.zero;

    if (picDims != null && canvasDims != null){

      final double _canvasWidth = canvasDims.width ?? 0;
      final double _canvasHeight = canvasDims.height ?? 0;

      final bool _isWider = picDims.getAspectRatio() >  canvasDims.getAspectRatio();

      /// WIDER MEANS MORE SQUARE THEN MORE LANDSCAPE => THE IMAGE IS FIT WIDTH ALREADY
      if (_isWider == true){
        _output = picDims.resizeToWidth(width: _canvasWidth)!;
      }

      else {
        _output = picDims.resizeToHeight(height: _canvasHeight)!;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GRAPHIC CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset topLeft({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = getContainedGraphicDims(
      picDims: picDims,
      canvasDims: canvasDims,
    );
    final double _graphicWidth = _graphicDims?.width ?? 0;
    final double _graphicHeight = _graphicDims?.height ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _topLeftHypotenuseX = (_canvasWidth - _graphicWidth)/2;
    final double _topLeftAdjacentX = _topLeftHypotenuseX * _scaleX;
    final double _topLeftOppositeX = _topLeftAdjacentX * tan(_radians);
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _topLeftHypotenuseY = (_canvasHeight - _graphicHeight) / 2;
    final double _topLeftAdjacentY = _topLeftHypotenuseY * _scaleY;
    final double _topLeftOppositeY = _topLeftAdjacentY * tan(_radians);
    // --------------------
    return Offset(
      _topLeft.dx + _topLeftAdjacentX + _topLeftOppositeY,
      _topLeft.dy - _topLeftOppositeX + _topLeftAdjacentY,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset topRight({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = getContainedGraphicDims(
      picDims: picDims,
      canvasDims: canvasDims,
    );
    final double _graphicWidth = _graphicDims?.width ?? 0;
    final double _graphicHeight = _graphicDims?.height ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _topRightHypotenuseX = _canvasWidth - ((_canvasWidth - _graphicWidth)/2);
    final double _topRightAdjacentX = _topRightHypotenuseX * _scaleX;
    final double _topRightOppositeX = _topRightAdjacentX * tan(_radians);
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _yCorrection = (_canvasHeight - _graphicHeight)/2;
    final double _yScaledCorrection = _yCorrection * _scaleY;
    final double _xScaledCorrection = _yScaledCorrection * tan(_radians);
    // --------------------
    return Offset(
      _topLeft.dx + _topRightAdjacentX + _xScaledCorrection,
      _topLeft.dy - _topRightOppositeX + _yScaledCorrection,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset bottomLeft({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = getContainedGraphicDims(
      picDims: picDims,
      canvasDims: canvasDims,
    );
    final double _graphicWidth = _graphicDims?.width ?? 0;
    final double _graphicHeight = _graphicDims?.height ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _bottomLeft = NeoPointCanvas.bottomLeft(
      matrix: matrix,
      canvasDims: canvasDims,
    );
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _bottomLeftHypotenuse = (_canvasWidth - _graphicWidth)/2;
    final double _bottomLeftAdjacent = _bottomLeftHypotenuse * _scaleX;
    final double _bottomLeftOpposite = _bottomLeftAdjacent * tan(_radians);
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _yCorrection = (_canvasHeight - _graphicHeight)/2;
    final double _yScaledCorrection = _yCorrection * _scaleY;
    final double _xScaledCorrection = _yScaledCorrection * tan(_radians);
    // --------------------
    return Offset(
      _bottomLeft.dx + _bottomLeftAdjacent - _xScaledCorrection,
      _bottomLeft.dy - _bottomLeftOpposite - _yScaledCorrection,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset bottomRight({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = getContainedGraphicDims(
      picDims: picDims,
      canvasDims: canvasDims,
    );
    // --------------------
    final double _graphicWidth = _graphicDims?.width ?? 0;
    final double _graphicHeight = _graphicDims?.height ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _bottomLeft = NeoPointCanvas.bottomLeft(
      matrix: matrix,
      canvasDims: canvasDims,
    );
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _hypotenuse = _canvasWidth - ((_canvasWidth - _graphicWidth)/2);
    final double _adjacent = _hypotenuse * _scaleX;
    final double _opposite = _adjacent * tan(_radians);
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _yCorrection = (_canvasHeight - _graphicHeight)/2;
    final double _yScaledCorrection = _yCorrection * _scaleY;
    final double _xScaledCorrection = _yScaledCorrection * tan(_radians);
    // --------------------
    return Offset(
      _bottomLeft.dx + _adjacent - _xScaledCorrection,
      _bottomLeft.dy - _opposite - _yScaledCorrection,
    );
  }
  // -----------------------------------------------------------------------------

  /// GRAPHIC CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Offset> getAllPoints({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final Offset _topLeft = topLeft(
      matrix: matrix,
      picDims: picDims,
      canvasDims: viewDims,
    );

    final Offset _topRight = topRight(
      matrix: matrix,
      picDims: picDims,
      canvasDims: viewDims,
    );

    final Offset _bottomLeft = bottomLeft(
      matrix: matrix,
      picDims: picDims,
      canvasDims: viewDims,
    );

    final Offset _bottomRight = bottomRight(
      matrix: matrix,
      picDims: picDims,
      canvasDims: viewDims,
    );
    // --------------------
    return [
      /// TOP LEFT
      _topLeft,
      /// TOP RIGHT
      _topRight,
      /// BOTTOM LEFT
      _bottomLeft,
      /// BOTTOM RIGHT
      _bottomRight,
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset getTopMostPoint({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _allPoints = getAllPoints(
      matrix: matrix,
      picDims: picDims,
      viewDims: viewDims,
    );

    final Offset _topMost = Cartesian.getTopMostPoint(
      points: _allPoints,
    )!;

    return _topMost;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset getLeftMostPoint({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _allPoints = getAllPoints(
      matrix: matrix,
      picDims: picDims,
      viewDims: viewDims,
    );

    final Offset _leftMost = Cartesian.getLeftMostPoint(
      points: _allPoints,
    )!;

    return _leftMost;
  }
  // -----------------------------------------------------------------------------
}
