import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class MultiFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MultiFloatingList({
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
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
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
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (scrollDirection == Axis.vertical){
      return VerticalFloatingList(
        columnChildren: columnChildren,
        width: width,
        height: height,
        physics: physics,
        borderColor: borderColor,
        boxColor: boxColor,
        padding: padding,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        boxAlignment: boxAlignment,
        boxCorners: boxCorners,
        scrollController: scrollController,
      );
    }
    // --------------------
    else {

      return HorizontalFloatingList(
        columnChildren: columnChildren,
        width: width,
        height: height,
        physics: physics,
        borderColor: borderColor,
        boxColor: boxColor,
        padding: padding,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        boxAlignment: boxAlignment,
        boxCorners: boxCorners,
        scrollController: scrollController,
      );

    }
    // --------------------
  }
// --------------------------------------------------------------------------
}

class VerticalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ScrollConfiguration(
      behavior: const AppScrollBehavior(),
      child: SingleChildScrollView(
        physics: physics,
        // scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Container(
          width: width ?? Scale.screenWidth(context),
          constraints: BoxConstraints(
            minHeight: height ?? Scale.screenHeight(context),
          ),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: Borderers.superCorners(corners: boxCorners),
              border: borderColor == null ? null :
              Border.all(
                width: 0.5,
                color: borderColor!,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
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
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class HorizontalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HorizontalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// CAUTION : IF YOU CHANGE THIS,, IT IMPACTS ShelfSlidesPart() WIDGET, TAKE CARE
    return Container(
      height: height ?? Scale.screenHeight(context),
      width: width,
      // constraints: BoxConstraints(
      //   minWidth: width ?? Scale.screenWidth(context),
      // ),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: Borderers.superCorners(corners: boxCorners),
      ),
      alignment: boxAlignment,
      child: ScrollConfiguration(
        behavior: const AppScrollBehavior(),
        child: SingleChildScrollView(
          physics: physics,
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          padding: padding,
          child: Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
