part of bubble;
/// => TAMAM
class TileBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TileBubble({
    this.bubbleHeaderVM,
    this.borderColor,
    this.bubbleWidth,
    this.textColor = BubbleScale.textColor,
    this.onTileTap,
    this.secondLine,
    this.secondLineColor = BubbleScale.secondLineColor,
    this.secondLineTextHeight = 15,
    this.child,
    this.bulletPoints,
    this.bubbleColor = BubbleScale.color,
    this.validator,
    this.autoValidate = true,
    this.textDirection,
    this.appIsLTR = true,
    this.focusNode,
    this.font,
    this.bulletPointsMaxLines = 10,
    this.hasChildTopPadding = false,
    this.margin,
    this.bulletsColor,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? bubbleWidth;
  final BubbleHeaderVM? bubbleHeaderVM;
  final Color? textColor;
  final Function? onTileTap;
  final String? secondLine;
  final Color? secondLineColor;
  final double? secondLineTextHeight;
  final Widget? child;
  final List<String>? bulletPoints;
  final Color? bubbleColor;
  final String? Function()? validator;
  final bool autoValidate;
  final bool appIsLTR;
  final TextDirection? textDirection;
  final String? font;
  final FocusNode? focusNode;
  final int bulletPointsMaxLines;
  final Color? borderColor;
  final bool hasChildTopPadding;
  final dynamic margin;
  final Color? bulletsColor;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = BubbleScale.bubbleWidth(context: context, bubbleWidthOverride: bubbleWidth);
    final double _clearWidth = BubbleScale.clearWidth(context: context, bubbleWidthOverride: _bubbleWidth);
    final double _childWidth = BubbleScale.childWidth(context: context, bubbleWidthOverride: _bubbleWidth);
    // --------------------
    return Bubble(
      key: key,
      bubbleHeaderVM: const BubbleHeaderVM(),
      borderColor: borderColor,
      width: _bubbleWidth,
      onBubbleTap: onTileTap,
      bubbleColor: BubbleScale.validationColor(
        // canErrorize: true,
        defaultColor: bubbleColor,
        validator: validator,
      ),
      margin: margin,
      columnChildren: <Widget>[

        /// BUBBLE HEADER
        if (bubbleHeaderVM != null)
        _BubbleHeader(
          bubbleWidthOverride: _bubbleWidth,
          viewModel: bubbleHeaderVM!.copyWith(
            // headerWidth: _clearWidth,
            headlineColor: textColor,
            font: font,
            textDirection: textDirection,
            appIsLTR: appIsLTR,
            centered: false,
          ),
        ),

        /// BULLET POINTS
        if (Lister.checkCanLoop(bulletPoints) == true)
        Padding(
          padding: Scale.superInsets(
            context: context,
            appIsLTR: appIsLTR,
            enLeft: BubbleScale.headerButtonSize,
            top: 4,
          ),
          child: BulletPoints(
            textColor: bulletsColor,
            bulletPoints: bulletPoints,
            textHeight: 18,
            boxWidth: _childWidth,
            appIsLTR: appIsLTR,
            textDirection: textDirection ?? TextDirection.ltr,
            maxLines: bulletPointsMaxLines,
            font: BldrsThemeFonts.fontBody,
            showBottomLine: false,
          ),
        ),

        /// SECOND LINE
        if (secondLine != null)
          SizedBox(
            width: _bubbleWidth,
            child: Row(
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: BubbleScale.headerButtonSize,
                ),

                /// SECOND LINE
                SizedBox(
                  width: _childWidth,
                  child: SuperText(
                    text: secondLine,
                    textColor: secondLineColor,
                    textHeight: secondLineTextHeight,
                    // scaleFactor: 1,
                    italic: true,
                    maxLines: 100,
                    centered: false,
                    weight: FontWeight.w100,
                    margins: 5,
                    textDirection: textDirection ?? TextDirection.ltr,
                    appIsLTR: appIsLTR,
                    font: font,
                  ),
                ),

              ],
            ),
          ),

        if (hasChildTopPadding == true)
          const Spacing(size: BubbleScale.paddingValue),

        /// CHILD
        if (child != null)
          SizedBox(
            width: _bubbleWidth,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                /// UNDER LEADING ICON AREA
                const SizedBox(
                  width: BubbleScale.headerButtonSize,
                ),

                /// CHILD
                Container(
                  width: BubbleScale.childWidth(
                      context: context,
                      bubbleWidthOverride: _bubbleWidth
                  ),
                  alignment: Alignment.center,
                  child: child,
                ),

              ],
            ),
          ),

        /// VALIDATOR
        if (validator != null)
          SuperValidator(
            width: _clearWidth,
            validator: () => validator?.call(),
            autoValidate: autoValidate,
            font: bubbleHeaderVM?.font,
            focusNode: focusNode,
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
