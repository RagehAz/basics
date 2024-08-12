part of pixel_color_picker;

class _Indicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Indicator({
    required this.controller,
    required this.indicatorSize,
    required this.showCrossHair,
  });
  // --------------------
  final ColorPickerController controller;
  final double indicatorSize;
  final bool showCrossHair;
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
      child: LiveWire(
        wire: controller.indicatorIsVisible,
        builder: (bool isVisible, Widget? child) {
          return WidgetFader(
            fadeType: isVisible == true ? FadeType.fadeIn : FadeType.fadeOut,
            duration: isVisible == true ? const Duration(milliseconds: 200) : const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: child!,
          );
        },
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
