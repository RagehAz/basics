part of bubble;

class BubbleScale {
  // -----------------------------------------------------------------------------

  const BubbleScale();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const double marginValue = Ratioz.appBarMargin;
  static const double bothMarginsValue = marginValue * 2;
  // --------------------
  static const double paddingValue = Ratioz.appBarPadding;
  static const double bothPaddingsValue = paddingValue * 2;
  // --------------------
  static const double cornersValue = Ratioz.appBarCorner;
  static const double clearCornersValue = cornersValue - paddingValue;
  // -----------------------------------------------------------------------------

  /// WIDTHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double bubbleWidth({
    required BuildContext context,
    double? bubbleWidthOverride
  }) {

    if (bubbleWidthOverride == null){

      return Scale.responsive(
        context: context,
        landscape: Scale.screenShortestSide(context) - bothMarginsValue,
        portrait: Scale.screenWidth(context) - bothMarginsValue,
      );

    }

    else {
      return bubbleWidthOverride;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double clearWidth({
    required BuildContext context,
    double? bubbleWidthOverride,
  }) {
    final double _bubbleWidth = bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );
    return _bubbleWidth - bothPaddingsValue;
  }
  // -----------------------------------------------------------------------------

  /// HEIGHTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeightWithoutChildren({
    required double headlineHeight,
  }){

    final double _headlineMargin = headlineHeight == 0 ? 0 : paddingValue;
    final double _totalSpacings = bothPaddingsValue + _headlineMargin;

    return _totalSpacings + headlineHeight;
  }
  // --------------------
  /*
  static double _getTitleHeight(BuildContext context){
    const int _titleVerseSize = 2;
    return SuperVerse.superVerseRealHeight(
      context: context,
      size: _titleVerseSize,
      sizeFactor: 1,
      hasLabelBox: false,
    );
  }
   */
  // -----------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(cornersValue));
  // --------------------
  static const BorderRadius clearCorners = BorderRadius.all(Radius.circular(clearCornersValue));
  // -----------------------------------------------------------------------------
  void x(){}
}
