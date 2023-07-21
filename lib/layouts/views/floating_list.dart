import 'package:basics/helpers/classes/space/borderers.dart';
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
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
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
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (scrollDirection == Axis.vertical){
      return SingleChildScrollView(
        physics: physics,
        scrollDirection: scrollDirection,
        child: Container(
          width: width ?? Scale.screenWidth(context),
          constraints: BoxConstraints(
            minHeight: height ?? Scale.screenHeight(context),
          ),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: Borderers.superCorners(corners: boxCorners),
          ),
          alignment: boxAlignment,
          padding: padding,
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      );
    }
    // --------------------
    else {

      /// CAUTION : IF YOU CHANGE THIS,, IT IMPACTS ShelfSlidesPart() WIDGET, TAKE CARE
      return SingleChildScrollView(
        physics: physics,
        scrollDirection: scrollDirection,
        child: Container(
          height: height ?? Scale.screenHeight(context),
          constraints: BoxConstraints(
            minWidth: width ?? Scale.screenWidth(context),
          ),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: Borderers.superCorners(corners: boxCorners),
          ),
          alignment: boxAlignment,
          padding: padding,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      );

    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
