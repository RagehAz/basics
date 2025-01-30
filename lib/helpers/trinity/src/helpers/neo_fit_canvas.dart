part of trinity;
/// => TAMAM
abstract class NeoFitCanvas {
  // --------------------------------------------------------------------------

  /// LEVELLING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 level({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    return NeoRotate.setRotationFromCenterByDegrees(
      matrix: matrix,
      canvasDims: canvasDims,
      degrees: 0,
    );
  }
  // --------------------------------------------------------------------------

  /// LEVEL FIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 levelFitWidth({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    // --------------------
    Matrix4 _newMatrix = level(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    /// boxWidth * newScale = canvasWidth
    final double _widthFittingScaleFactor = _canvasWidth / _canvasWidth;

    _newMatrix = NeoScale.setScaleFactor(
      matrix: _newMatrix,
      scaleFactor: _widthFittingScaleFactor,
      canvasDims: canvasDims,
    );

    final double _leftOffset = (_canvasWidth - _canvasWidth) * 0.5 * _widthFittingScaleFactor;

    return NeoMove.setTranslation(
      matrix: _newMatrix,
      translation: Offset(-_leftOffset, _newMatrix[13]),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 levelFitHeight({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    Matrix4 _newMatrix = level(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    // graphicHeight * newScale = viewHeight
    final double _widthFittingScaleFactor = _canvasHeight / _canvasHeight;

    _newMatrix = NeoScale.setScaleFactor(
      matrix: _newMatrix,
      scaleFactor: _widthFittingScaleFactor,
      canvasDims: canvasDims,
    );

    final double _topOffset = (_canvasHeight - _canvasHeight) * 0.5 * _widthFittingScaleFactor;

    return NeoMove.setTranslation(
      matrix: _newMatrix,
      translation: Offset(_newMatrix[12], _topOffset),
    );
  }
  // --------------------------------------------------------------------------

  /// ROTATED FITTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 rotatedFitWidth({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){

    final List<Offset> _graphicPoints = NeoPointCanvas.getAllPoints(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    final Offset _leftMost = Cartesian.getLeftMostPoint(
      points: _graphicPoints,
    )!;
    final Offset _rightMost = Cartesian.getRightMostPoint(
      points: _graphicPoints,
    )!;

    final double _graphicAdjacent = _rightMost.dx - _leftMost.dx;
    final double _viewAdjacent = canvasDims.width ?? 0;

    final double _graphicScaleFactor = NeoScale.getScaleFactor(
      matrix: matrix,
      canvasWidth: canvasDims.width ?? 0,
    )!;
    // _graphicAdjacent / _viewAdjacent = _graphicScaleFactor / _viewScaleFactor[_graphicNewScaleFactor]
    // final double _graphicNewScaleFactor = _graphicScaleFactor / (_graphicAdjacent / _viewAdjacent);
    final double _graphicNewScaleFactor = Numeric.divide(
      dividend: _graphicScaleFactor,
      divisor: Numeric.divide(dividend: _graphicAdjacent, divisor: _viewAdjacent),
    );

    final Matrix4 _matrix = NeoScale.setScaleFactor(
      matrix: matrix,
      scaleFactor: _graphicNewScaleFactor,
      canvasDims: canvasDims,
    );

    final Offset _leftMostPoint = NeoPointCanvas.getLeftMostPoint(
      matrix: _matrix,
      canvasDims: canvasDims,
    );

    return NeoMove.move(
      matrix: _matrix,
      y: 0,
      x: - _leftMostPoint.dx,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 rotatedFitHeight({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){

    final List<Offset> _graphicPoints = NeoPointCanvas.getAllPoints(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    final Offset _topMost = Cartesian.getTopMostPoint(
      points: _graphicPoints,
    )!;
    final Offset _bottomMost = Cartesian.getBottomMostPoint(
      points: _graphicPoints,
    )!;

    final double _graphicOpposite = _bottomMost.dy - _topMost.dy;
    final double _viewOpposite = canvasDims.height ?? 0;

    final double _graphicScaleFactor = NeoScale.getScaleFactor(
      matrix: matrix,
      canvasWidth: canvasDims.width ?? 0,
    )!;
    // _graphicOpposite / _viewOpposite = _graphicScaleFactor / _viewScaleFactor[_graphicNewScaleFactor]
    // final double _graphicNewScaleFactor = _graphicScaleFactor / (_graphicOpposite / _viewOpposite);
    final double _graphicNewScaleFactor = Numeric.divide(
      dividend: _graphicScaleFactor,
      divisor: Numeric.divide(dividend: _graphicOpposite, divisor: _viewOpposite),
    );

    final Matrix4 _matrix = NeoScale.setScaleFactor(
      matrix: matrix,
      scaleFactor: _graphicNewScaleFactor,
      canvasDims: canvasDims,
    );

    final Offset _topMostPoint = NeoPointCanvas.getTopMostPoint(
      matrix: _matrix,
      canvasDims: canvasDims,
    );

    return NeoMove.move(
      matrix: _matrix,
      y: - _topMostPoint.dy,
      x: 0,
    );

  }
  // --------------------------------------------------------------------------
}
