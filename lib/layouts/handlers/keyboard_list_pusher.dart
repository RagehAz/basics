
import 'package:flutter/material.dart';

/// PUT THIS IN THE BOTTOM OF A LIST OR COLUMN
/// IT EXPANDS IN RESPONSE TO KEYBOARD HEIGHT WHEN APPEARS ON SCREEN
/// SHRINKS TO INITIAL HEIGHT WHEN KEYBOARD IS CLOSED
class KeyboardPusher extends StatelessWidget {

  const KeyboardPusher({
    this.initialHeight = 0,
    this.sizingFactor = 1.2,
  super.key
  });
  final double initialHeight;
  final double sizingFactor;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: initialHeight,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom * sizingFactor,
      ),
    );

  }

}
