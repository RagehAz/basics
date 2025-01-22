part of trinity;
/// => TAMAM
abstract class NeoScale {
  // --------------------------------------------------------------------------

  /// ON GESTURE CHANGED

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 applyScale({
    required Matrix4 matrix,
    required double xComponentFactor,
    required double yComponentFactor,
    Offset focalPoint = Offset.zero,
  }){
    final List<double> _m = matrix.storage;

    final double _newScaleX = _m[0] * xComponentFactor;
    final double _newScaleY = _m[5] * yComponentFactor;

    final double _newTranslateDeltaX = (1 - xComponentFactor) * focalPoint.dx;
    final double _newTranslateDeltaY = (1 - yComponentFactor) * focalPoint.dy;

    final double _dx = _m[12] + _newTranslateDeltaX;
    final double _dy = _m[13] + _newTranslateDeltaY;

    final Float64List _list = Float64List.fromList(<double>[
      _newScaleX,   _m[1],        _m[2],    _m[3],
      _m[4],        _newScaleY,   _m[6],    _m[7],
      _m[8],        _m[9],        _m[10],   _m[11],
      _dx,          _dy,          _m[14],   _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 createDelta({
    required Offset focalPoint,
    required double scale,
  }){
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
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getXScale(Matrix4? matrix){
    if (matrix == null){
      return null;
    }
    else {
      final List<double> _m = matrix.storage;
      return _m[0];
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getYScale(Matrix4? matrix){
    if (matrix == null){
      return null;
    }
    else {
      final List<double> _m = matrix.storage;
      return _m[5];
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getScaleFactor({
    required Matrix4? matrix,
    required double viewWidth,
  }){
    if (matrix == null){
      return null;
    }
    else {
      final double radians = NeoRotate.getRotationInRadians(matrix)!;
      final double _scaleX = NeoScale.getXScale(matrix)!;
      final double _horizontalComponent = viewWidth * _scaleX;
      final double _scaledWidth = _horizontalComponent / cos(radians);
      return _scaledWidth / viewWidth;
    }
  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 setScaleFactor({
    required Matrix4 matrix,
    required double scaleFactor,
    required double viewWidth,
    required double viewHeight,
  }){
    Matrix4 _output = Matrix4.identity();

    final Offset _oldCenter = NeoPoint.center(
      matrix: matrix,
      width: viewWidth,
      height: viewHeight,
    );

    _output = NeoCell.setCellValue(
        matrix: _output,
        cellIndex: 0,
        value: scaleFactor,
    )!;
    _output = NeoCell.setCellValue(
        matrix: _output,
        cellIndex: 5,
        value: scaleFactor,
    )!;

    final double radians = NeoRotate.getRotationInRadians(matrix)!;
    _output = NeoRotate.setRotationFromCenterByRadians(
      matrix: _output,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
      radians: radians,
    );

    /// should go to old center
    final Offset _newCenter = NeoPoint.center(
      matrix: _output,
      width: viewWidth,
      height: viewHeight,
    );

    return NeoMove.applyTranslation(
      matrix: _output,
      translationDelta: _oldCenter - _newCenter,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 increaseScale({
    required Matrix4 matrix,
    required double increment,
    required double viewWidth,
    required double viewHeight,
  }){

    final double _oldScaleFactor = getScaleFactor(
      matrix: matrix,
      viewWidth: viewWidth,
    )!;

    final double _newScaleFactor = _oldScaleFactor + increment;

    return setScaleFactor(
      matrix: matrix,
      scaleFactor: _newScaleFactor,
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }
  // --------------------------------------------------------------------------
}
