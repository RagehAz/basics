part of tap_layer;

class _TapInkLayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapInkLayer({
    required this.onTap,
    required this.splashColor,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.corners,
    required this.child,
    required this.customBorder,
  });
  /// --------------------------------------------------------------------------
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapCancel;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Widget? child;
  final ShapeBorder? customBorder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// passed through via a direct cast instead of wrapping in a fresh
    /// closure on every build() -- onTap/onTapCancel/onLongTap/onDoubleTap
    /// are always used as zero-arg void callbacks in practice (that's the
    /// entire contract of a tap handler), so casting straight to
    /// VoidCallback is behavior-identical to the old `() => onTap!.call()`
    /// wrapper for every real caller, just without the extra allocation.
    final VoidCallback? _onTap = onTap == null ? null : onTap as VoidCallback;
    final VoidCallback? _onTapCancel = onTapCancel == null ? null : onTapCancel as VoidCallback;
    final VoidCallback? _onLongTap = onLongTap == null ? null : onLongTap as VoidCallback;
    final VoidCallback? _onDoubleTap = onDoubleTap == null ? null : onDoubleTap as VoidCallback;

    if (splashColor == null || splashColor == Colorz.nothing){
      return GestureDetector(
        key: key,
        onTap: _onTap,
        onTapCancel: _onTapCancel,
        onLongPress: _onLongTap,
        onDoubleTap: _onDoubleTap,
        child: child,
      );
    }
    // --------------------
    else {

      final BorderRadius _corners = corners ?? BorderRadius.circular(0);

      return InkWell(
        key: key,
        splashColor: onTap == null ? Colorz.nothing : splashColor,
        highlightColor: onTap == null ? Colorz.nothing :Colorz.black20,
        onTap: _onTap,
        onTapCancel: _onTapCancel,
        onLongPress: _onLongTap,
        onDoubleTap: _onDoubleTap,
        borderRadius: _corners,
        // hoverColor: Colorz.white10,
        customBorder: customBorder,
        // overlayColor: ,
        // highlightColor: ,
        // key: ,
        // autofocus: ,
        // canRequestFocus: ,
        // enableFeedback: ,
        // excludeFromSemantics: ,
        // focusColor: ,
        // focusNode: ,
        // mouseCursor: ,
        // onFocusChange: ,
        // onHighlightChanged: ,
        // onHover: ,
        // onSecondaryTap: ,
        // onSecondaryTapCancel: ,
        // onSecondaryTapDown: ,
        // onSecondaryTapUp: ,
        // onTapDown: ,
        // onTapUp: ,
        // radius: ,
        // splashFactory: ,
        // statesController: ,
        child: child,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
