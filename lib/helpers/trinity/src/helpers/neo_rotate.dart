part of trinity;
/// => TAMAM
abstract class NeoRotate {
  // --------------------------------------------------------------------------

  /// ROTATE

  // --------------------
  ///
  static Matrix4? rotate({
    required Matrix4? matrix,
    required double? radians,
    required Offset focalPoint,
  }){
    Matrix4? _output;

    if (matrix != null && radians != null){

      final double _cos = cos(radians);
      final double _sin = sin(radians);

      final double _dx = focalPoint.dx;
      final double _dy = focalPoint.dy;

      final List<double> _m = matrix.storage;

      final double _scaleX = _cos*_m[0] - _sin*_m[1];
      final double _scaleY = _cos*_m[5] + _sin*_m[4];

      final double _shearXY = _cos*_m[1] + _sin*_m[0];
      final double _shearYX = _cos*_m[4] - _sin*_m[5];

      final double _translateX = _m[12] - _dx*_cos + _dy*_sin;
      final double _translateY = _m[13] - _dx*_sin - _dy*_cos;

      final Float64List _list = Float64List.fromList(<double>[
        _scaleX,      _shearXY,     _m[2],    _m[3],
        _shearYX,     _scaleY,      _m[6],    _m[7],
        _m[8],        _m[9],        _m[10],   _m[11],
        _translateX,  _translateY,  _m[14],   _m[15]
      ]);

      _output = Matrix4.fromFloat64List(_list);

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
    /// TESTED : WORKS PERFECT
  static double? getRotationInDegrees(Matrix4? matrix) {
    double? _output;

    if (matrix != null){

      try {
        final double radians = getRotationInRadians(matrix)!;
        final double _deg = Numeric.radianToDegree(radians)!;
        _output = Numeric.limit360DegreeTo360(_deg)!;
      } on Exception catch (e) {
        blog('getRotationInDegrees: _output($_output).ERROR: $e');
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getRotationInRadians(Matrix4? matrix) {

    if (matrix == null){
      return null;
    }
    else {
      final double m11 = matrix.entry(0, 0);
      final double m12 = matrix.entry(0, 1);
      final double radians = atan2(m12, m11);
      return radians;
    }

  }
  // --------------------------------------------------------------------------

  /// DELTA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 createDelta({
    required Offset focalPoint,
    required double angle,
  }){
    final double c = cos(angle);
    final double s = sin(angle);
    final double dx = (1 - c) * focalPoint.dx + s * focalPoint.dy;
    final double dy = (1 - c) * focalPoint.dy - s * focalPoint.dx;

    //  ..[0]  = c       # x scale
    //  ..[1]  = s       # y skew
    //  ..[4]  = -s      # x skew
    //  ..[5]  = c       # y scale
    //  ..[10] = 1       # diagonal "one"
    //  ..[12] = dx      # x translation
    //  ..[13] = dy      # y translation
    //  ..[15] = 1       # diagonal "one"
    return Matrix4(c, s, 0, 0, -s, c, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------------------------------------------------------------
  void x(){}
}
