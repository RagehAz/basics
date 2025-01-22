part of trinity;
/// => TAMAM
abstract class NeoRotate {
  // --------------------------------------------------------------------------

  /// ON GESTURE CHANGED

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? applyRotation({
    required Matrix4? matrix,
    required double? radiansDelta,
    required Offset focalPoint,
  }){
    Matrix4? _output;

    if (matrix != null && radiansDelta != null){

      final double _cos = cos(radiansDelta);
      final double _sin = sin(radiansDelta);

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

  /// GETTERS

  // --------------------
    /// TESTED : WORKS PERFECT
  static double? getRotationInDegrees(Matrix4? matrix) {
    double? _output;

    if (matrix != null){

      try {
        final double m11 = matrix.entry(0, 0);
        final double m12 = matrix.entry(0, 1);
        final double radians = atan2(m12, m11);
        final double _deg = Trigonometer.radianToDegree(radians)!;
        _output = Trigonometer.limit360DegreeTo360(_deg)!;
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
      final double _deg = getRotationInDegrees(matrix)!;
      return Trigonometer.degreeToRadian(_deg);
    }

  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 setRotationFromCenterByDegrees({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    required double degrees,
  }){

    final double _oldDegrees = NeoRotate.getRotationInDegrees(matrix)!;

    final double _deltaDegrees = (degrees - _oldDegrees) * -1;

    return NeoRotate.rotateFromCenterByDegrees(
      matrix: matrix,
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      degrees: _deltaDegrees,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 setRotationFromCenterByRadians({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    required double radians,
  }){

    final double degrees = Trigonometer.radianToDegree(radians)!;

    return setRotationFromCenterByDegrees(
      matrix: matrix,
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      degrees: degrees,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 _setMatrixRotation({
    required Matrix4 matrix,
    required double rotation,
  }) {
    final translation = matrix.getTranslation();
    final double scaleX = matrix.getColumn(0).xyz.length;
    final double scaleY = matrix.getColumn(1).xyz.length;
    final double scaleZ = matrix.getColumn(2).xyz.length;

    final Matrix4 rotationMatrix = Matrix4.rotationZ(rotation);
    final Matrix4 _matrix = matrix;
    _matrix.setIdentity();
    _matrix.multiply(rotationMatrix);
    _matrix.scale(scaleX, scaleY, scaleZ);
    _matrix.setTranslation(translation);

    return _matrix;
  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 rotateFromCenterByDegrees({
    required Matrix4 matrix,
    required double viewWidth,
    required double viewHeight,
    required double degrees,
  }){

    final double _oldDegrees = NeoRotate.getRotationInDegrees(matrix)!;
    final double _newDegrees = Trigonometer.limit360DegreeTo360(degrees)!;


    double _delta = Trigonometer.limit360DegreeTo360(_newDegrees - _oldDegrees)!;
    _delta = Trigonometer.degreeToRadian(_delta)!;

    final Offset _oldCenter = NeoPoint.center(
      matrix: matrix,
      width: viewWidth,
      height: viewHeight,
    );

    final Matrix4 _newMatrix = _setMatrixRotation(
      rotation: _delta,
      matrix: matrix,
    );

    /// should go to old center
    final Offset _newCenter = NeoPoint.center(
      matrix: _newMatrix,
      width: viewWidth,
      height: viewHeight,
    );

    return NeoMove.applyTranslation(
      matrix: _newMatrix,
      translationDelta: _oldCenter - _newCenter,
    );
  }
  // --------------------------------------------------------------------------
}
