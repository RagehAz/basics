part of tap_layer;

class _TapStateWithUpsAndDowns extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateWithUpsAndDowns({
    required this.width,
    required this.height,
    required this.onTap,
    required this.splashColor,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    required this.customBorder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final Function? onTapCancel;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  final ShapeBorder? customBorder;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = corners ?? BorderRadius.circular(0);
    // --------------------
    return _TapBox(
      key: key,
      hasMaterial: true,
      width: width,
      height: height,
      corners: _corners,
      boxColor: boxColor,
      margin: margin,
      alignment: alignment,
      borderColor: borderColor,
      child: GestureDetector(
        // onLongPress: onLongTap,
        onTapDown: onTapDown == null ? null : (TapDownDetails details) => onTapDown?.call(),
        onTapUp: onTapUp == null ? null : (TapUpDetails details) => onTapUp?.call(),
        child: _TapInkLayer(
          onTap: onTap,
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: onLongTap,
          onDoubleTap: onDoubleTap,
          corners: corners,
          customBorder: customBorder,
          child: child,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
