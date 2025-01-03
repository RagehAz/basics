part of super_text;

TextStyle createTextStyle({
  /// SIZE
  required double? textHeight,
  /// DUNNO
  bool inherit = true,
  String? debugLabel,
  Locale? locale,
  String? package,
  /// FONT
  String? fontFamily,
  List<FontFeature>? fontFeatures,
  List<String>? fontFamilyFallback,
  /// COLOR
  Color? color = const Color.fromARGB(255, 0, 0, 0),
  Color? backgroundColor,
  /// WEIGHT
  FontWeight? fontWeight = FontWeight.w100,
  /// SPACING
  double? letterSpacing,
  double? wordSpacing,
  double lineSpacingFactor = 1,
  /// STYLE
  bool italic = false,
  TextBaseline? textBaseline = TextBaseline.alphabetic,
  List<Shadow>? shadows,
  TextOverflow overflow = TextOverflow.ellipsis,
  /// DECORATION
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  TextDecoration? decoration,
  double? decorationThickness,
  /// PAINTS
  Paint? foreground,
  Paint? background,

  // ui.TextLeadingDistribution leadingDistribution,
}) {

  final double _height = 1.44 * lineSpacingFactor;
  final double _textHeight = textHeight ?? 20;
  final double _fontSize = _textHeight / 1.44;

  return TextStyle(
    /// DUNNO
    inherit: inherit,
    debugLabel: debugLabel,
    locale: locale,
    package: package,
    /// FONT
    fontFamily: fontFamily,
    fontFeatures: fontFeatures,
    fontFamilyFallback: fontFamilyFallback,
    /// COLOR
    color: color,
    backgroundColor: backgroundColor,
    /// SIZE
    height: _height,
    fontSize: _fontSize,
    /// WEIGHT
    fontWeight: fontWeight,
    /// SPACING
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    /// STYLE
    fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
    textBaseline: textBaseline,
    shadows: shadows,
    overflow: overflow,
    /// DECORATION
    decorationColor: decorationColor,
    decoration: decoration,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    /// PAINTS
    foreground: foreground,
    background: background,

    // leadingDistribution: TextLeadingDistribution.even,
  );

}
