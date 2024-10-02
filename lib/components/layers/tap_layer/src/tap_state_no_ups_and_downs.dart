part of tap_layer;

class _TapStateNoUpsAndDowns extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateNoUpsAndDowns({
    required this.width,
    required this.height,
    required this.corners,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    required this.onTap,
    required this.splashColor,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.child,
    required this.customBorder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
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
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = corners ?? BorderRadius.circular(0);
    // --------------------
    return _TapBox(
      key: key,
      hasMaterial: true,
      boxColor: boxColor,
      corners: _corners,
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      borderColor: borderColor,
      child: Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: _corners,
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
