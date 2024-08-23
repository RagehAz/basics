// ignore_for_file: unused_element
part of super_slider;

class _SliderBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _SliderBox({
    required this.width,
    required this.height,
    required this.sliderThemData,
    required this.child,
    this.values,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double width;
  final double height;
  final SliderThemeData sliderThemData;
  final Widget child;
  final List<dynamic>? values;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _half = height / 2;
    final double _dotRadius = _half;
    final double _sideMargin = _half - _dotRadius;
    final double _lineZoneWidth = width - (2 * _sideMargin);

    return SizedBox(
      width: width,
      height: height,
      child: SliderTheme(
        data: sliderThemData,
        child: Stack(
          children: <Widget>[

            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: Borderers.cornerAll(_half),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Spacing(size: _sideMargin),

                  SizedBox(
                    width: _lineZoneWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        if (Lister.checkCanLoop(values) == true)
                          ...List.generate(values!.last+1, (index){

                            final bool _isOn = values!.contains(index);

                            return Container(
                              width: _dotRadius * 2,
                              height: _dotRadius * 2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isOn == true ? Colorz.white20 : Colorz.nothing,
                              ),
                            );

                          }),

                      ],
                    ),
                  ),


                  Spacing(size: _sideMargin),

                ],
              ),
            ),

            child,

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
