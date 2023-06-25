import 'package:basics/super_text/super_text.dart';
import 'package:flutter/material.dart';
import '../../super_box.dart';
/// => TAMAM
class SuperBoxTexts extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperBoxTexts({
    required this.text,
    required this.textDirection,
    required this.icon,
    required this.loading,
    required this.height,
    required this.width,
    required this.greyScale,
    required this.iconSizeFactor,
    required this.textScaleFactor,
    required this.textCentered,
    required this.secondText,
    required this.textWeight,
    required this.textColor,
    required this.textMaxLines,
    required this.secondTextMaxLines,
    required this.textItalic,
    required this.redDot,
    required this.secondTextColor,
    required this.centered,
    required this.highlight,
    required this.highlightColor,
    required this.appIsLTR,
    required this.textFont,
    required this.isDisabled,
    required this.package,
    required this.letterSpacing,
  super.key
  });  // -----------------------------------------------------------------------------
  final double? height;
  final bool textCentered;
  final dynamic icon;
  final bool loading;
  final double? iconSizeFactor;
  final String? text;
  final String? secondText;
  final double? textScaleFactor;
  final FontWeight? textWeight;
  final double? width;
  final TextDirection textDirection;
  final String? textFont;
  final Color? textColor;
  final bool textItalic;
  final bool isDisabled;
  final bool greyScale;
  final int? textMaxLines;
  final bool appIsLTR;
  final bool redDot;
  final ValueNotifier<dynamic>? highlight;
  final Color? highlightColor;
  final Color? secondTextColor;
  final int? secondTextMaxLines;
  final bool centered;
  final String? package;
  final double? letterSpacing;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _textIsCentered = SuperBoxController.checkTextIsCentered(
        verseCentered: textCentered,
        icon: icon,
    );
    // --------------------
    final double _graphicWidth = SuperBoxController.graphicWidth(
      icon: icon,
      height: height,
      loading: loading,
      iconSizeFactor: iconSizeFactor,
    );
    // --------------------
    final double _iconMargin = SuperBoxController.iconMargin(
      height: height,
      icon: icon,
      text: text,
      iconSizeFactor: iconSizeFactor,
      loading: loading,
    );
    // --------------------
    final double? _verseWidth = SuperBoxController.verseWidth(
      graphicWidth: _graphicWidth,
      width: width,
      iconMargin: _iconMargin,
      hasIcon: icon != null,
    );
    // --------------------
    final CrossAxisAlignment _versesCrossAlignment = SuperBoxController.versesCrossAlignment(
      icon: icon,
      secondLine: secondText,
      textDirection: textDirection,
      verseCentered: textCentered,
    );
    // --------------------
    final Alignment? _verseAlignment = SuperBoxController.getVersesBoxAlignment(
      centered: centered,
      appIsLTR: appIsLTR,
    );
    // --------------------
    final double _mainTextHeight = SuperBoxController.textLineHeight(
      height: height,
      iconSizeFactor: iconSizeFactor,
      textScaleFactor: textScaleFactor,
    );
    // --------------------
    return Container(
      height: height,
      width: _verseWidth,
      alignment: _verseAlignment,
      // color: Colorz.yellow50, // for design purpose only
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: _versesCrossAlignment,
          children: <Widget>[

            /// TEXT
            SizedBox(
              width: _verseWidth,
              height: secondText == null ? height : null,
              child: SuperText(
                boxWidth: _verseWidth,
                package: package,
                text: text,
                textHeight: _mainTextHeight,
                boxHeight: secondText == null ? height : null,
                // scaleFactor: iconSizeFactor * verseScaleFactor,
                weight: textWeight,
                font: textFont,
                textDirection: textDirection,
                textColor: SuperBoxController.textColor(
                    colorOverride: textColor,
                    isDisabled: isDisabled,
                    greyScale: greyScale,
                ),
                // shadow: _verseShadowIsOn(),
                maxLines: textMaxLines,
                centered: _textIsCentered,
                appIsLTR: appIsLTR,
                italic: textItalic,
                redDot: redDot,
                highlight: highlight,
                highlightColor: highlightColor,
                letterSpacing: letterSpacing,
              ),
            ),

            /// SECOND TEXT
            if (secondText != null)
              SizedBox(
                width: _verseWidth,
                child: SuperText(
                    text: secondText,
                    weight: FontWeight.w200,
                    textHeight: _mainTextHeight * 0.8,
                    textColor: SuperBoxController.textColor(
                      colorOverride: secondTextColor,
                      isDisabled: isDisabled,
                      greyScale: greyScale,
                    ),
                    maxLines: secondTextMaxLines,
                    letterSpacing: letterSpacing,
                    italic: true,
                    textDirection: textDirection,
                    font: textFont,
                    appIsLTR: appIsLTR,
                    // shadow: _secondLineShadowIsOn(),
                    centered: _textIsCentered,
                    highlight: highlight,
                    highlightColor: highlightColor,
                    package: package,

                    // margins:
                    // _verseWidth == null ?
                    // EdgeInsets.symmetric(horizontal: height * 0.2)
                  //     :
                  // EdgeInsets.zero,
                ),
              ),

          ],
        ),
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
