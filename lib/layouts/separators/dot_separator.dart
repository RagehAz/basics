import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

/// => TAMAM
class DotSeparator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const DotSeparator({
    this.bottomMarginIsOn = true,
    this.color = const Color.fromARGB(80, 121, 121, 121),
    this.boxWidth,
    super.key
  }); 
  // --------------------------------
  final bool bottomMarginIsOn;
  final Color color;
  final double? boxWidth;
  // --------------------------------
  static const double dotSize = 5;
  static const double topMargin = 10;
  static const double bottomMargin = 10;
  // --------------------------------
  static double getTotalHeight({
    bool bottomMarginIsOn = true,
  }){
    return bottomMarginIsOn == true ? dotSize + topMargin + bottomMargin : dotSize + topMargin;
  }
  // --------------------------------
  @override
  Widget build(BuildContext context) {

    final double screenWidth = boxWidth ?? Scale.screenWidth(context);

    return Container(
      width: screenWidth,
      height: dotSize + topMargin,
      alignment: Alignment.center,
      margin: bottomMarginIsOn ? const EdgeInsets.only(bottom: bottomMargin) : EdgeInsets.zero,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
