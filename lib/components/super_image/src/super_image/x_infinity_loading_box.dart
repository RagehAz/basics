part of super_image;

class InfiniteLoadingBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    required this.width,
    required this.height,
    this.color,
    this.backgroundColor = Colorz.white50,
    super.key
  }); 
  // --------------------
  final double? width;
  final double? height;
  final Color? color;
  final Color backgroundColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? 40;
    final double _height = height ?? _width;
    final double _stripHeight = _height * 0.5;
    const Color _color = Colorz.white50;

    return Center(
      child: SizedBox(
        width: _width,
        height: _height,
        child: WidgetFader(
          fadeType: FadeType.repeatForwards,
          // fadeType: FadeType.stillAtMin,
          // min: 0.4,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 2300),
          builder: (double value, Widget? child){

            return Stack(
              children: <Widget>[

                ///
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
                          colorFilter: const ColorFilter.mode(_color, BlendMode.srcIn),
                          width: _width,
                          height: _stripHeight,
                        ),
                      ),
                    ),
                  ),
                ),

                ///
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
                        colorFilter: const ColorFilter.mode(_color, BlendMode.srcIn),
                        width: _width,
                        height: _stripHeight,
                      ),
                    ),
                  ),
                  // child: Transform.scale(
                  //   scaleX: _width / _stripHeight,
                  //   child: WebsafeSvg.asset(
                  //     Iconz.boxShadowWhite,
                  //     fit: BoxFit.fitWidth,
                  //     colorFilter: const ColorFilter.mode(Colorz.red125, BlendMode.hardLight),
                  //     width: _width,
                  //     height: _stripHeight,
                  //   ),
                  // ),
                ),

              ],
            );

          },
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
