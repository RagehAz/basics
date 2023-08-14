

/// CAUTION : SUPER EXPENSIVE : MY RECOMMENDATION : NEVER USE IT
/*
class CustomBoxShadow extends BoxShadow {
  /// --------------------------------------------------------------------------
  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.style = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  /// --------------------------------------------------------------------------
  final BlurStyle style;
  /// --------------------------------------------------------------------------
  @override
  Paint toPaint() {
    final Paint _result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(style, blurSigma);

    assert(() {
      if (debugDisableShadows) {
        _result.maskFilter = null;
      }
      return true;
    }(), 'debugDisableShadows must be false to show shadow');

    return _result;
  }
/// --------------------------------------------------------------------------
}
*/
