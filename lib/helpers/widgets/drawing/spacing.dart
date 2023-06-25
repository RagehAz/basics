import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Spacing({
    this.heightFactor = 1,
    this.size = 10,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double heightFactor;
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (heightFactor == 1){
      return SizedBox(
        height: size,
        width: size,
      );
    }

    else {
      return SizedBox(
        height: size * heightFactor,
        width: size * heightFactor,
      );
    }

  }
/// --------------------------------------------------------------------------
}
