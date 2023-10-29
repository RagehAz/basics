import 'package:flutter/material.dart';
import '../../super_box.dart';
import 'icon_box.dart';
import 'x_super_box_verses.dart';

/// => TAMAM
class SuperBoxContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperBoxContents({
    required this.text,
    required this.textDirection,
    required this.icon,
    required this.loading,
    required this.height,
    required this.width,
    required this.iconCorners,
    required this.greyScale,
    required this.solidGreyScale,
    required this.iconColor,
    required this.iconSizeFactor,
    required this.textScaleFactor,
    required this.textCentered,
    required this.secondText,
    required this.textWeight,
    required this.textColor,
    required this.textShadow,
    required this.textMaxLines,
    required this.secondTextMaxLines,
    required this.textItalic,
    required this.redDot,
    required this.secondTextScaleFactor,
    required this.secondTextColor,
    required this.centered,
    required this.backgroundColor,
    required this.highlight,
    required this.highlightColor,
    required this.appIsLTR,
    required this.package,
    required this.textFont,
    required this.isDisabled,
    required this.letterSpacing,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final String? text;
  final TextDirection textDirection;
  final dynamic icon;
  final bool loading;
  final double? width;
  final double height;
  final BorderRadius? iconCorners;
  final bool greyScale;
  final bool solidGreyScale;
  final Color? iconColor;
  final double? iconSizeFactor;
  final double? textScaleFactor;
  final bool textCentered;
  final String? secondText;
  final FontWeight? textWeight;
  final Color? textColor;
  final bool textShadow;
  final int? textMaxLines;
  final int? secondTextMaxLines;
  final bool textItalic;
  final bool redDot;
  final double? secondTextScaleFactor;
  final Color? secondTextColor;
  final bool centered;
  final Color? backgroundColor;
  final ValueNotifier<dynamic>? highlight;
  final Color? highlightColor;
  final bool appIsLTR;
  final String? package;
  final String? textFont;
  final bool isDisabled;
  final double? letterSpacing;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _iconMargin = SuperBoxController.iconMargin(
      height: height,
      icon: icon,
      text: text,
      iconSizeFactor: iconSizeFactor,
      loading: loading,
    );
    // --------------------
    return Row(
      key: const ValueKey<String>('DreamBoxIconVerseSecondLine'),
      mainAxisAlignment: SuperBoxController.getContentsRowMainAxisAlignment(
        centered: centered,
      ),
      textDirection: textDirection,
      children: <Widget>[

        /// --- ICON BOX footprint
        if (icon != null || loading == true)
          SuperBoxIcon(
            iconSizeFactor: iconSizeFactor,
            loading: loading,
            greyScale: greyScale,
            solidGreyScale: solidGreyScale,
            iconColor: iconColor,
            corners: iconCorners,
            isDisabled: isDisabled,
            height: height,
            icon: icon,
            backgroundColor: backgroundColor,
            package: package,
          ),

        /// --- VERSE LEFT SPACING
        if (text != null)
          SizedBox(
            // color: Colorz.bloodTest,
            width: SuperBoxController.getVerseLeftSpacing(iconMargin: _iconMargin),
            height: height,
          ),

        /// --- VERSES
        if (text != null)
          SuperBoxTexts(
            text: text,
            textDirection: textDirection,
            icon: icon,
            loading: loading,
            height: height,
            width: width,
            greyScale: greyScale,
            iconSizeFactor: iconSizeFactor,
            textScaleFactor: textScaleFactor,
            textCentered: textCentered,
            secondText: secondText,
            textWeight: textWeight,
            textColor: textColor,
            textMaxLines: textMaxLines,
            secondTextMaxLines: secondTextMaxLines,
            textItalic: textItalic,
            redDot: redDot,
            secondTextColor: secondTextColor,
            centered: centered,
            highlight: highlight,
            highlightColor: highlightColor,
            appIsLTR: appIsLTR,
            textFont: textFont,
            isDisabled: isDisabled,
            package: package,
            letterSpacing: letterSpacing,
          ),

        /// --- VERSE RIGHT SPACING
        if (text != null)
          SizedBox(
            height: height,
            width: SuperBoxController.getVerseRightSpacing(iconMargin: _iconMargin),
            // color: Colorz.bloodTest,
          ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
