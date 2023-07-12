part of super_box;

class SuperBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperBox({
    required this.height,
    this.width,
    this.icon,
    this.iconSizeFactor = 1,
    this.color = const Color.fromARGB(0, 255, 255, 255),
    this.corners,
    this.iconColor,
    this.text,
    this.textColor = const Color.fromARGB(255, 255, 255, 255),
    this.textWeight = FontWeight.w400,
    this.textScaleFactor = 1,
    this.textShadow = false,
    this.textItalic = false,
    this.textMaxLines = 1,
    this.secondTextMaxLines = 10,
    this.onTap,
    this.margins,
    this.greyscale = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondText,
    this.textCentered = true,
    this.subChild,
    this.childAlignment = Alignment.center,
    this.opacity = 1,
    this.isDisabled = false,
    this.splashColor = const Color.fromARGB(10, 255, 255, 255),
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection = TextDirection.ltr,
    this.blur,
    this.secondTextColor = const Color.fromARGB(255, 255, 255, 255),
    this.redDot = false,
    this.secondTextScaleFactor = 1,
    this.loading = false,
    this.iconBackgroundColor,
    this.onDisabledTap,
    this.textHighlight,
    this.textHighlightColor = const Color.fromARGB(100, 255, 0, 0),
    this.onLongTap,
    this.onDoubleTap,
    this.appIsLTR = true,
    this.package,
    this.textFont,
    this.letterSpacing,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final dynamic icon;
  /// works as textSizeFactor as well
  final double? iconSizeFactor;
  final Color? color;
  final double? width;
  final double? height;
  final dynamic corners;
  final Color? iconColor;
  final String? text;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textScaleFactor;
  final bool textShadow;
  final bool textItalic;
  final int? textMaxLines;
  final int? secondTextMaxLines;
  final Function? onTap;
  final dynamic margins;
  final bool greyscale;
  final bool iconRounded;
  final bool bubble;
  final String? secondText;
  final bool textCentered;
  final Widget? subChild;
  final Alignment? childAlignment;
  final double? opacity;
  final bool isDisabled;
  final Color? splashColor;
  final Function? onTapDown;
  final Function? onTapUp;
  final Function? onTapCancel;
  final TextDirection textDirection;
  final double? blur;
  final Color? secondTextColor;
  final bool redDot;
  final double? secondTextScaleFactor;
  final bool loading;
  final Color? iconBackgroundColor;
  final Function? onDisabledTap;
  final ValueNotifier<dynamic>? textHighlight;
  final Color? textHighlightColor;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final bool appIsLTR;
  final String? package;
  final String? textFont;
  final double? letterSpacing;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _borderRadius = SuperBoxController.boxCorners(
      context: context,
      cornersOverride: corners,
    );
    // --------------------
    return TheBoxOfSuperBox(
      isDisabled: isDisabled,
      opacity: opacity,
      margins: margins,
      width: width,
      height: height,
      boxColor: color,
      greyScale: greyscale,
      borderRadius: _borderRadius,
      splashColor: splashColor,
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onDisabledTap: onDisabledTap,
      onLongTap: onLongTap,
      onDoubleTap: onDoubleTap,
      children: <Widget>[

        // /// --- BLUR LAYER
        // if (blur != null)
        //   BlurLayer(
        //     width: width,
        //     height: height,
        //     blur: blur,
        //     borders: _cornersAsBorderRadius,
        //   ),

        /// CHILD
        if (subChild != null)
          SuperBoxChild(
            height: height,
            width: width,
            borderRadius: _borderRadius,
            childAlignment: childAlignment,
            subChild: subChild,
          ),

        /// ICON - TEXT - SECOND LINE
        SuperBoxContents(
          package: package,
          text: text,
          textDirection: textDirection,
          icon: icon,
          loading: loading,
          height: height,
          width: width,
          iconCorners: _borderRadius,
          greyScale: greyscale,
          iconColor: iconColor,
          iconSizeFactor: iconSizeFactor,
          textScaleFactor: textScaleFactor,
          textCentered: textCentered,
          secondText: secondText,
          textWeight: textWeight,
          textColor: textColor,
          textShadow: textShadow,
          textMaxLines: textMaxLines,
          secondTextMaxLines: secondTextMaxLines,
          textItalic: textItalic,
          redDot: redDot,
          secondTextScaleFactor: secondTextScaleFactor,
          secondTextColor: secondTextColor,
          centered: textCentered,
          backgroundColor: iconBackgroundColor,
          highlight: textHighlight,
          highlightColor: textHighlightColor,
          appIsLTR: appIsLTR,
          textFont: textFont,
          isDisabled: isDisabled,
          letterSpacing: letterSpacing,
        ),

        /// HIGHLIGHT
        if (bubble == true)
          BoxHighlight(
              width: width,
              height: height,
              corners: _borderRadius
          ),

        /// GRADIENT
        if (bubble == true)
          BoxGradient(
            width: width,
            height: height,
            corners: _borderRadius,
          ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
