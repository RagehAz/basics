import 'package:flutter/material.dart';

/// => TAMAM
class Scale {
  // -----------------------------------------------------------------------------

  const Scale();

  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
    // return MediaQuery.of(context).size.width;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenHeight(BuildContext context) {

    // print('screenHeight : top(${MediaQuery.paddingOf(context).top}) bottom(${MediaQuery.paddingOf(context).bottom})');


    return    MediaQuery.sizeOf(context).height
            - MediaQuery.paddingOf(context).top
            - MediaQuery.paddingOf(context).bottom;

    // return    MediaQuery.of(context).size.height
    //         - MediaQuery.of(context).padding.top
    //         - MediaQuery.of(context).padding.bottom;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenHeightGross(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
    // return MediaQuery.of(context).size.height;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static double superScreenHeightWithoutSafeArea(BuildContext context) {
    return screenHeight(context) - superSafeAreaTopPadding(context);
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenShortestSide(BuildContext context){

    final bool _isLandscape = isLandScape(context);

    if (_isLandscape == true) {
      return MediaQuery.sizeOf(context).height;
      // return MediaQuery.of(context).size.height;
    }

    else {
      return MediaQuery.sizeOf(context).width;
      // return MediaQuery.of(context).size.width;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenLongestSide(BuildContext context){

    final bool _isLandscape = isLandScape(context);

    if (_isLandscape == true) {
      return MediaQuery.sizeOf(context).width;
      // return MediaQuery.of(context).size.width;
    }

    else {
      return MediaQuery.sizeOf(context).height;
      // return MediaQuery.of(context).size.height;
    }

  }
  // -----------------------------------------------------------------------------

  /// ADAPTIVE

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isLandScape(BuildContext context){
    return MediaQuery.orientationOf(context) == Orientation.landscape;
    // return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double responsive({
    required BuildContext context,
    required double? landscape,
    required double? portrait,
  }){

    if (landscape == null || portrait == null){
      return 0;
    }
    else {

      final bool _isLandscape = isLandScape(context);

      if (_isLandscape == true){
        return landscape;
      }
      else {
        return portrait;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double adaptiveWidth(BuildContext context, double? ratio){

    if (ratio == null){
      return 0;
    }
    else {
      return screenWidth(context) * ratio;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double adaptiveHeight(BuildContext context, double? ratio){

    if (ratio == null){
      return 0;
    }
    else {
      return screenHeight(context) * ratio;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superWidth(BuildContext context, double? ratio){

    if (ratio != null) {
      return Scale.responsive(
        context: context,
        landscape: Scale.adaptiveHeight(context, ratio),
        portrait: Scale.adaptiveWidth(context, ratio),
      );
    }

    else {
      return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static double superSafeAreaTopPadding(BuildContext context) {
    return MediaQuery.paddingOf(context).top;
    // return MediaQuery.of(context).padding.top;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superInsets({ // clean all trances to become constants
    required BuildContext context,
    required bool appIsLTR,
    double bottom = 0,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
  }) {

    if (appIsLTR == true){
      return EdgeInsets.only(
          left: enLeft,
          right: enRight,
          bottom: bottom,
          top: top
      );
    }

    else {
      return EdgeInsets.only(
          bottom: bottom,
          left: enRight,
          right: enLeft,
          top: top
      );
    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static EdgeInsets superPadding({
    required BuildContext context,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
    double bottom = 0,
  }) {

    if (TextDir.checkAppIsLeftToRight(context) == true){
      return EdgeInsets.only(
          left: enLeft,
          right: enRight,
          bottom: bottom,
          top: top,
      );
    }

    else {
      return EdgeInsets.only(
          left: enRight,
          right: enLeft,
          top: top,
          bottom: bottom,
      );
    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superMargins({dynamic margin}) {

    if (margin == null || margin == 0){
      return EdgeInsets.zero;
    }

    else if (margin.runtimeType == double){
      return EdgeInsets.all(margin);
    }

    else if (margin.runtimeType == int){
      return EdgeInsets.all(margin.toDouble());
    }

    else if (margin.runtimeType == EdgeInsets){
      return margin;
    }

    else {
      return margin;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double superDeviceRatio(BuildContext context) {
    return MediaQuery.sizeOf(context).aspectRatio;
    // return MediaQuery.of(context).size.aspectRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double devicePixelRatio(BuildContext context) {
    // return MediaQuery.of(context).devicePixelRatio,
    return MediaQuery.devicePixelRatioOf(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets screenInsets(BuildContext context){
    return MediaQuery.viewInsetsOf(context);
    // return MediaQuery.of(context).viewInsets;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Size screenSize(BuildContext context){
    return MediaQuery.sizeOf(context);
    // return MediaQuery.of(context).size;
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const EdgeInsets constantMarginsAll5 = EdgeInsets.all(5);
  static const EdgeInsets constantMarginsAll10 = EdgeInsets.all(10);
  static const EdgeInsets constantMarginsAll20 = EdgeInsets.all(20);
  // --------------------
  static const EdgeInsets constantHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets constantHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  // -----------------------------------------------------------------------------

  /// DIVISION

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getUniformRowItemWidth({
    required int? numberOfItems,
    required double? boxWidth,
    double spacing = 10,
    bool considerMargins = true,
  }) {

    /// this concludes item width after dividing screen width over number of items
    /// while considering 10 pixels spacing between them

    double _width = 0;

    if (numberOfItems != null && boxWidth != null){

      /// has side margins same as spacing
      if (considerMargins == true){
        _width = (boxWidth - (spacing * (numberOfItems + 1))) / numberOfItems;
      }

      /// has no side margins
      else {
        _width = (boxWidth - (spacing * (numberOfItems - 1))) / numberOfItems;
      }

    }

    return _width;
  }
  // -----------------------------------------------------------------------------
}
