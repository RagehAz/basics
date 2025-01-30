part of trinity;
/// => TAMAM
abstract class NeoPointCanvas {
  // -----------------------------------------------------------------------------
  /// CANVAS : IS THE BOUNDING BOX OF THE VIEW WHERE THE BOX IS DRAWN AND MAY CONTAIN A GRAPHIC INSIDE THE BOX
  /// WHERE THE GRAPHIC IS SET TO FIT CONTAINED INSIDE THE BOX
  // -----------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset topLeft({
    required Matrix4 matrix,
  }){
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    return _topLeft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset topRight({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _horizontalComponent = _canvasWidth * _scaleX;
    // --------------------
    final double radians = NeoRotate.getRotationInRadians(matrix)!;
    final double _verticalComponent = _horizontalComponent * tan(radians);
    // --------------------
    final double _dx = _topLeft.dx + _horizontalComponent;
    final double _dy = _topLeft.dy - _verticalComponent;
    // --------------------
    return Offset(_dx, _dy);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset bottomLeft({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _verticalComponent = _canvasHeight * _scaleY;
    // --------------------
    final double radians = NeoRotate.getRotationInRadians(matrix)!;
    final double _horizontalComponent = _verticalComponent * tan(radians);
    // --------------------
    final double _dy = _topLeft.dy + _verticalComponent;
    final double _dx = _topLeft.dx + _horizontalComponent;
    // --------------------
    return Offset(_dx, _dy);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset bottomRight({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final double _scaleFactor = NeoScale.getScaleFactor(
        matrix: matrix,
        canvasWidth: _canvasWidth
    )!;
    final double _scaledWidth = _canvasWidth * _scaleFactor;
    final double _scaledHeight = _canvasHeight * _scaleFactor;
    // --------------------
    final double _diagonalLength = Trigonometer.pythagorasHypotenuse(
      side: _scaledWidth,
      side2: _scaledHeight,
    )!;
    final double _ang = Numeric.divide(dividend: _scaledWidth, divisor: _diagonalLength);
    final double _diagonalAngle = acos(_ang);
    // --------------------
    final double radians = NeoRotate.getRotationInRadians(matrix)! - _diagonalAngle;
    // --------------------
    final double _horizontalComponent = _diagonalLength * cos(radians);
    final double _verticalComponent = _horizontalComponent * tan(radians);
    // --------------------
    final double _dy = _topLeft.dy - _verticalComponent;
    final double _dx = _topLeft.dx + _horizontalComponent;
    // --------------------
    return Offset(_dx, _dy);
  }
  // -----------------------------------------------------------------------------

  /// CENTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset center({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _canvasWidth = canvasDims.width ?? 0;
    final double _canvasHeight = canvasDims.height ?? 0;
    // --------------------
    final double _scaleFactor = NeoScale.getScaleFactor(
        matrix: matrix,
        canvasWidth: _canvasWidth
    )!;
    final double _scaledWidth = _canvasWidth * _scaleFactor;
    final double _scaledHeight = _canvasHeight * _scaleFactor;
    // --------------------
    final double _diagonalLength = Trigonometer.pythagorasHypotenuse(
      side: _scaledWidth,
      side2: _scaledHeight,
    )!;
    final double _ang = Numeric.divide(dividend: _scaledWidth, divisor: _diagonalLength);
    final double _diagonalAngle = acos(_ang);
    // --------------------
    final double radians = NeoRotate.getRotationInRadians(matrix)! - _diagonalAngle;
    // --------------------
    final double _horizontalComponent = 0.5 * _diagonalLength * cos(radians);
    final double _verticalComponent = _horizontalComponent * tan(radians);
    // --------------------
    final double _dy = _topLeft.dy - _verticalComponent;
    final double _dx = _topLeft.dx + _horizontalComponent;
    // --------------------
    return Offset(_dx, _dy);
  }
  // -----------------------------------------------------------------------------

  /// GRAPHIC CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Offset> getAllPoints({
    required Matrix4 matrix,
    required Dimensions canvasDims,
  }){

    final Offset _topLeft = topLeft(
      matrix: matrix,
    );

    final Offset _topRight = topRight(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    final Offset _bottomLeft = bottomLeft(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    final Offset _bottomRight = bottomRight(
      matrix: matrix,
      canvasDims: canvasDims,
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
    required Dimensions canvasDims,
  }){

    final List<Offset> _allPoints = getAllPoints(
      matrix: matrix,
      canvasDims: canvasDims,
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
    required Dimensions canvasDims,
  }){

    final List<Offset> _allPoints = getAllPoints(
      matrix: matrix,
      canvasDims: canvasDims,
    );

    final Offset _leftMost = Cartesian.getLeftMostPoint(
      points: _allPoints,
    )!;

    return _leftMost;
  }
  // -----------------------------------------------------------------------------
}
