part of bubble;
/// => TAMAM
class Bubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Bubble({
    this.bubbleHeaderVM,
    this.borderColor,
    this.columnChildren,
    this.child,
    this.childrenCentered = false,
    this.bubbleColor = BubbleScale.color,
    this.width,
    this.onBubbleTap,
    this.margin,
    this.corners,
    this.areTopCentered = true,
    this.onBubbleDoubleTap,
    this.appIsLTR = true,
    this.splashColor = BubbleScale.splashColor,
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
  final Color? borderColor;
  // -----------------------------------------------------------------------------
  double _getBubbleWidth(BuildContext context){
    return BubbleScale.bubbleWidth(
      context: context,
      bubbleWidthOverride: width,
    );
  }
  // --------------------
  BorderRadius _getCorners(){
    return corners == null ? BubbleScale.corners : Borderers.superCorners(corners: corners);
  }
  // --------------------
  Alignment _getAlignment(){

    if (childrenCentered == true){
      return areTopCentered == true ? Alignment.topCenter : Alignment.center;
    }

    else {
      return areTopCentered == true ? Aligner.top(appIsLTR: appIsLTR) : Aligner.center(appIsLTR: appIsLTR);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = _getBubbleWidth(context);
    final BorderRadius _corners = _getCorners();
    final Alignment _alignment = _getAlignment();
    // --------------------
    return Center(
      child: TapLayer(
        width: _bubbleWidth,
        height: null,
        boxColor: bubbleColor,
        margin: Scale.superMargins(margin: margin),
        corners: _corners,
        borderColor: borderColor,
        onTap: onBubbleTap == null ? null : () => onBubbleTap!(),
        onDoubleTap: onBubbleDoubleTap == null ? null : () => onBubbleDoubleTap!(),
        splashColor: onBubbleTap == null ? null : splashColor,
        alignment: _alignment,
        child: _BubbleContents(
          width: _bubbleWidth,
          bubbleWidthOverride: _bubbleWidth,
          childrenCentered: childrenCentered,
          columnChildren: columnChildren,
          headerViewModel: bubbleHeaderVM,
          child: child,
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
