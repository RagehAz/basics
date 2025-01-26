part of trinity;
/// => TAMAM
abstract class NeoPoint {
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
    required double width,
    required double height,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _horizontalComponent = width * _scaleX;
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
    required double width,
    required double height,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleY = NeoScale.getYScale(matrix)!;
    final double _verticalComponent = height * _scaleY;
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
    required double width,
    required double height,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleFactor = NeoScale.getScaleFactor(
        matrix: matrix,
        viewWidth: width
    )!;
    final double _scaledWidth = width * _scaleFactor;
    final double _scaledHeight = height * _scaleFactor;
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
    required double width,
    required double height,
  }){
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleFactor = NeoScale.getScaleFactor(
        matrix: matrix,
        viewWidth: width
    )!;
    final double _scaledWidth = width * _scaleFactor;
    final double _scaledHeight = height * _scaleFactor;
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
  static Offset graphicTopLeft({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){
    // --------------------
    final double _viewWidth = viewDims.width ?? 0;
    final double _viewHeight = viewDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = picDims.resizeToHeight(height: _viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _topLeftHypotenuse = (_viewWidth - _graphicWidth)/2;
    final double _topLeftAdjacent = _topLeftHypotenuse * _scaleX;
    final double _topLeftOpposite = _topLeftAdjacent * tan(_radians);
    // --------------------
    return Offset(_topLeft.dx + _topLeftAdjacent, _topLeft.dy - _topLeftOpposite);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset graphicTopRight({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){
    // --------------------
    final double _viewWidth = viewDims.width ?? 0;
    final double _viewHeight = viewDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = picDims.resizeToHeight(height: _viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _topRightHypotenuse = _viewWidth - ((_viewWidth - _graphicWidth)/2);
    final double _topRightAdjacent = _topRightHypotenuse * _scaleX;
    final double _topRightOpposite = _topRightAdjacent * tan(_radians);
    // --------------------
    return Offset(
      _topLeft.dx + _topRightAdjacent,
      _topLeft.dy - _topRightOpposite,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset graphicBottomLeft({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){
    // --------------------
    final double _viewWidth = viewDims.width ?? 0;
    final double _viewHeight = viewDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = picDims.resizeToHeight(height: _viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _bottomLeft = bottomLeft(
      matrix: matrix,
      width: _viewWidth,
      height: _viewHeight,
    );
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _bottomLeftHypotenuse = (_viewWidth - _graphicWidth)/2;
    final double _bottomLeftAdjacent = _bottomLeftHypotenuse * _scaleX;
    final double _bottomLeftOpposite = _bottomLeftAdjacent * tan(_radians);
    // --------------------
    return Offset(
      _bottomLeft.dx + _bottomLeftAdjacent,
      _bottomLeft.dy - _bottomLeftOpposite,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset graphicBottomRight({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){
    // --------------------
    final double _viewWidth = viewDims.width ?? 0;
    final double _viewHeight = viewDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = picDims.resizeToHeight(height: _viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _bottomLeft = bottomLeft(
      matrix: matrix,
      width: _viewWidth,
      height: _viewHeight,
    );
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _hypotenuse = _viewWidth - ((_viewWidth - _graphicWidth)/2);
    final double _adjacent = _hypotenuse * _scaleX;
    final double _opposite = _adjacent * tan(_radians);
    // --------------------
    return Offset(
      _bottomLeft.dx + _adjacent,
      _bottomLeft.dy - _opposite,
    );
  }
  // -----------------------------------------------------------------------------

  /// GRAPHIC CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Offset> getAllGraphicPoints({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){
    // --------------------
    final double _viewWidth = viewDims.width ?? 0;
    final double _viewHeight = viewDims.height ?? 0;
    // --------------------
    final Dimensions? _graphicDims = picDims.resizeToHeight(height: _viewHeight);
    final double _graphicWidth = _graphicDims?.width ?? 0;
    // --------------------
    final double _radians = NeoRotate.getRotationInRadians(matrix)!;
    // --------------------
    final Offset _topLeft = NeoMove.getOffset(matrix)!;
    // --------------------
    final double _scaleX = NeoScale.getXScale(matrix)!;
    final double _topLeftHypotenuse = (_viewWidth - _graphicWidth)/2;
    final double _topLeftAdjacent = _topLeftHypotenuse * _scaleX;
    final double _topLeftOpposite = _topLeftAdjacent * tan(_radians);
    // --------------------
    final Offset _graphicTopLeft = Offset(_topLeft.dx + _topLeftAdjacent, _topLeft.dy - _topLeftOpposite);
    // --------------------
    final double _topRightHypotenuse = _viewWidth - ((_viewWidth - _graphicWidth)/2);
    final double _topRightAdjacent = _topRightHypotenuse * _scaleX;
    final double _topRightOpposite = _topRightAdjacent * tan(_radians);
    // --------------------
    final Offset _graphicTopRight = Offset(_topLeft.dx + _topRightAdjacent, _topLeft.dy - _topRightOpposite);
    // --------------------
    final Offset _bottomLeft = bottomLeft(
      matrix: matrix,
      width: _viewWidth,
      height: _viewHeight,
    );
    // --------------------
    final double _bottomLeftHypotenuse = (_viewWidth - _graphicWidth)/2;
    final double _bottomLeftAdjacent = _bottomLeftHypotenuse * _scaleX;
    final double _bottomLeftOpposite = _bottomLeftAdjacent * tan(_radians);
    // --------------------
    final Offset _graphicBottomLeft = Offset(_bottomLeft.dx + _bottomLeftAdjacent, _bottomLeft.dy - _bottomLeftOpposite);
    // --------------------
    final double _bottomRightHypotenuse = _viewWidth - ((_viewWidth - _graphicWidth)/2);
    final double _bottomRightAdjacent = _bottomRightHypotenuse * _scaleX;
    final double _bottomRightOpposite = _bottomRightAdjacent * tan(_radians);
    // --------------------
    final Offset _graphicBottomRight = Offset(_bottomLeft.dx + _bottomRightAdjacent, _bottomLeft.dy - _bottomRightOpposite);
    // --------------------
    return [
      /// TOP LEFT
      _graphicTopLeft,
      /// TOP RIGHT
      _graphicTopRight,
      /// BOTTOM LEFT
      _graphicBottomLeft,
      /// BOTTOM RIGHT
      _graphicBottomRight,
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset getGraphicTopMostPoint({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _allPoints = NeoPoint.getAllGraphicPoints(
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
  static Offset getGraphicLeftMostPoint({
    required Matrix4 matrix,
    required Dimensions picDims,
    required Dimensions viewDims,
  }){

    final List<Offset> _allPoints = NeoPoint.getAllGraphicPoints(
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
