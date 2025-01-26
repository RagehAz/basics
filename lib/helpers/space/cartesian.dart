import 'package:basics/helpers/maps/lister.dart';
import 'package:flutter/material.dart';

abstract class Cartesian {
  // -----------------------------------------------------------------------------

  /// TOP MOST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset? getTopMostPoint({
    required List<Offset> points,
  }) {
    Offset? _output;

    if (Lister.checkCanLoop(points) == true){

      _output = points.first;

      Lister.loopSync(
          models: points,
          onLoop: (int index, Offset? point) {
            if (point != null){

              final bool _isBigger = point.dy < (_output?.dy ?? 0);

              if (_isBigger == true){
                _output = point;
              }

            }
          }
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BOTTOM MOST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset? getBottomMostPoint({
    required List<Offset> points,
  }) {
    Offset? _output;

    if (Lister.checkCanLoop(points) == true){

      _output = points.first;

      Lister.loopSync(
          models: points,
          onLoop: (int index, Offset? point) {
            if (point != null){

              final bool _isSmaller = point.dy > (_output?.dy ?? 0);

              if (_isSmaller == true){
                _output = point;
              }

            }
          }
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// RIGHT MOST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset? getRightMostPoint({
    required List<Offset> points,
  }){
    Offset? _output;

    if (Lister.checkCanLoop(points) == true){

      _output = points.first;

      Lister.loopSync(
          models: points,
          onLoop: (int index, Offset? point) {
            if (point != null){

              final bool _isRighter = point.dx > (_output?.dx ?? 0);

              if (_isRighter == true){
                _output = point;
              }

            }
          }
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// LEFT MOST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Offset? getLeftMostPoint({
    required List<Offset> points,
  }){
    Offset? _output;

    if (Lister.checkCanLoop(points) == true){

      _output = points.first;

      Lister.loopSync(
          models: points,
          onLoop: (int index, Offset? point) {
            if (point != null){

              final bool _isLefter = point.dx < (_output?.dx ?? 0);

              if (_isLefter == true){
                _output = point;
              }

            }
          }
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
