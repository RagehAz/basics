import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

class FloatingList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.scrollDirection = Axis.vertical,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SingleChildScrollView(
      physics: physics,
      scrollDirection: scrollDirection,
      child: Container(
        width: width ?? Scale.screenWidth(context),
        constraints: BoxConstraints(
          minHeight: height ?? Scale.screenHeight(context),
        ),
        alignment: Alignment.center,
        padding: padding,
        child:
        scrollDirection == Axis.vertical ?
        Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: <Widget>[
            ...?columnChildren,
          ],
        )

            :

        Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: <Widget>[
            ...?columnChildren,
          ],
        )
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
