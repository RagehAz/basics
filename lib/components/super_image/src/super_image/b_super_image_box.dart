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
    this.solidGreyScale = false,
    this.borderColor,
    super.key,
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double height;
  final BoxFit boxFit;
  final double? scale;
  final Color? backgroundColor;
  final dynamic corners;
  final bool greyscale;
  final Widget? child;
  final bool solidGreyScale;
  final Color? borderColor;
  /// --------------------------------------------------------------------------
  static ColorFilter getGreyScaleFilter({
    required bool solidGrey,
  }){

    if (solidGrey == true){
      return const ColorFilter.mode(Colorz.white50, BlendMode.srcIn);
    }
    else {
      return const ColorFilter.mode(Colorz.white200, BlendMode.color);
    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BoxBorder? _border = borderColor == null ? null : Border.all(
      color: borderColor!,
      // width: 1,
    );

    // final double _height = height;
    // final double _bigCorner = corners.topLeft.x;
    // final double smallerHeight = _height * (scale ?? 1).clamp(0, 1);
    // final double _diff = _height - smallerHeight;
    // final double _oneSideDiff = _diff / 2;
    // final double _smallerCorner = (_bigCorner - _oneSideDiff).clamp(0, height);

    final BorderRadius _corners = Borderers.superCorners(
      corners: corners,
    );

    if (greyscale == true){

      return ClipRRect(
        borderRadius: _corners,
        child: Container(
          key: const ValueKey<String>('SuperImageBox1'),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: _border,
            borderRadius: _corners,
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
            child: ClipRRect(
              borderRadius: _corners,
              child: ColorFiltered(
                colorFilter: getGreyScaleFilter(solidGrey: solidGreyScale),
                child: child,
              ),
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
          border: _border,
          borderRadius: _corners,
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
      return Container(
        key: const ValueKey<String>('SuperImageBox3'),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: _border,
          borderRadius: _corners,
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
          child: ClipRRect(
            borderRadius: _corners,
            child: child,
          ),
        ),
      );
    }

  }
  /// --------------------------------------------------------------------------
}
