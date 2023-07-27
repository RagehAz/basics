part of super_image;

class SuperImageBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImageBox({
    required this.child,
    required this.width,
    required this.height,
    required this.solidGreyScale,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    super.key,
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final BoxFit boxFit;
  final double? scale;
  final Color? backgroundColor;
  final dynamic corners;
  final bool greyscale;
  final Widget? child;
  final bool solidGreyScale;
  /// --------------------------------------------------------------------------
  static ColorFilter getGreyScaleFilter({
    required bool solidGrey,
  }){

    if (solidGrey == true){
      return const ColorFilter.mode(Colorz.white80, BlendMode.srcIn);
    }
    else {
      return const ColorFilter.mode(Colorz.white200, BlendMode.color);
    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (greyscale == true){
      return ClipRRect(
        key: const ValueKey<String>('SuperImageBox1'),
        borderRadius: Borderers.superCorners(
          corners: corners,
        ),
        child: ColorFiltered(
          colorFilter: getGreyScaleFilter(solidGrey: solidGreyScale),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              // boxShadow: <BoxShadow>[
              //   Shadowz.CustomBoxShadow(
              //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
              //       offset: Offset(0, width * -0.019),
              //       blurRadius: width * 0.2,
              //       style: BlurStyle.outer
              //   ),
              // ]
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        ),
      );
    }

    else if (corners == null || corners == EdgeInsets.zero || corners == 0){
      return Container(
        key: const ValueKey<String>('SuperImageBox2'),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          // boxShadow: <BoxShadow>[
          //   Shadowz.CustomBoxShadow(
          //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
          //       offset: Offset(0, width * -0.019),
          //       blurRadius: width * 0.2,
          //       style: BlurStyle.outer
          //   ),
          // ]
        ),
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale,
          child: child,
        ),
      );
    }
    
    else {
      return ClipRRect(
        key: const ValueKey<String>('SuperImageBox3'),
        borderRadius: Borderers.superCorners(
          corners: corners,
        ),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              // boxShadow: <BoxShadow>[
              //   Shadowz.CustomBoxShadow(
              //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
              //       offset: Offset(0, width * -0.019),
              //       blurRadius: width * 0.2,
              //       style: BlurStyle.outer
              //   ),
              // ]
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
      );
    }

  }
  /// --------------------------------------------------------------------------
}
