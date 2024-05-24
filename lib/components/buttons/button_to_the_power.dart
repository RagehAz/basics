import 'package:basics/helpers/space/aligner.dart';
import 'package:flutter/material.dart';

class ButtonToThePower extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ButtonToThePower({
    required this.totalWidth,
    required this.bottomChild,
    required this.topChild,
    required this.appIsLTR,
    this.topChildWidthRatio = 0.1,
    super.key
  });
  // --------------------
  final double totalWidth;
  final double topChildWidthRatio;
  final Widget Function(double width) bottomChild;
  final Widget Function(double width) topChild;
  final bool appIsLTR;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _topItemWidth = totalWidth * topChildWidthRatio;
    // --------------------
    final double _bottomItemWidth = totalWidth - _topItemWidth;
    // --------------------
    return SizedBox(
      width: totalWidth,
      child: Center(
        child: Stack(
          alignment: Aligner.top(
            appIsLTR: appIsLTR,
            inverse: true,
          ),
          children: <Widget>[

            bottomChild(_bottomItemWidth),

            topChild(_topItemWidth),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
