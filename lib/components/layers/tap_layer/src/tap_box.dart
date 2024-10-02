part of tap_layer;

class _TapBox extends StatelessWidget {

  const _TapBox({
    required this.width,
    required this.height,
    required this.corners,
    required this.boxColor,
    required this.hasMaterial,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    this.child,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius corners;
  final Widget? child;
  final Color? boxColor;
  final bool hasMaterial;
  final Alignment? alignment;
  final EdgeInsets? margin;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {

    // final double _borderFactor = borderColor == null ? 0 : (_borderThickness*2);
    final double? _width = width == null ? null : width! - 0;
    final double? _height = height == null ? null : height! - 0;

    return Container(
      key: const ValueKey<String>('_TapBox_b'),
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: corners,
        color: boxColor,
        border: TapLayer.getBorder(
          color: borderColor,
        ),
      ),
      alignment: alignment,
      margin: margin,
      child: hasMaterial == false ? child : Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: corners,
        child: child,
      ),
    );

  }

}
