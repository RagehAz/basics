part of trinity;

class TrinityOverlayer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TrinityOverlayer({
    required this.controller,
    required this.child,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget child;
  // --------------------
  @override
  State<TrinityOverlayer> createState() => _TrinityOverlayerState();
  // --------------------------------------------------------------------------
}

class _TrinityOverlayerState extends State<TrinityOverlayer> {
  // --------------------------------------------------------------------------
  OverlayEntry? _overlayEntry;
  // --------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        _showOverlay();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(SuperHero oldWidget) {

    super.didUpdateWidget(oldWidget);

    /*
      final double smallItemWidth;
  final Widget Function(double width) smallItem;
  final Widget Function(double width) flightItem;
  final double gridHeight;
  final double gridWidth;
  final Widget Function(double width) bigItem;
     */

    // if (
    //     oldWidget.smallItemWidth != widget.smallItemWidth ||
    //     oldWidget.gridHeight != widget.gridHeight ||
    //     oldWidget.gridWidth != widget.gridWidth ||
    //     oldWidget.id != widget.id
    // ){
    unawaited(_initializeHeroSizes());
    // }

    // if (oldWidget.thing != widget.thing) {
    //   unawaited(_doStuff());
    // }

    // _initializeHeroSizes();

  }
   */
  // --------------------
  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
  // --------------------
  void _showOverlay() {

    _overlayEntry = OverlayEntry(
      builder: (context) => OverLayLayer(
        controller: widget.controller,
        child: widget.child,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TrinityBuilder(
        controller: widget.controller,
        builder: (Matrix4 viewMatrix) {

        return Transform(
            transform: viewMatrix,
            transformHitTests: false,
            alignment: widget.controller.focalPointAlignment,
            child: widget.child
        );

      }
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class OverLayLayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const OverLayLayer({
    required this.controller,
    required this.child,
    super.key
  });
  // --------------------
  final TrinityController controller;
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final RenderBox? renderBox = controller.globalKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = renderBox?.localToGlobal(Offset.zero);
    position = position?.translate(0, - controller.safeAreaTopPadding);
    // final Size size = renderBox?.size ?? Size.zero;
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    // final double _canvasWidth = _screenWidth;
    // final double _canvasHeight = _screenWidth * 1.2;
    // --------------------
    return IgnorePointer(
      child: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        // color: Colorz.bloodTest,
        child: TrinityBuilder(
            controller: controller,
            builder: (Matrix4 viewMatrix) {

              viewMatrix = NeoMove.move(
                  matrix: viewMatrix,
                  x: position?.dx ?? 0,
                  y: position?.dy ?? 0,
              );

              return Transform(
                transform: viewMatrix,
                child: child,
                // child: SuperImage(
                //   loading: false,
                //   width: _canvasWidth,
                //   height: _canvasHeight,
                //   pic: null,
                //   backgroundColor: Colorz.black200,
                //   fit: BoxFit.contain,
                //   borderColor: Colorz.green255,
                // ),
              );
            },
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
