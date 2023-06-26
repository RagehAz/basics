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

    return ClipRRect(
      key: const ValueKey<String>('SuperImageBox'),
      borderRadius: Borderers.superCorners(
        corners: corners,
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(greyscale == true ? Colorz.grey255 : Colorz.nothing, BlendMode.saturation),
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
  /// --------------------------------------------------------------------------
}
