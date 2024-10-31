part of bubble;

class Bubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Bubble({
    this.bubbleHeaderVM,
    this.borderColor,
    this.columnChildren,
    this.child,
    this.childrenCentered = false,
    this.bubbleColor = const Color.fromARGB(10, 255, 255, 255),
    this.width,
    this.onBubbleTap,
    this.margin,
    this.corners,
    this.areTopCentered = true,
    this.onBubbleDoubleTap,
    this.appIsLTR = true,
    this.splashColor = const Color.fromARGB(200, 255, 255, 255),
    this.hasBottomPadding = true,
    super.key
  });
  // --------------------------------------------------------------------------
  final List<Widget>? columnChildren;
  final Widget? child;
  final BubbleHeaderVM? bubbleHeaderVM;
  final bool childrenCentered;
  final Color? bubbleColor;
  final double? width;
  final Function? onBubbleTap;
  final dynamic margin;
  final dynamic corners;
  final bool areTopCentered;
  final Function? onBubbleDoubleTap;
  final bool appIsLTR;
  final Color splashColor;
  final bool hasBottomPadding;
  final Color? borderColor;
  // -----------------------------------------------------------------------------
  static double clearWidth({
    required BuildContext context,
    double? bubbleWidthOverride,
  }) {
    final double _bubbleWidth = bubbleWidth(
      context: context,
      bubbleWidthOverride: bubbleWidthOverride,
    );
    const double _bubblePaddings = 10 * 2.0;
    return _bubbleWidth - _bubblePaddings;
  }
  // --------------------
  static double bubbleWidth({
    required BuildContext context,
    double? bubbleWidthOverride
  }) {

    if (bubbleWidthOverride == null){

      return Scale.responsive(
        context: context,
        landscape: Scale.screenShortestSide(context) - 20,
        portrait: Scale.screenWidth(context) - 20,
      );

    }

    else {
      return bubbleWidthOverride;
    }

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
  static double getHeightWithoutChildren({
    required double headlineHeight,
  }){
    return (_pageMargin * 3) + headlineHeight;
    // return (_pageMargin * 3) + _getTitleHeight(context);
  }
  // --------------------
  static const double cornersValue = 18;
  static const double _pageMargin = 5;
  // --------------------
  static const double clearCornersValue = cornersValue - _pageMargin;
  // --------------------
  static BorderRadius borders() {
    return Borderers.superCorners(
      corners: cornersValue,
    );
  }
  // --------------------
  static BorderRadius clearBorders() {
    return Borderers.superCorners(
      corners: clearCornersValue,
    );
  }
  // --------------------
  static double paddingValue(){
    return _pageMargin;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final EdgeInsets _bubbleMargins = margin == null ? EdgeInsets.zero : Scale.superMargins(margin: margin);
    // --------------------
    final double _bubbleWidth = bubbleWidth(
      context: context,
      bubbleWidthOverride: width,
    );
    // --------------------
    final BorderRadius _corners = corners == null ?
    borders()
        :
    Borderers.superCorners(corners: corners);
    // --------------------
    final Alignment _alignment = childrenCentered == true ?
    (areTopCentered == true ? Alignment.topCenter : Alignment.center)
        :
    (areTopCentered == true ? Aligner.top(appIsLTR: appIsLTR) : Aligner.center(appIsLTR: appIsLTR));
    // --------------------
    return Center(
      child: TapLayer(
        width: _bubbleWidth,
        height: null,
        boxColor: bubbleColor,
        margin: _bubbleMargins.copyWith(bottom: _pageMargin),
        corners: _corners,
        borderColor: borderColor,
        onTap: onBubbleTap == null ? null : () => onBubbleTap!(),
        onDoubleTap: onBubbleDoubleTap == null ? null : () => onBubbleDoubleTap!(),
        splashColor: onBubbleTap == null ? const Color.fromARGB(0, 255, 255, 255) : splashColor,
        alignment: _alignment,
        child: _BubbleContents(
          width: _bubbleWidth,
          childrenCentered: childrenCentered,
          columnChildren: columnChildren,
          headerViewModel: bubbleHeaderVM,
          hasBottomPadding: hasBottomPadding,
          child: child,
        ),
      ),
    );
    // --------------------
    /// DEPRECATED OLD BUBBLE
    /*
     // --------------------
    final Widget _bubbleContents = _BubbleContents(
      width: _bubbleWidth,
      childrenCentered: childrenCentered,
      columnChildren: columnChildren,
      headerViewModel: bubbleHeaderVM,
      hasBottomPadding: hasBottomPadding,
      child: child,
    );
    // --------------------
    return Center(
      child: Container(
        key: key,
        width: _bubbleWidth,
        margin: _bubbleMargins.copyWith(bottom: _pageMargin),
        // padding: EdgeInsets.all(_pageMargin),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: _corners,
        ),
        alignment: _alignment,
        child: onBubbleTap == null && onBubbleDoubleTap == null?

        _bubbleContents

            :

        Material(
          color: const Color.fromARGB(0, 255, 255, 255),
          child: InkWell(
            onTap: onBubbleTap == null ? null : () => onBubbleTap!(),
            onDoubleTap: onBubbleDoubleTap == null ? null : () => onBubbleDoubleTap!(),
            splashColor: onBubbleTap == null ? const Color.fromARGB(0, 255, 255, 255) : splashColor,
            borderRadius: _corners,
            child: _bubbleContents,
          ),
        ),

      ),
    );
    */
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
