part of bubble;
/// => TAMAM
class _BubbleContents extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BubbleContents({
    required this.columnChildren,
    required this.bubbleWidthOverride,
    required this.childrenCentered,
    required this.width,
    required this.headerViewModel,
    required this.child,
    // super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final double bubbleWidthOverride;
  final bool childrenCentered;
  final double? width;
  final BubbleHeaderVM? headerViewModel;
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

    blog('eh');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BubbleScale.paddingValue,
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: getMainAxisAlignment(),
        crossAxisAlignment: getCrossAxisAlignment(),
        children: <Widget>[

          const Spacing(size: BubbleScale.paddingValue),

          /// HEADER
          if (headerViewModel != null)
            _BubbleHeader(
              bubbleWidthOverride: bubbleWidthOverride,
              viewModel: headerViewModel?.copyWith(
                  headerWidth: headerViewModel?.headerWidth ?? (width == null ? null : width!-BubbleScale.bothMarginsValue)
              ),
            ),

          /// CHILDREN
          if (Lister.checkCanLoop(columnChildren) == true)
            ...columnChildren!,

          /// CHILD
          if (child != null)
            child!,

          const Spacing(size: BubbleScale.paddingValue),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
