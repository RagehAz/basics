import 'dart:math' as math;
import 'package:basics/helpers/nums/numeric.dart';

/// => AI TESTED
abstract class Trigonometer {
  // -----------------------------------------------------------------------------
  static const double minDegree = 0.001;
  static const int maxFractions = 4;
  // -----------------------------------------------------------------------------

  /// DEGREE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? radianToDegree(double? radians) {
    if (radians == null) {
      return null;
    }
    else {
      return cleanDegree(radians * (180 / math.pi));
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? radianTo360Degree(double? radians) {

    double? _degree360;
    final double? _plusMinusDegree = radianToDegree(radians);

    if (_plusMinusDegree == null){
      // _degree360 = null;
    }
    else if (_plusMinusDegree < 0){
      _degree360 = 360 + _plusMinusDegree;
    }
    else {
      _degree360 = _plusMinusDegree;
    }

    return limit360DegreeTo360(_degree360);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? limit360DegreeTo360(double? degree){
    double? _output;

    if (degree != null){

      /// so degree might be 1500ᴼ
      /// which is (360ᴼ * 4) + 100ᴼ
      /// = (360ᴼ * numberOfMultiples) + (degree - (360ᴼ * numberOfMultiples))
      /// = _multipleLoops + (degree - _multipleLoops)
      final int numberOfMultiples = (degree / 360).floor();
      final int _multipleLoops = 360 * numberOfMultiples;
      _output = degree - _multipleLoops;
      _output = cleanDegree(_output);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? degreeTo360Degree(double? degree) {
    double? _output;

    if (degree != null){

      _output = cleanDegree(degree);

      if (_output < 0){
        _output = 360 + _output;
      }

      else {
        _output = _output;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RADIANS

  // --------------------
  /// AI TESTED
  static double? degreeToRadian(double? degree){
    /// remember that dart starts from angle 0 on the right,, rotates clockWise when
    /// incrementing the angle degree,, while rotates counter clockwise when decrementing
    /// the angle degree.
    /// simply, Negative value goes counter ClockWise
    if (degree == null){
      return null;
    }
    else {
      return cleanDegree(degree) * ( math.pi / 180 );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double cleanDegree(double degree){
    return Numeric.roundFractions(degree, maxFractions)!;
  }
  // -----------------------------------------------------------------------------

  /// PYTHAGORAS

  // --------------------
  /// AI TESTED
  static double? pythagorasHypotenuse({
    required double? side,
    double? side2,
  }) {

    if (side == null){
      return null;
    }

    else {
      /// side^2 * side^2 = hypotenuse^2
      final double _side2 = side2 ?? side;
      final double _sideSquared = Numeric.calculateDoublePower(num: side, power: 2);
      final double _side2Squared = Numeric.calculateDoublePower(num: _side2, power: 2);
      return math.sqrt(_sideSquared + _side2Squared);
    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// AI TESTED
  static double? move360Degree({
    required double? source360Degree,
    required double? moveBy360Degree,
  }) {

    if (source360Degree == null || moveBy360Degree == null) {
      return null;
    }

    else {

      final double _after = source360Degree + moveBy360Degree;

      if (_after < 0) {
        return 360 - (-_after % 360); // Correct the result for negative values
      }

      else if (_after >= 360) {
        return _after % 360; // Correct the result for values >= 360
      }

      else {
        return _after;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double snapToNearestAngle({
    required double degree,
    double threshold = 5.0
  }) {

    double _output = limit360DegreeTo360(degree)!;

    const snapAngles = [-360, -270, -180, -90, 0, 90, 180, 270, 360];

    for (final snapAngle in snapAngles) {

      final bool _isNear = (degree - snapAngle).abs() <= threshold;

      if (_isNear == true) {
        _output = snapAngle.toDouble();
        break;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
