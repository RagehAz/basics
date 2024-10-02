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
    final BorderRadius _corners = corners ?? BorderRadius.circular(0);
    // --------------------
    return InkWell(
      key: key,
      splashColor: onTap == null ? Colorz.nothing : splashColor,
      highlightColor: onTap == null ? Colorz.nothing :Colorz.black20,
      onTap: onTap == null ? null : () => onTap!.call(),
      onTapCancel: onTapCancel == null ? null : () => onTapCancel!(),
      onLongPress: onLongTap == null ? null : () => onLongTap!(),
      onDoubleTap: onDoubleTap == null ? null : () => onDoubleTap!(),
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
    // --------------------
  }
  // --------------------------------------------------------------------------
}
