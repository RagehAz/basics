part of super_image;

class InfiniteLoadingBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    required this.width,
    required this.height,
    this.color,
    this.backgroundColor = Colorz.white50,
    this.milliseconds = 1900,
    this.corners,
    super.key
  }); 
  // --------------------
  final double? width;
  final double? height;
  final Color? color;
  final Color backgroundColor;
  final int milliseconds;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? 40;
    final double _height = height ?? _width;
    final double _stripHeight = _height * 0.5;
    final Color _color = color ?? Colorz.white50;

    final BorderRadius _borders = Borderers.superCorners(corners: corners);

    return Center(
      child: ClipRRect(
        borderRadius: _borders,
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: _borders,
          ),
          child: WidgetFader(
            fadeType: FadeType.repeatForwards,
            // fadeType: FadeType.stillAtMin,
            // min: 0.4,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: milliseconds),
            builder: (double value, Widget? child){

              return Stack(
                children: <Widget>[

                  /// UPPER HALF
                  Positioned(
                    bottom: (_height * value * 1.6)  - _stripHeight - _stripHeight,
                    left: 0,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: SizedBox(
                        width: _width,
                        height: _stripHeight,
                        // color: Colorz.blue125,
                        child: Transform.scale(
                          scaleX: _width / _stripHeight,
                          child: WebsafeSvg.asset(
                            Iconz.boxShadowBlack,
                            colorFilter: ColorFilter.mode(_color, BlendMode.srcIn),
                            width: _width,
                            height: _stripHeight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// LOWER HALF
                  Positioned(
                    bottom: (_height * value * 1.6) + (_stripHeight * 0.999) - _stripHeight - _stripHeight,
                    left: 0,
                    child: SizedBox(
                      width: _width,
                      height: _stripHeight,
                      child: Transform.scale(
                        scaleX: _width / _stripHeight,
                        child: WebsafeSvg.asset(
                          Iconz.boxShadowBlack,
                          // fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(_color, BlendMode.srcIn),
                          width: _width,
                          height: _stripHeight,
                        ),
                      ),
                    ),

                  ),

                ],
              );

            },
          ),
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
