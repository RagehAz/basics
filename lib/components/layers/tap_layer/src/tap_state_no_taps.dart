part of tap_layer;

class _NoTapsGiven extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _NoTapsGiven({
    required this.width,
    required this.height,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    super.key
  });
  // --------------------
  final double? width;
  final double? height;
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
    return _TapBox(
      key: const ValueKey<String>('_NoTapsGiven'),
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
    // --------------------
  }
  // --------------------------------------------------------------------------
}
