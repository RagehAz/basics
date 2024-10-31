part of bubble;

class _BubbleContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _BubbleContents({
    required this.columnChildren,
    required this.childrenCentered,
    required this.width,
    required this.headerViewModel,
    required this.hasBottomPadding,
    required this.child,
    // super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget>? columnChildren;
  final bool childrenCentered;
  final double? width;
  final BubbleHeaderVM? headerViewModel;
  final bool hasBottomPadding;
  final Widget? child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: EdgeInsets.only(
        // top: Bubble._pageMargin,
        right: Bubble._pageMargin,
        left: Bubble._pageMargin,
        bottom: hasBottomPadding == true ? Bubble._pageMargin : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: childrenCentered == true ?
        MainAxisAlignment.center
            :
        MainAxisAlignment.start,
        crossAxisAlignment: childrenCentered == true ?
        CrossAxisAlignment.center
            :
        CrossAxisAlignment.start,
        children: <Widget>[

          if (headerViewModel != null)
            const Spacing(size: Bubble._pageMargin),

          if (headerViewModel != null)
            BubbleHeader(
              viewModel: headerViewModel?.copyWith(
                  headerWidth: headerViewModel?.headerWidth ?? (width == null ? null : width!-20)
              ),
            ),

          if (child != null || Lister.checkCanLoop(columnChildren) == true)
            const Spacing(size: 5),

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
