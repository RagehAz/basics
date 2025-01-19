part of trinity;

abstract class NeoBlog {
  // -----------------------------------------------------------------------------

  /// MATRIX

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMatrix({
    required Matrix4? matrix,
    int roundDigits = 7,
    String invoker = '',
  }){
    if (matrix == null){
      blog('BLOGGING MATRIX\nmatrix is null');
    }
    else {

      final int _roundDigits = matrix == Matrix4.identity() ? 0 : roundDigits;
      final List<double> _m = matrix.storage;

      blog('BLOGGING MATRIX : $invoker');

      final String _x00 = Numeric.formatDoubleWithinDigits(value: _m[0],digits: _roundDigits)!;
      final String _x01 = Numeric.formatDoubleWithinDigits(value: _m[1],digits: _roundDigits)!;
      final String _x02 = Numeric.formatDoubleWithinDigits(value: _m[2],digits: _roundDigits)!;
      final String _x03 = Numeric.formatDoubleWithinDigits(value: _m[3],digits: _roundDigits)!;
      final String _x04 = Numeric.formatDoubleWithinDigits(value: _m[4],digits: _roundDigits)!;
      final String _x05 = Numeric.formatDoubleWithinDigits(value: _m[5],digits: _roundDigits)!;
      final String _x06 = Numeric.formatDoubleWithinDigits(value: _m[6],digits: _roundDigits)!;
      final String _x07 = Numeric.formatDoubleWithinDigits(value: _m[7],digits: _roundDigits)!;
      final String _x08 = Numeric.formatDoubleWithinDigits(value: _m[8],digits: _roundDigits)!;
      final String _x09 = Numeric.formatDoubleWithinDigits(value: _m[9],digits: _roundDigits)!;
      final String _x10 = Numeric.formatDoubleWithinDigits(value: _m[10],digits: _roundDigits)!;
      final String _x11 = Numeric.formatDoubleWithinDigits(value: _m[11],digits: _roundDigits)!;
      final String _x12 = Numeric.formatDoubleWithinDigits(value: _m[12],digits: _roundDigits)!;
      final String _x13 = Numeric.formatDoubleWithinDigits(value: _m[13],digits: _roundDigits)!;
      final String _x14 = Numeric.formatDoubleWithinDigits(value: _m[14],digits: _roundDigits)!;
      final String _x15 = Numeric.formatDoubleWithinDigits(value: _m[15],digits: _roundDigits)!;

      const String _s = ' ';
      const String _i = '.';

      blog('00$_i[$_x00]${_s}01$_i[$_x01]${_s}02$_i[$_x02]${_s}03$_i[$_x03]');
      blog('04$_i[$_x04]${_s}05$_i[$_x05]${_s}06$_i[$_x06]${_s}07$_i[$_x07]');
      blog('08$_i[$_x08]${_s}09$_i[$_x09]${_s}10$_i[$_x10]${_s}11$_i[$_x11]');
      blog('12$_i[$_x12]${_s}13$_i[$_x13]${_s}14$_i[$_x14]${_s}15$_i[$_x15]');

    }
  }
  // -----------------------------------------------------------------------------

  /// MATRIX

  // --------------------
  /// TASK : TEST ME
  static void blogRotation({
    required Matrix4? slideMatrix,
    required bool isMatrixFrom,
  }){
    if (slideMatrix != null){
      final double? _radians = NeoRotate.getRotationInRadians(slideMatrix);
      double? _degree = NeoRotate.getRotationInDegrees(slideMatrix);
      _degree = Numeric.roundFractions(_degree, 1);
      blog('isMatrixFrom($isMatrixFrom).angle($_degree).radians($_radians)');
    }
  }
  // -----------------------------------------------------------------------------
}
