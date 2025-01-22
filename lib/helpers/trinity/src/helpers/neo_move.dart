part of trinity;
/// => TAMAM
abstract class NeoMove {
  // --------------------------------------------------------------------------

  /// ON GESTURE CHANGED

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 applyTranslation({
    required Matrix4 matrix,
    required Offset translationDelta,
  }){
    return move(
      matrix: matrix,
      x: translationDelta.dx,
      y: translationDelta.dy,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 createDelta({
    required Offset translation,
  }){

    final double dx = translation.dx;
    final double dy = translation.dy;

    return Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1);
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset? getOffset(Matrix4? matrix){

    if (matrix == null){
      return null;
    }

    else {
      final List<double> _m = matrix.storage;
      return Offset(_m[12], _m[13]);
    }

  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  ///
  static Matrix4 setTranslation({
    required Matrix4 matrix,
    required Offset translation,
  }){

    final List<double> _m = matrix.storage;

    final Float64List _list = Float64List.fromList(<double>[
      _m[0],            _m[1],            _m[2],    _m[3],
      _m[4],            _m[5],            _m[6],    _m[7],
      _m[8],            _m[9],            _m[10],   _m[11],
      translation.dx,   translation.dy,   _m[14],   _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 move({
    required Matrix4 matrix,
    required double x,
    required double y,
  }){
    final List<double> _m = matrix.storage;

    final Float64List _list = Float64List.fromList(<double>[
      _m[0],      _m[1],      _m[2],    _m[3],
      _m[4],      _m[5],      _m[6],    _m[7],
      _m[8],      _m[9],      _m[10],   _m[11],
      _m[12]+x,   _m[13]+y,   _m[14],   _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? roundTranslation({
    required Matrix4? matrix,
    required int fractions,
  }){

    if (matrix == null){
      return null;
    }

    else {
      final List<double> _m = matrix.storage;

      final double _x = Numeric.roundFractions(_m[12], fractions)!;
      final double _y = Numeric.roundFractions(_m[13], fractions)!;

      final Float64List _list = Float64List.fromList(<double>[
        _m[0],  _m[1],  _m[2],  _m[3],
        _m[4],  _m[5],  _m[6],  _m[7],
        _m[8],  _m[9],  _m[10],  _m[11],
        _x,     _y,     _m[14],  _m[15],
      ]);

      return Matrix4.fromFloat64List(_list);
    }

  }
  // -----------------------------------------------------------------------------
}
