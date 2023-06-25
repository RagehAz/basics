import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:flutter/material.dart';
import 'random_stars.dart';

class StarsLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StarsLayer({
    required this.numberOfStars,
    this.seconds = 2,
    this.minOpacity = 0,
    this.maxOpacity = 1,
    this.color = Colorz.white255,
    this.starSize = 1,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final int numberOfStars;
  final int seconds;
  final double minOpacity;
  final double maxOpacity;
  final Color color;
  final double starSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: FadeType.repeatAndReverse,
      min: minOpacity,
      max: maxOpacity,
      duration: Duration(seconds: seconds),
      child: Stack(
        children: <Widget>[

          ...List.generate(numberOfStars, (index){
            return RandomStar(
              size: starSize,
              color: color,
            );
          }),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
