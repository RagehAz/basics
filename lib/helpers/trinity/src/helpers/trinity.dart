part of trinity;
/// => TAMAM
abstract class Trinity {
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double>? cipherMatrix(Matrix4? matrix){
    return matrix?.storage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4? decipherMatrix(List<dynamic>? doubles){
    Matrix4? _matrix;

    if (doubles != null) {
      final List<double>? _doubles = _getDoublesFromDynamics(doubles);

      if (_doubles != null && _doubles.length == 16) {
        _matrix = Matrix4.fromList(_doubles);
      }
    }

    return _matrix;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double> _getDoublesFromDynamics(List<dynamic>? dynamics){

    final List<double> _output = <double>[];

    if (Lister.checkCanLoop(dynamics) == true){

      for (final dynamic dyn in dynamics!){

        if (dyn is double){
          final double _double = dyn;
          _output.add(_double);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT : adjust Matrix Translation To Be In Ratio to flyer box sizes
  static Matrix4? generateSlideMatrix({
    required Matrix4? matrix,
    required double? flyerBoxWidth,
    required double? flyerBoxHeight,
  }){

    if (matrix != null && flyerBoxWidth != null && flyerBoxHeight != null){
      /// matrix is received with translation values in pixels
      final List<double> _m = matrix.storage;

      /// translation values in pixels
      final double _xTranslation = _m[12]; // this is in pixels
      final double _yTranslation = _m[13]; // this is in pixels

      /// translation value in Ratios to flyer sizes
      // final double _x = _xTranslation / flyerBoxWidth;
      final double _x = Numeric.divide(dividend: _xTranslation, divisor: flyerBoxWidth);
      // final double _y = _yTranslation / flyerBoxHeight;
      final double _y = Numeric.divide(dividend: _yTranslation, divisor: flyerBoxHeight);

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
  // --------------------
  /// TESTED : WORKS PERFECT : adjust Matrix Translation To Be In pixels
  static Matrix4? renderSlideMatrix({
    required Matrix4? matrix,
    required double? flyerBoxWidth,
    required double? flyerBoxHeight,
  }){

    if (matrix != null && flyerBoxWidth != null && flyerBoxHeight != null){
      /// matrix is received with translation values are ratios to flyer sizes
      final List<double> _m = matrix.storage;

      /// translation values in ratios
      final double _xTranslation = _m[12]; // this is in ratios
      final double _yTranslation = _m[13]; // this is in ratios

      /// translation value in Ratios to flyer sizes
      final double _x = _xTranslation * flyerBoxWidth;
      final double _y = _yTranslation * flyerBoxHeight;

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 slightlyZoomed({
    required double flyerBoxWidth,
    required double flyerBoxHeight,
    double scale = 1.2
  }){

    double _xTranslation = ((flyerBoxWidth * scale) - flyerBoxWidth) / 2;
    _xTranslation = Numeric.roundFractions(_xTranslation, 2)!;
    double _yTranslation = ((flyerBoxHeight * scale) - flyerBoxHeight) / 2;
    _yTranslation = Numeric.roundFractions(_yTranslation, 2)!;

    final Float64List _list = Float64List.fromList(<double>[
      scale,              0,                0,    0,
      0,                  scale,            0,    0,
      0,                  0,                1,    0,
      -_xTranslation,    -_yTranslation,    0,    1,
    ]);

    final Matrix4 _matrix = Matrix4.fromFloat64List(_list);

    return generateSlideMatrix(
      matrix: _matrix,
      flyerBoxWidth: flyerBoxWidth,
      flyerBoxHeight: flyerBoxHeight,
    )!;

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMatrixesAreIdentical({
    required Matrix4? matrix1,
    required Matrix4? matrixReloaded,
  }){

    if (matrix1 == null && matrixReloaded == null){
      return true;
    }

    else if (matrix1 == null || matrixReloaded == null){
      return false;
    }

    else {
      final List<double> _a = matrix1.storage;
      final List<double> _b = matrixReloaded.storage;
      return Lister.checkListsAreIdentical(list1: _a, list2: _b);
    }

  }
  // --------------------
  /*

                    // blog('matrix sent flyerWidth : $_flyerBoxWidth : flyerHeight : $_flyerBoxHeight -');
                    // blog(m.row0);
                    // blog(m.row1);
                    // blog(m.row2);
                    // blog(m.row3);
                    //
                    // blog(m.storage);

                    // final List<double> _m = m.storage;
                    //
                    // final double _xTranslation = _m[12]; // this is in pixels
                    // final double _yTranslation = _m[13]; // this is in pixels
                    //
                    // /// in Ratios to flyerWidth
                    // final double _x = _xTranslation / _flyerBoxWidth;
                    // final double _y = _yTranslation / _flyerBoxHeight;
                    //
                    // final Float64List _list = Float64List.fromList([
                    //   _m[0],  _m[1],  _m[2],  _m[3],
                    //   _m[4],  _m[5],  _m[6],  _m[7],
                    //   _m[8],  _m[9],  _m[10], _m[11],
                    //   _x,     _y,     _m[14], _m[15]
                    // ]);

                    // blog(m.)

                    NOTE : remember that (0.0) origin is in top left corner
                            +x goes right
                            +y goes down

                    t : translation - r : rotation - s : scale
                    x: x axis
                    y: y axis
                    z: z axis
                    a: all axes

                    [0]   [xs]  [__]  [__]  [xt]
                    [1]   [__]  [ys]  [__]  [yt]
                    [2]   [__]  [__]  [zs]  [__]
                    [3]   [__]  [__]  [__]  [1/as]



          [00][scaleX]        [01][skewXY]       [02][pDistortX]       [03][translationX]
          [04][skewYX]        [05][scaleY]       [06][pDistortY]       [07][translationY]
          [08][skewZX]        [09][skewZY]       [10][scaleZ]          [11][translationZ]
          [12][pCorrectX]     [13][pCorrectY]    [14][pCorrectZ]       [15][1/sizeFactor]


                     */
  // -----------------------------------------------------------------------------

  /// CURVES CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherAnimationCurve(Curve? curve){

    switch (curve){

      case Curves.ease : return 'ease';

      case Curves.easeIn : return 'easeIn';
      case Curves.easeInSine : return 'easeInSine';
      case Curves.easeInQuad : return 'easeInQuad';
      case Curves.easeInCubic : return 'easeInCubic';
      case Curves.easeInQuart : return 'easeInQuart';
      case Curves.easeInQuint : return 'easeInQuint';
      case Curves.easeInExpo : return 'easeInExpo';
      case Curves.easeInCirc : return 'easeInCirc';
      case Curves.easeInBack : return 'easeInBack';

      case Curves.easeInOut : return 'easeInOut';
      case Curves.easeInOutSine : return 'easeInOutSine';
      case Curves.easeInOutQuad : return 'easeInOutQuad';
      case Curves.easeInOutCubic : return 'easeInOutCubic';
      case Curves.easeInOutQuart : return 'easeInOutQuart';
      case Curves.easeInOutQuint : return 'easeInOutQuint';
      case Curves.easeInOutExpo : return 'easeInOutExpo';
      case Curves.easeInOutCirc : return 'easeInOutCirc';
      case Curves.easeInOutBack : return 'easeInOutBack';
      case Curves.easeInOutCubicEmphasized : return 'easeInOutCubicEmphasized';

      case Curves.easeInToLinear : return 'easeInToLinear';

      case Curves.easeOut : return 'easeOut';
      case Curves.easeOutSine : return 'easeOutSine';
      case Curves.easeOutQuad : return 'easeOutQuad';
      case Curves.easeOutCubic : return 'easeOutCubic';
      case Curves.easeOutQuart : return 'easeOutQuart';
      case Curves.easeOutQuint : return 'easeOutQuint';
      case Curves.easeOutExpo : return 'easeOutExpo';
      case Curves.easeOutCirc : return 'easeOutCirc';
      case Curves.easeOutBack : return 'easeOutBack';

      case Curves.linear : return 'linear';
      case Curves.linearToEaseOut : return 'linearToEaseOut';

      case Curves.slowMiddle : return 'slowMiddle';

      case Curves.bounceOut : return 'bounceOut';
      case Curves.bounceIn : return 'bounceIn';
      case Curves.bounceInOut : return 'bounceInOut';

      case Curves.elasticInOut : return 'elasticInOut';
      case Curves.elasticIn : return 'elasticIn';
      case Curves.elasticOut : return 'elasticOut';
      
      case Curves.decelerate : return 'decelerate';
      
      case Curves.fastLinearToSlowEaseIn : return 'fastLinearToSlowEaseIn';
      case Curves.fastOutSlowIn : return 'fastOutSlowIn';
      case Curves.fastEaseInToSlowEaseOut : return 'fastEaseInToSlowEaseOut';

      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Curve? decipherAnimationCurve(String? curve){

    switch(curve){

      case 'ease': return Curves.ease;

      case 'easeIn': return Curves.easeIn;
      case 'easeInSine': return Curves.easeInSine;
      case 'easeInQuad': return Curves.easeInQuad;
      case 'easeInCubic': return Curves.easeInCubic;
      case 'easeInQuart': return Curves.easeInQuart;
      case 'easeInQuint': return Curves.easeInQuint;
      case 'easeInExpo': return Curves.easeInExpo;
      case 'easeInCirc': return Curves.easeInCirc;
      case 'easeInBack': return Curves.easeInBack;

      case 'easeInToLinear': return Curves.easeInToLinear;

      case 'easeInOut': return Curves.easeInOut;
      case 'easeInOutSine': return Curves.easeInOutSine;
      case 'easeInOutQuad': return Curves.easeInOutQuad;
      case 'easeInOutCubic': return Curves.easeInOutCubic;
      case 'easeInOutQuart': return Curves.easeInOutQuart;
      case 'easeInOutQuint': return Curves.easeInOutQuint;
      case 'easeInOutExpo': return Curves.easeInOutExpo;
      case 'easeInOutCirc': return Curves.easeInOutCirc;
      case 'easeInOutBack': return Curves.easeInOutBack;
      case 'easeInOutCubicEmphasized': return Curves.easeInOutCubicEmphasized;

      case 'easeOut': return Curves.easeOut;
      case 'easeOutSine': return Curves.easeOutSine;
      case 'easeOutQuad': return Curves.easeOutQuad;
      case 'easeOutCubic': return Curves.easeOutCubic;
      case 'easeOutQuart': return Curves.easeOutQuart;
      case 'easeOutQuint': return Curves.easeOutQuint;
      case 'easeOutExpo': return Curves.easeOutExpo;
      case 'easeOutCirc': return Curves.easeOutCirc;
      case 'easeOutBack': return Curves.easeOutBack;

      case 'linear': return Curves.linear;
      case 'linearToEaseOut': return Curves.linearToEaseOut;

      case 'slowMiddle': return Curves.slowMiddle;

      case 'bounceOut': return Curves.bounceOut;
      case 'bounceIn': return Curves.bounceIn;
      case 'bounceInOut': return Curves.bounceInOut;

      case 'elasticInOut': return Curves.elasticInOut;
      case 'elasticIn': return Curves.elasticIn;
      case 'elasticOut': return Curves.elasticOut;

      case 'decelerate': return Curves.decelerate;

      case 'fastLinearToSlowEaseIn': return Curves.fastLinearToSlowEaseIn;
      case 'fastOutSlowIn': return Curves.fastOutSlowIn;
      case 'fastEaseInToSlowEaseOut': return Curves.fastEaseInToSlowEaseOut;

      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<Curve> curves = [

    Curves.ease,

    Curves.easeIn,
    Curves.easeInSine,
    Curves.easeInQuad,
    Curves.easeInCubic,
    Curves.easeInQuart,
    Curves.easeInQuint,
    Curves.easeInExpo,
    Curves.easeInCirc,
    Curves.easeInBack,

    Curves.easeInOut,
    Curves.easeInOutSine,
    Curves.easeInOutQuad,
    Curves.easeInOutCubic,
    Curves.easeInOutQuart,
    Curves.easeInOutQuint,
    Curves.easeInOutExpo,
    Curves.easeInOutCirc,
    Curves.easeInOutBack,
    Curves.easeInOutCubicEmphasized,

    Curves.easeInToLinear,

    Curves.easeOut,
    Curves.easeOutSine,
    Curves.easeOutQuad,
    Curves.easeOutCubic,
    Curves.easeOutQuart,
    Curves.easeOutQuint,
    Curves.easeOutExpo,
    Curves.easeOutCirc,
    Curves.easeOutBack,

    Curves.linear,
    Curves.linearToEaseOut,

    Curves.slowMiddle,

    Curves.bounceOut,
    Curves.bounceIn,
    Curves.bounceInOut,

    Curves.elasticInOut,
    Curves.elasticIn,
    Curves.elasticOut,

    Curves.decelerate,

    Curves.fastLinearToSlowEaseIn,
    Curves.fastOutSlowIn,
    Curves.fastEaseInToSlowEaseOut,

  ];
  // -----------------------------------------------------------------------------
}
