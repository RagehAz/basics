part of bubble;

class _BubbleContents extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BubbleContents({
    required this.columnChildren,
    required this.childrenCentered,
    required this.width,
    required this.headerViewModel,
    required this.hasBottomPadding,
    required this.child,
    // super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final bool childrenCentered;
  final double? width;
  final BubbleHeaderVM? headerViewModel;
  final bool hasBottomPadding;
  final Widget? child;
  // --------------------------------------------------------------------------
  MainAxisAlignment getMainAxisAlignment(){
    return childrenCentered == true ? MainAxisAlignment.center : MainAxisAlignment.start;
  }
  // --------------------
  CrossAxisAlignment getCrossAxisAlignment(){
    return childrenCentered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: EdgeInsets.only(
        // top: Bubble._pageMargin,
        right: BubbleScale.paddingValue,
        left: BubbleScale.paddingValue,
        bottom: hasBottomPadding == true ? BubbleScale.paddingValue : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: getMainAxisAlignment(),
        crossAxisAlignment: getCrossAxisAlignment(),
        children: <Widget>[

          if (headerViewModel != null)
            const Spacing(size: BubbleScale.paddingValue),

          if (headerViewModel != null)
            BubbleHeader(
              viewModel: headerViewModel?.copyWith(
                  headerWidth: headerViewModel?.headerWidth ?? (width == null ? null : width!-BubbleScale.bothMarginsValue)
              ),
            ),

          if (child != null || Lister.checkCanLoop(columnChildren) == true)
            const Spacing(size: BubbleScale.paddingValue),

          if (Lister.checkCanLoop(columnChildren) == true)
            ...columnChildren!,

          if (child != null)
            child!,

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
