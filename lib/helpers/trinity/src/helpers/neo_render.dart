part of trinity;
/// => TAMAM
abstract class NeoRender {
  // -----------------------------------------------------------------------------

  /// TO VIEW

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? toView({
    required Matrix4? normalMatrix,
    required double? canvasWidth,
    required double? canvasHeight,
  }) {

    /// adjusts Matrix Translation To Be In pixels

    if (normalMatrix != null && canvasWidth != null && canvasHeight != null){
      /// matrix is received with translation values are ratios to flyer sizes
      final List<double> _m = normalMatrix.storage;

      /// translation values in ratios
      final double _xTranslation = _m[12]; // this is in ratios
      final double _yTranslation = _m[13]; // this is in ratios

      /// translation value in Ratios to flyer sizes
      final double _x = _xTranslation * canvasWidth;
      final double _y = _yTranslation * canvasHeight;

      final Float64List _list = Float64List.fromList(<double>[
        _m[0],  _m[1],  _m[2],  _m[3],
        _m[4],  _m[5],  _m[6],  _m[7],
        _m[8],  _m[9],  _m[10], _m[11],
        _x,     _y,     _m[14], _m[15]
      ]);

      return Matrix4.fromFloat64List(_list);
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// TO SLIDE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? toNormal({
    required Matrix4? viewMatrix,
    required double? canvasWidth,
    required double? canvasHeight,
  }){

    /// adjusts Matrix Translation To Be In Ratio to flyer box sizes

    if (viewMatrix != null && canvasWidth != null && canvasHeight != null){
      /// matrix is received with translation values in pixels
      final List<double> _m = viewMatrix.storage;

      /// translation values in pixels
      final double _xTranslation = _m[12]; // this is in pixels
      final double _yTranslation = _m[13]; // this is in pixels

      /// translation value in Ratios to flyer sizes
      // final double _x = _xTranslation / flyerBoxWidth;
      final double _x = Numeric.divide(dividend: _xTranslation, divisor: canvasWidth);
      // final double _y = _yTranslation / flyerBoxHeight;
      final double _y = Numeric.divide(dividend: _yTranslation, divisor: canvasHeight);

      final Float64List _list = Float64List.fromList(<double>[
        _m[0],  _m[1],  _m[2],  _m[3],
        _m[4],  _m[5],  _m[6],  _m[7],
        _m[8],  _m[9],  _m[10], _m[11],
        _x,     _y,     _m[14], _m[15]
      ]);

      return Matrix4.fromFloat64List(_list);
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// ZOOMED NORMAL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 zoomedViewMatrix({
    required double canvasWidth,
    required double canvasHeight,
    double scale = 1.2
  }){

    double _xTranslation = ((canvasWidth * scale) - canvasWidth) / 2;
    _xTranslation = Numeric.roundFractions(_xTranslation, 2)!;
    double _yTranslation = ((canvasHeight * scale) - canvasHeight) / 2;
    _yTranslation = Numeric.roundFractions(_yTranslation, 2)!;

    final Float64List _list = Float64List.fromList(<double>[
      scale,              0,                0,    0,
      0,                  scale,            0,    0,
      0,                  0,                1,    0,
      -_xTranslation,    -_yTranslation,    0,    1,
    ]);

    final Matrix4 _matrix = Matrix4.fromFloat64List(_list);

    return _matrix;
  }
  // -----------------------------------------------------------------------------
}
