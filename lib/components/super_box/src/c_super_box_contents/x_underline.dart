import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

class UnderLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UnderLine({
    required this.width,
    required this.height,
    required this.underLine,
    required this.icon,
    required this.underLineColor,
    required this.verseSize,
    required this.scaleFactor,
    required this.underLineShadowIsOn,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final String? underLine;
  final String? icon;
  final Color? underLineColor;
  final int? verseSize;
  final double? scaleFactor;
  final bool underLineShadowIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final double _iconBoxHeight = width; // ?? 0;
    final double _underLineHeight = height; // ?? 0 - _iconBoxHeight;
    // --------------------
    final double _underLineTopMargin =
    underLine == null ? 0
        :
     ObjectCheck.objectIsSVG(icon) == true ? (width - (_underLineHeight * 0.1)) * 1
        : // (width - ((width - _graphicWidth)/2)) * 0.0 :
    width;
    // --------------------
    final double _underlineHeightXXX =
        underLine == null ? 0 : height - _underLineTopMargin;
    // --------------------
    return Container(
      width: underLine == null ? height : width,
      height: underLine == null ? height : height,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// ICON footprint
          SizedBox(
            width: width,
            height: _underLineTopMargin,
            // color: Colorz.BloodTest,
          ),

          /// THE UnderLine
          if (underLine != null)
            Container(
              width: width,
              height: _underlineHeightXXX,
              color: const Color.fromARGB(10, 0, 0, 0),
              child: SuperText(
                text: underLine,
                textColor: underLineColor,
                textHeight: _underlineHeightXXX,
                maxLines: 2,
                // shadow: underLineShadowIsOn,
              ),
            ),
        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
