import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:flutter/material.dart';

abstract class Borderers {
  // -----------------------------------------------------------------------------
  /// TASK : use clipBehaviour : Clip.antiAliasWithSaveLayer instead of ClipRRect
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const BorderRadius constantCornersAll5 = BorderRadius.all(Radius.circular(5));
  static const BorderRadius constantCornersAll10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius constantCornersAll12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius constantCornersAll15 = BorderRadius.all(Radius.circular(15));
  static const BorderRadius constantCornersAll20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius constantCornersAll30 = BorderRadius.all(Radius.circular(30));
  static const BorderRadius constantCornersAll40 = BorderRadius.all(Radius.circular(40));
  // -----------------------------------------------------------------------------

  /// BORDER RADIUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerOnly({
    required bool appIsLTR,
    double? enTopLeft,
    double? enBottomLeft,
    double? enBottomRight,
    double? enTopRight
  }) {
    return appIsLTR == false ?
    BorderRadius.only(
      topLeft: Radius.circular(enTopRight ?? 0),
      topRight: Radius.circular(enTopLeft ?? 0),
      bottomLeft: Radius.circular(enBottomRight ?? 0),
      bottomRight: Radius.circular(enBottomLeft ?? 0),
    )
        :
    BorderRadius.only(
      topLeft: Radius.circular(enTopLeft ?? 0),
      topRight: Radius.circular(enTopRight ?? 0),
      bottomLeft: Radius.circular(enBottomLeft ?? 0),
      bottomRight: Radius.circular(enBottomRight ?? 0),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // -----------------------------------------------------------------------------

  /// OUTLINE BORDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static OutlineInputBorder outlines(Color borderColor, double corner) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corner),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
  // -----------------------------------------------------------------------------

  /// SHAPES

  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius shapeOfLogo({
    required bool appIsLTR,
    required double corner,
    bool zeroCornerEnIsRight = true,
  }) {

    final BorderRadius _superLogoShape = zeroCornerEnIsRight ?
    cornerOnly(
      appIsLTR: appIsLTR,
      enBottomLeft: corner,
      enBottomRight: 0,
      enTopLeft: corner,
      enTopRight: corner,
    )
        :
    cornerOnly(
      appIsLTR: appIsLTR,
      enBottomLeft: 0,
      enBottomRight: corner,
      enTopLeft: corner,
      enTopRight: corner,
    );

    return _superLogoShape;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius shapeOfOneSideCorners({
    required bool appIsLTR,
    required AxisDirection side,
    required double corner
  }) {
    switch (side) {
      case AxisDirection.up:
        return cornerOnly(
          appIsLTR: appIsLTR,
          enTopLeft: corner,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: 0,
        );

      case AxisDirection.down:
        return cornerOnly(
          appIsLTR: appIsLTR,
          enTopLeft: 0,
          enTopRight: 0,
          enBottomLeft: corner,
          enBottomRight: corner,
        );

      case AxisDirection.right:
        return cornerOnly(
          appIsLTR: appIsLTR,
          enTopLeft: 0,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: corner,
        );

      case AxisDirection.left:
        return cornerOnly(
          appIsLTR: appIsLTR,
          enTopLeft: corner,
          enTopRight: 0,
          enBottomLeft: corner,
          enBottomRight: 0,
        );

    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getCornersAsDouble(dynamic corners) {
    double? _topLeftCorner = 0;

    if (corners != null){

      if (corners.runtimeType == BorderRadius) {
        final BorderRadius? _cornerBorders = corners;
        final Radius? _topLeftCornerRadius = _cornerBorders?.topLeft;
        _topLeftCorner = _topLeftCornerRadius?.x;
        // print('_topLeftCorner : $_topLeftCorner');
      }

      else {
        _topLeftCorner = corners?.toDouble();
      }


    }

    return _topLeftCorner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCornersAsBorderRadius(dynamic corners) {
    BorderRadius _cornerBorders;

    if (corners == 0) {
      _cornerBorders = BorderRadius.zero;
    }

    else if (corners.runtimeType == BorderRadius) {
      _cornerBorders = corners;
    }

    else {
      _cornerBorders = cornerAll(corners?.toDouble());
    }

    return _cornerBorders;
  }
  // -----------------------------------------------------------------------------

  /// BORDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Border? borderSimple(Color? color){
    return color == null || color == Colorz.nothing ? null : Border.all(
      width: 0.5,
      color: color,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Border? borderThick(Color? color, double thickness){
    return color == null || color == Colorz.nothing ? null : Border.all(
      width: thickness,
      color: color,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Border? borderOnly({
    Color? color,
    bool enLeft = false,
    bool enRight = false,
    bool top = false,
    bool bottom = false,
    bool appIsLTR = true,
  }){

    if (color == null || color == Colorz.nothing || color == Colorz.black0){
      return null;
    }
    else {

      BorderSide _getBorder(bool isOn){
        return BorderSide(
          // style: BorderStyle.solid,
          width: 0.5,
          color: color,
          strokeAlign: BorderSide.strokeAlignOutside,
        );
      }

      return Border(
        top: _getBorder(top),
        bottom: _getBorder(bottom),
        left: appIsLTR ? _getBorder(enLeft) : _getBorder(enRight),
        right: appIsLTR ? _getBorder(enRight) : _getBorder(enLeft),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
