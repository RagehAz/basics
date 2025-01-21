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
        width: width
    )!;
    final double _scaledWidth = width * _scaleFactor;
    final double _scaledHeight = height * _scaleFactor;
    // --------------------
    final double _diagonalLength = Trigonometer.pythagorasHypotenuse(
      side: _scaledWidth,
      side2: _scaledHeight,
    )!;
    final double _diagonalAngle = acos(_scaledWidth / _diagonalLength);
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
        width: width
    )!;
    final double _scaledWidth = width * _scaleFactor;
    final double _scaledHeight = height * _scaleFactor;
    // --------------------
    final double _diagonalLength = Trigonometer.pythagorasHypotenuse(
      side: _scaledWidth,
      side2: _scaledHeight,
    )!;
    final double _diagonalAngle = acos(_scaledWidth / _diagonalLength);
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
}
