part of tap_layer;

class _TapStateDisabled extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateDisabled({
    required this.width,
    required this.height,
    required this.onDisabledTap,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Function? onDisabledTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NO DISABLED TAP
    if (onDisabledTap == null){
      return _TapBox(
        key: const ValueKey<String>('DreamBoxTapLayer_e'),
        width: width,
        height: height,
        boxColor: boxColor,
        hasMaterial: false,
        corners: corners ?? BorderRadius.circular(0),
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: child,
      );
    }
    // --------------------
    /// DISABLED TAP
    else {

      return _TapBox(
        key: const ValueKey<String>('DreamBoxTapLayer_c'),
        width: width,
        height: height,
        boxColor: boxColor,
        hasMaterial: false,
        corners: corners ?? BorderRadius.circular(0),
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: GestureDetector(
          onTap: () => onDisabledTap!.call(),
          child: child,
        ),
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
