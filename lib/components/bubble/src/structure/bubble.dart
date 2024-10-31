part of bubble;

class Bubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Bubble({
    this.bubbleHeaderVM,
    this.borderColor,
    this.columnChildren,
    this.child,
    this.childrenCentered = false,
    this.bubbleColor = Colorz.white10,
    this.width,
    this.onBubbleTap,
    this.margin,
    this.corners,
    this.areTopCentered = true,
    this.onBubbleDoubleTap,
    this.appIsLTR = true,
    this.splashColor = Colorz.white20,
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
  // --------------------

  static const double _pageMargin = 5;
  // --------------------


  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final EdgeInsets _bubbleMargins = margin == null ? EdgeInsets.zero : Scale.superMargins(margin: margin);
    // --------------------
    final double _bubbleWidth = BubbleScale.bubbleWidth(
      context: context,
      bubbleWidthOverride: width,
    );
    // --------------------
    final BorderRadius _corners = corners == null ? BubbleScale.corners : Borderers.superCorners(corners: corners);
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
