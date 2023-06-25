

import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PullToRefresh({
    required this.child,
    required this.fadeOnBuild,
    required this.onRefresh,
    this.circleColor = const Color.fromARGB(230, 230, 230, 230),
    this.arrowColor = const Color.fromARGB(230, 0, 0, 0),
    this.fadingMilliseconds = 700,
    this.displacement = 50,
    this.strokeWidth = 4,
    this.edgeOffset = 50,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final Future<void> Function()? onRefresh;
  final bool fadeOnBuild;
  final Widget child;
  final Color circleColor;
  final Color arrowColor;
  final int fadingMilliseconds;
  final double displacement;
  final double strokeWidth;
  final double edgeOffset;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        onRefresh: () async {

          if (onRefresh != null){
            await onRefresh?.call();
          }

        },
        color: arrowColor,
        backgroundColor: circleColor,
        displacement: displacement,
        strokeWidth: strokeWidth,
        edgeOffset: edgeOffset,
        // notificationPredicate: (ScrollNotification scrollNotification){
        // blog('scrollNotification.metrics.pixels : ${scrollNotification.metrics.pixels}');
        // blog('scrollNotification.depth : ${scrollNotification.depth}');
        //   return true;
        // },
        // triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child:

        fadeOnBuild == true ?
        WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: Duration(milliseconds: fadingMilliseconds),
          child: child,
        )
            :
        child

    );

  }
/// --------------------------------------------------------------------------
}
