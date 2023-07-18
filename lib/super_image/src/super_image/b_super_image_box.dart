part of super_image;

class SuperImageBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImageBox({
    required this.child,
    required this.width,
    required this.height,
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
          colorFilter: ColorFilter.mode(greyscale == true ? Colorz.grey150 : Colorz.nothing, BlendMode.srcIn),
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
