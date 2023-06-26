import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

import 'stars_layer.dart';

class SkyStars extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SkyStars({
    required this.starsAreOn,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final bool starsAreOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (starsAreOn == false){
      return const SizedBox();
    }
    // --------------------
    else {
      return SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        child: const Stack(
          children: <Widget>[

            StarsLayer(
              numberOfStars: 1,
              seconds: 3,
              starSize: 4,
              color: Colorz.white80,
            ),

            StarsLayer(
              numberOfStars: 1,
              seconds: 3,
              starSize: 5,
              color: Colorz.white125,
            ),

            StarsLayer(
              numberOfStars: 10,
              color: Colorz.yellow255,
              seconds: 4,
              starSize: 3,
            ),

            StarsLayer(
              numberOfStars: 5,
              color: Colorz.yellow255,
              // seconds: 2,
              starSize: 2.5,
            ),

            StarsLayer(
              numberOfStars: 80,
              color: Colorz.white125,
              seconds: 6,
              starSize: 2,
            ),

          ],
        ),
      );
    }
    // --------------------
  }
/// --------------------------------------------------------------------------
}
