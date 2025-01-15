import 'dart:typed_data';

import 'package:basics/helpers/nums/numeric.dart';
import 'package:flutter/material.dart';

abstract class NeoMove {
  // --------------------------------------------------------------------------

  /// MOVE

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
  void x(){}
}
