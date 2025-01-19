part of trinity;

abstract class NeoScale {
  // --------------------------------------------------------------------------

  /// CELL GETTERS

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
    required double width,
  }){
    if (matrix == null){
      return null;
    }
    else {
      final double radians = NeoRotate.getRotationInRadians(matrix)!;
      final double _horizontalComponent = width * NeoScale.getXScale(matrix)!;
      final double _scaledWidth = _horizontalComponent / cos(radians);
      return _scaledWidth / width;
    }
  }
  // --------------------------------------------------------------------------

  /// SCALE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 scale({
    required Matrix4 matrix,
    required double x,
    required double y,
  }){
    final List<double> _m = matrix.storage;

    final Float64List _list = Float64List.fromList(<double>[
      _m[0]*x,  _m[1],      _m[2],    _m[3],
      _m[4],    _m[5]*y,    _m[6],    _m[7],
      _m[8],    _m[9],      _m[10],   _m[11],
      _m[12],   _m[13],     _m[14],   _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------
  ///
  static Matrix4 newScale({
    required Matrix4 matrix,
    required double x,
    required double y,
    Offset focalPoint = Offset.zero,
  }){
    final List<double> _m = matrix.storage;

    final double _newScaleX = _m[0] * x;
    final double _newScaleY = _m[5] * y;

    final double _newTranslateDeltaX = (1 - x) * focalPoint.dx;
    final double _newTranslateDeltaY = (1 - y) * focalPoint.dy;

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
  // --------------------------------------------------------------------------

  /// DELTA

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
  void x(){}
}
