import 'package:flutter/material.dart';

abstract class Aligner {
  // -----------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment top({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.topRight : Alignment.topLeft;
    }

    else {
      return inverse == true ? Alignment.topLeft : Alignment.topRight;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment center({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.centerRight : Alignment.centerLeft;
    }

    else {
      return inverse == true ? Alignment.centerLeft : Alignment.centerRight;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment bottom({
    required bool appIsLTR,
    bool inverse = false,
  }) {

    if (appIsLTR == true) {
      return inverse == true ? Alignment.bottomRight : Alignment.bottomLeft;
    }

    else {
      return inverse == true ? Alignment.bottomLeft : Alignment.bottomRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// POSITION IN LEFT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightOffsetInLeftAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromRight,
  }) {
    double? _rightOffset;

    /// WHEN LEFT TO RIGHT
    if (appIsLTR == true) {
      /// right offset position should be programmatic
      _rightOffset = null;
    }

    /// WHEN RIGHT IN LEFT
    else {
      /// right offset position should have the offset value
      _rightOffset = offsetFromRight;
    }

    return _rightOffset;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftOffsetInLeftAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromLeft,
  }) {
    /// gets [left position] of object that [aligns left] when app is english (LTR)
    double? _leftOffset;

    /// when in English
    if (appIsLTR == true) {
      /// left offset position should have the offset value
      _leftOffset = offsetFromLeft;
    }

    /// when in Arabic
    else {
      /// left offset position should be programmatic
      _leftOffset = null;
    }

    return _leftOffset;
  }
  // -----------------------------------------------------------------------------

  /// POSITION IN RIGHT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightOffsetInRightAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromRight,
  }) {
    /// gets [right position] of object that [aligns right] when app is english (LTR)
    return leftOffsetInLeftAlignmentEn(
      appIsLTR: appIsLTR,
      offsetFromLeft: offsetFromRight,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftOffsetInRightAlignmentEn({
    required bool appIsLTR,
    required double? offsetFromLeft,
  }) {
    /// gets [left position] of object that [aligns right] when app is english (LTR)
    return rightOffsetInLeftAlignmentEn(
      appIsLTR: appIsLTR,
      offsetFromRight: offsetFromLeft,
    );

  }
  // -----------------------------------------------------------------------------
}
