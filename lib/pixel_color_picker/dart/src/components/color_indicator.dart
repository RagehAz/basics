part of pixel_color_picker;

class _Indicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Indicator({
    required this.controller,
    required this.indicatorSize,
    required this.showCrossHair,
    required this.indicatorIsOn,
  });
  // --------------------
  final ColorPickerController controller;
  final double indicatorSize;
  final bool showCrossHair;
  final bool indicatorIsOn;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return LiveWire(
      wire: controller.offset,
      builder: (Offset offset, Widget? child) {
        return Positioned(
          top: offset.dy - (indicatorSize / 2) - indicatorSize - 10,
          left: offset.dx - (indicatorSize / 2),
          child: child!,
        );
      },
      child: WidgetFader(
        fadeType: indicatorIsOn == true ? FadeType.fadeIn : FadeType.fadeOut,
        duration: indicatorIsOn == true ? const Duration(milliseconds: 200) : const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            SingleWire(
                wire: controller.color,
                builder: (Color? _color) {
                  return Container(
                    width: indicatorSize,
                    height: indicatorSize,
                    decoration: BoxDecoration(
                      color: _color,
                      border: Border.all(
                        color: Colorz.white200,
                      ),
                      borderRadius: BorderRadius.circular(indicatorSize / 2),
                    ),
                  );
                }
            ),

            if (showCrossHair == true)
              const Spacing(
                // size: 10
              ),

            if (showCrossHair == true)
              Material(
                child: SuperBox(
                  width: indicatorSize,
                  height: indicatorSize,
                  icon: '+',
                  bubble: false,
                ),
              ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
