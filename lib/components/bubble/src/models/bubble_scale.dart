part of bubble;
/// => TAMAM
abstract class BubbleScale {
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
  // --------------------
  static const Color color = Colorz.white10;
  static const Color splashColor = Colorz.white20;
  static const Color textColor = Colorz.white255;
  static const Color secondLineColor = Colorz.white125;
  // --------------------
  static const double headerButtonSize = 30; /// delete me 5alas (im in BubbleHeader class)
  static const double switcherButtonWidth = 50;
  static const double verseBottomMargin = 5;
  // --------------------
  static const EdgeInsets bottomFive = EdgeInsets.only(bottom: 5);
  static const EdgeInsets bottomTen = EdgeInsets.only(bottom: 10);
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static double childWidth({
    required BuildContext context,
    double? bubbleWidthOverride,
  }) {

    final double _bubbleWidth = BubbleScale.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );

    return _bubbleWidth - headerButtonSize - BubbleScale.bothPaddingsValue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double headlineWidth({
    required BuildContext context,
    required bool hasLeadingIcon,
    required bool hasSwitch,
    required bool hasMoreButton,
    double? bubbleWidthOverride,
  }){

    final double _bubbleWidth = BubbleScale.bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );

    final double _leadingIconWidth = hasLeadingIcon == true ? headerButtonSize : 0;

    final double _switcherWidth = hasSwitch == true ? switcherButtonWidth : 0;

    final double _moreButtonWidth = hasMoreButton == true ? headerButtonSize + paddingValue : 0;

    final double _headlineWidth = _bubbleWidth
                                  - paddingValue
                                  - _leadingIconWidth
                                  - _switcherWidth
                                  - _moreButtonWidth
                                  - paddingValue;

    return _headlineWidth;
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
  // --------------------
  static const double getBubbleHeaderHeight = BubbleScale.headerButtonSize + verseBottomMargin;
  // -----------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(cornersValue));
  // --------------------
  static const BorderRadius clearCorners = BorderRadius.all(Radius.circular(clearCornersValue));
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color? validationColor({
    required String? Function()? validator,
    Color? defaultColor = color,
    bool canErrorize = true,
  }){

    bool _errorIsOn = false;
    Color? _errorColor;
    if (validator != null){
      // ------
      /// MESSAGE
      final String? _validationMessage = validator();
      // ------
      /// ERROR IS ON
      _errorIsOn = _validationMessage != null;
      // ------
      /// BUBBLE COLOR OVERRIDE
      final bool _colorAssigned = TextCheck.stringContainsSubString(string: _validationMessage, subString: 'Δ');
      if (_colorAssigned == true){
        final String? _colorCode = TextMod.removeTextAfterFirstSpecialCharacter(
          text: _validationMessage,
          specialCharacter: 'Δ',
        );
        _errorColor = Colorizer.decipherColor(_colorCode);
      }
      // ------
    }

    if (_errorIsOn == true && canErrorize == true){
      return _errorColor ?? Colorz.errorColor;
    }
    else {
      return defaultColor;
    }

  }
  // -----------------------------------------------------------------------------
}
