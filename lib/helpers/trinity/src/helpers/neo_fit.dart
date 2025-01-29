part of trinity;
///
abstract class NeoFit {
  // --------------------------------------------------------------------------

  /// LEVELLING

  // --------------------
  ///
  static Matrix4 level({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
  }){
    return NeoRotate.setRotationFromCenterByDegrees(
      matrix: matrix,
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      degrees: 0,
    );
  }
  // --------------------------------------------------------------------------

  /// LEVEL FIT

  // --------------------
  ///
  static Matrix4 levelFitWidth({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    required Dimensions picDims,
  }){

    final Dimensions? _graphicDims = picDims.resizeToHeight(height: viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;

    Matrix4 _newMatrix = level(
      matrix: matrix,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );

    // graphicWidth * newScale = viewWidth
    final double _widthFittingScaleFactor = viewWidth / _graphicWidth;

    _newMatrix = NeoScale.setScaleFactor(
      matrix: _newMatrix,
      scaleFactor: _widthFittingScaleFactor,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );

    final double _leftOffset = (viewWidth - _graphicWidth) * 0.5 * _widthFittingScaleFactor;

    return NeoMove.setTranslation(
      matrix: _newMatrix,
      translation: Offset(-_leftOffset, _newMatrix[13]),
    );
  }
  // --------------------
  ///
  static Matrix4 levelFitHeight({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    required Dimensions picDims,
  }){

    final Dimensions? _graphicDims = picDims.resizeToHeight(height: viewHeight);
    final double _graphicHeight = _graphicDims?.height ?? 0;

    Matrix4 _newMatrix = level(
      matrix: matrix,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );

    // graphicHeight * newScale = viewHeight
    final double _widthFittingScaleFactor = viewHeight / _graphicHeight;

    _newMatrix = NeoScale.setScaleFactor(
      matrix: _newMatrix,
      scaleFactor: _widthFittingScaleFactor,
      viewHeight: viewHeight,
      viewWidth: viewWidth,
    );

    final double _topOffset = (viewHeight - _graphicHeight) * 0.5 * _widthFittingScaleFactor;

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
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _graphicPoints = NeoPoint.getAllGraphicPoints(
      matrix: matrix,
      picDims: picDims,
      viewDims: viewDims,
    );

    final Offset _leftMost = Cartesian.getLeftMostPoint(
      points: _graphicPoints,
    )!;
    final Offset _rightMost = Cartesian.getRightMostPoint(
      points: _graphicPoints,
    )!;

    final double _graphicAdjacent = _rightMost.dx - _leftMost.dx;
    final double _viewAdjacent = viewDims.width ?? 0;

    final double _graphicScaleFactor = NeoScale.getScaleFactor(
      matrix: matrix,
      viewWidth: viewDims.width ?? 0,
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
      viewWidth: viewDims.width ?? 0,
      viewHeight: viewDims.height ?? 0,
    );

    final Offset _leftMostPoint = NeoPoint.getGraphicLeftMostPoint(
      matrix: _matrix,
      picDims: picDims,
      viewDims: viewDims,
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
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _graphicPoints = NeoPoint.getAllGraphicPoints(
      matrix: matrix,
      picDims: picDims,
      viewDims: viewDims,
    );

    final Offset _topMost = Cartesian.getTopMostPoint(
      points: _graphicPoints,
    )!;
    final Offset _bottomMost = Cartesian.getBottomMostPoint(
      points: _graphicPoints,
    )!;

    final double _graphicOpposite = _bottomMost.dy - _topMost.dy;
    final double _viewOpposite = viewDims.height ?? 0;

    final double _graphicScaleFactor = NeoScale.getScaleFactor(
      matrix: matrix,
      viewWidth: viewDims.width ?? 0,
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
      viewWidth: viewDims.width ?? 0,
      viewHeight: viewDims.height ?? 0,
    );

    final Offset _topMostPoint = NeoPoint.getGraphicTopMostPoint(
      matrix: _matrix,
      picDims: picDims,
      viewDims: viewDims,
    );

    return NeoMove.move(
      matrix: _matrix,
      y: - _topMostPoint.dy,
      x: 0,
    );

  }
  // --------------------------------------------------------------------------
}
