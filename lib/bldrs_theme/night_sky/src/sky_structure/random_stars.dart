import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:flutter/material.dart';

class RandomStar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RandomStar({
    required this.size,
    required this.color,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double size;
  final Color? color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Positioned(
      left: (Numeric.createRandomIndex(listLength: 100) / 100) * Scale.screenWidth(context),
      bottom: (Numeric.createRandomIndex(listLength: 100) / 100) * Scale.screenHeight(context),
      child: SuperImage(
        width: size,
        height: size,
        pic: Iconz.star,
        iconColor: color,
        loading: false,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
