

import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

/// => TAMAM
class DotSeparator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DotSeparator({
    this.bottomMarginIsOn = true,
    this.color = const Color.fromARGB(80, 121, 121, 121),
    this.boxWidth,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final bool bottomMarginIsOn;
  final Color color;
  final double? boxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double screenWidth = boxWidth ?? Scale.screenWidth(context);

    return Container(
      width: screenWidth,
      height: 15,
      alignment: Alignment.center,
      margin: bottomMarginIsOn ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
