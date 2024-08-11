part of pixel_color_picker;

class PixelColorPicker extends StatefulWidget {
  // --------------------------------------------------------------------------
  const PixelColorPicker({
    required this.child,
    required this.initialColor,
    required this.indicatorSize,
    required this.showIndicator,
    required this.showCrossHair,
    this.controller,
    this.onColorChangeEnded,
    this.onColorChanged,
    // this.onSnapshotCreated,
    super.key
  });
  // --------------------
  final Widget child;
  final Color initialColor;
  final double indicatorSize;
  final bool showIndicator;
  final bool showCrossHair;
  final ColorPickerController? controller;
  final Function(Color? color)? onColorChangeEnded;
  final Function(Color? color)? onColorChanged;
  // final Function(Uint8List? snapshot)? onSnapshotCreated;
  // --------------------
  @override
  _PixelColorPickerState createState() => _PixelColorPickerState();
  // --------------------------------------------------------------------------
}

class _PixelColorPickerState extends State<PixelColorPicker> {
  // -----------------------------------------------------------------------------
  late ColorPickerController _controller;
  // --------------------
  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? ColorPickerController();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _isInit = false; // good

      if (widget.controller == null){

        asyncInSync(() async {
          await _controller.snapshotWidgetTree(
            context: context,
            mounted: mounted,
          );
        });

      }

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(PixelColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null){
      _controller._onDidUpdateWidget(
        oldWidget: oldWidget,
        newWidget: widget,
        mounted: mounted,
        context: context,
      );
    }

  }
  // --------------------
  @override
  void dispose() {
    if (widget.controller == null){
      _controller.dispose();
    }
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return RepaintBoundary(
      key: _controller.paintKey,
      child: SingleWire(
        wire: _controller.isPicking,
        builder: (bool indicatorIsOn) {

          return GestureDetector(

            /// ON START
            onPanStart: indicatorIsOn == false ? null : (details) => _controller._onPanUpdate(
              globalPosition: details.globalPosition,
              mounted: mounted,
              context: context,
              onColorChanged: widget.onColorChanged,
            ),
            /// ON MOVING
            onPanUpdate: indicatorIsOn == false ? null : (details) => _controller._onPanUpdate(
              globalPosition: details.globalPosition,
              mounted: mounted,
              context: context,
              onColorChanged: widget.onColorChanged,
            ),
            /// ON END
            onPanEnd: indicatorIsOn == false ? null : (details) => _controller._onPanEnd(
              globalPosition: details.globalPosition,
              mounted: mounted,
              context: context,
              onColorChangeEnded: widget.onColorChangeEnded,
            ),

            child: Stack(
              children: <Widget>[

                  widget.child,

                if (widget.showIndicator == true)
                  _Indicator(
                    showCrossHair: widget.showCrossHair,
                    indicatorSize: widget.indicatorSize,
                    controller: _controller,
                    indicatorIsOn: indicatorIsOn,
                  ),

              ],
            ),
          );
        }
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
