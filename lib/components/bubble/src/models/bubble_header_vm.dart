part of bubble;

@immutable
class BubbleHeaderVM {
  /// --------------------------------------------------------------------------
  const BubbleHeaderVM({
    this.headerWidth,
    this.leadingIcon,
    this.leadingIconSizeFactor = 1,
    this.leadingIconBoxColor,
    this.leadingIconColor,
    this.leadingIconIsBubble = false,
    this.onLeadingIconTap,
    this.hasSwitch = false,
    this.hasMoreButton = false,
    this.headlineText,
    this.headlineColor = BubbleScale.textColor,
    this.headlineMaxLines = 2,
    this.switchValue = false,
    this.onSwitchTap,
    this.onMoreButtonTap,
    this.redDot = false,
    this.centered = false,
    this.font,
    this.headlineHighlight,
    this.headlineHeight = 30,
    this.moreButtonIcon = Iconz.more,
    this.moreButtonIconSizeFactor = 0.6,
    this.textDirection = TextDirection.ltr,
    this.appIsLTR = true,
    this.switchActiveColor = BubbleScale.textColor,
    this.switchTrackColor = const Color.fromARGB(125, 20, 20, 35),
    this.switchFocusColor = const Color.fromARGB(255, 20, 20, 80),
    this.switchDisabledColor = const Color.fromARGB(150, 200, 200, 200),
    this.switchDisabledTrackColor = const Color.fromARGB(80, 20, 20, 35),
    this.letterSpacing,
    this.wordSpacing,
    this.loading = false,
  });
  // -----------------------------------------------------------------------------
  final double? headerWidth;
  final dynamic leadingIcon;
  final double? leadingIconSizeFactor;
  final Color? leadingIconBoxColor;
  final Color? leadingIconColor;
  final bool leadingIconIsBubble;
  final Function? onLeadingIconTap;
  final bool hasSwitch;
  final bool hasMoreButton;
  final String? headlineText;
  final Color? headlineColor;
  final int headlineMaxLines;
  final bool centered;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchTap;
  final Function? onMoreButtonTap;
  final bool redDot;
  final String? font;
  final ValueNotifier<dynamic>? headlineHighlight;
  final double? headlineHeight;
  final String? moreButtonIcon;
  final double? moreButtonIconSizeFactor;
  final TextDirection textDirection;
  final bool appIsLTR;
  final Color? switchActiveColor;
  final Color? switchDisabledColor;
  final Color? switchDisabledTrackColor;
  final Color? switchFocusColor;
  final Color? switchTrackColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final bool loading;
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  BubbleHeaderVM copyWith({
    double? headerWidth,
    dynamic leadingIcon,
    double? leadingIconSizeFactor,
    Color? leadingIconBoxColor,
    Color? leadingIconColor,
    bool? leadingIconIsBubble,
    bool? hasSwitch,
    bool? hasMoreButton,
    String? headlineText,
    Color? headlineColor,
    int? headlineMaxLines,
    bool? switchValue,
    ValueChanged<bool>? onSwitchTap,
    Function? onMoreButtonTap,
    bool? redDot,
    Function? onLeadingIconTap,
    bool? centered,
    String? font,
    ValueNotifier<dynamic>? headlineHighlight,
    double? headlineHeight,
    String? moreButtonIcon,
    double? moreButtonIconSizeFactor,
    Color? switchActiveColor,
    Color? switchDisabledColor,
    Color? switchDisabledTrackColor,
    Color? switchFocusColor,
    Color? switchTrackColor,
    bool? appIsLTR,
    TextDirection? textDirection,
    double? letterSpacing,
    double? wordSpacing,
    bool? loading,
  }){
    return BubbleHeaderVM(
      headerWidth: headerWidth ?? this.headerWidth,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      leadingIconSizeFactor: leadingIconSizeFactor ?? this.leadingIconSizeFactor,
      leadingIconBoxColor: leadingIconBoxColor ?? this.leadingIconBoxColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      leadingIconIsBubble: leadingIconIsBubble ?? this.leadingIconIsBubble,
      hasSwitch: hasSwitch ?? this.hasSwitch,
      hasMoreButton: hasMoreButton ?? this.hasMoreButton,
      headlineText: headlineText ?? this.headlineText,
      headlineColor: headlineColor ?? this.headlineColor,
      headlineMaxLines: headlineMaxLines ?? this.headlineMaxLines,
      switchValue: switchValue ?? this.switchValue,
      onSwitchTap: onSwitchTap ?? this.onSwitchTap,
      onMoreButtonTap: onMoreButtonTap ?? this.onMoreButtonTap,
      redDot: redDot ?? this.redDot,
      onLeadingIconTap: onLeadingIconTap ?? this.onLeadingIconTap,
      centered: centered ?? this.centered,
      font: font ?? this.font,
      headlineHighlight: headlineHighlight ?? this.headlineHighlight,
      headlineHeight: headlineHeight ?? this.headlineHeight,
      moreButtonIcon: moreButtonIcon ?? this.moreButtonIcon,
      moreButtonIconSizeFactor: moreButtonIconSizeFactor ?? this.moreButtonIconSizeFactor,
      switchActiveColor: switchActiveColor ?? this.switchActiveColor,
      switchDisabledColor: switchDisabledColor ?? this.switchDisabledColor,
      switchDisabledTrackColor: switchDisabledTrackColor ?? this.switchDisabledTrackColor,
      switchFocusColor: switchFocusColor ?? this.switchFocusColor,
      switchTrackColor: switchTrackColor ?? this.switchTrackColor,
      textDirection: textDirection ?? this.textDirection,
      appIsLTR: appIsLTR ?? this.appIsLTR,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      loading: loading ?? this.loading,
    );
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool bubbleHeaderViewModelsAreIdentical({
    required BubbleHeaderVM? model1,
    required BubbleHeaderVM? model2,
  }){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }

    else if (model1 != null && model2 != null){

      if (
          model1.headerWidth == model2.headerWidth &&
          model1.leadingIcon == model2.leadingIcon &&
          model1.leadingIconSizeFactor == model2.leadingIconSizeFactor &&
          model1.leadingIconBoxColor == model2.leadingIconBoxColor &&
          model1.leadingIconColor == model2.leadingIconColor &&
          model1.leadingIconIsBubble == model2.leadingIconIsBubble &&
          model1.hasSwitch == model2.hasSwitch &&
          model1.hasMoreButton == model2.hasMoreButton &&
          model1.headlineText == model2.headlineText &&
          model1.headlineColor == model2.headlineColor &&
          model1.headlineMaxLines == model2.headlineMaxLines &&
          model1.switchValue == model2.switchValue &&
          model1.redDot == model2.redDot &&
          model1.centered == model2.centered &&
          model1.font == model2.font &&
          model1.headlineHeight == model2.headlineHeight &&
          model1.moreButtonIcon == model2.moreButtonIcon &&
          model1.moreButtonIconSizeFactor == model2.moreButtonIconSizeFactor &&
          model1.headlineHighlight == model2.headlineHighlight &&
          model1.switchActiveColor == model2.switchActiveColor &&
          model1.switchDisabledColor == model2.switchDisabledColor &&
          model1.switchDisabledTrackColor == model2.switchDisabledTrackColor &&
          model1.switchFocusColor == model2.switchFocusColor &&
          model1.switchTrackColor == model2.switchTrackColor &&
          model1.appIsLTR == model2.appIsLTR &&
          model1.textDirection == model2.textDirection &&
          model1.letterSpacing == model2.letterSpacing &&
          model1.wordSpacing == model2.wordSpacing &&
          model1.loading == model2.loading

      // ValueChanged<bool> onSwitchTap
      // Function onMoreButtonTap
      // Function onLeadingIconTap
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is BubbleHeaderVM){
      _areIdentical = bubbleHeaderViewModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      headerWidth.hashCode^
      leadingIcon.hashCode^
      leadingIconSizeFactor.hashCode^
      leadingIconBoxColor.hashCode^
      leadingIconColor.hashCode^
      leadingIconIsBubble.hashCode^
      onLeadingIconTap.hashCode^
      hasSwitch.hashCode^
      hasMoreButton.hashCode^
      headlineText.hashCode^
      headlineColor.hashCode^
      headlineMaxLines.hashCode^
      switchValue.hashCode^
      onSwitchTap.hashCode^
      onMoreButtonTap.hashCode^
      redDot.hashCode^
      centered.hashCode^
      font.hashCode^
      headlineHighlight.hashCode^
      headlineHeight.hashCode^
      moreButtonIcon.hashCode^
      moreButtonIconSizeFactor.hashCode^
      switchActiveColor.hashCode^
      switchDisabledColor.hashCode^
      switchDisabledTrackColor.hashCode^
      switchFocusColor.hashCode^
      switchTrackColor.hashCode^
      appIsLTR.hashCode^
      textDirection.hashCode^
      letterSpacing.hashCode^
      loading.hashCode^
      wordSpacing.hashCode;
  // -----------------------------------------------------------------------------
}
