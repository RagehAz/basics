import 'dart:math';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:flutter/material.dart';

abstract class NeoRotate {
  // --------------------------------------------------------------------------

  /// ROTATION

  // --------------------
    /// TESTED : WORKS PERFECT
  static double? getRotationInDegrees(Matrix4? matrix) {

    if (matrix == null){
      return null;
    }
    else {
      final double radians = getRotationInRadians(matrix)!;
      final double _deg = Numeric.radianToDegree(radians)!;
      return Numeric.limit360DegreeTo360(_deg)!;
    }

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
  // -----------------------------------------------------------------------------
  void x(){}
}
