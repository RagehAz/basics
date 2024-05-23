import 'package:basics/helpers/space/aligner.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class ButtonToThePower extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ButtonToThePower({
    required this.totalWidth,
    required this.bottomChild,
    required this.topChild,
    this.topChildWidthRatio = 0.1,
    super.key
  });
  // --------------------
  final double totalWidth;
  final double topChildWidthRatio;
  final Widget Function(double width) bottomChild;
  final Widget Function(double width) topChild;
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
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
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
