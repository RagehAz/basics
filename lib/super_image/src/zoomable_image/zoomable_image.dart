// ignore_for_file: unused_element
part of super_image;

class ZoomableImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoomableImage({
    required this.child,
    this.onTap,
    this.autoShrink = true,
    this.isFullScreen = false,
    this.canZoom = true,
    this.transformationController,
    this.minZoom = 0.3,
    this.maxZoom = 3,
    this.offset,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget child;
  final bool autoShrink;
  final bool isFullScreen;
  final Function? onTap;
  final TransformationController? transformationController;
  final bool canZoom;
  final double minZoom;
  final double maxZoom;
  final Offset? offset;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canZoom == true){
      return _ZoomableChild(
        onTap: onTap,
        autoShrink: autoShrink,
        isFullScreen: isFullScreen,
        transformationController: transformationController,
        minZoom: minZoom,
        maxZoom: maxZoom,
        offset: offset,
        child: child,
      );
    }

    else {
      return child;
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _ZoomableChild extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _ZoomableChild({
    required this.child,
    required this.onTap,
    required this.autoShrink,
    required this.isFullScreen,
    required this.transformationController,
    required this.minZoom,
    required this.maxZoom,
    required this.offset,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget? child;
  final bool autoShrink;
  final bool isFullScreen;
  final Function? onTap;
  final TransformationController? transformationController;
  final double minZoom;
  final double maxZoom;
  final Offset? offset;
  /// --------------------------------------------------------------------------
  @override
  _ZoomableChildState createState() => _ZoomableChildState();
  /// --------------------------------------------------------------------------
}

class _ZoomableChildState extends State<_ZoomableChild> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  late TransformationController _transformationController;
  late AnimationController _zoomAnimationController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _transformationController = widget.transformationController ?? TransformationController();

    if (widget.offset != null){
      _transformationController.value = Trinity.move(
          matrix: Matrix4.identity(),
          x: widget.offset!.dx,
          y: widget.offset!.dy,
      );
    }

    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    /// REMOVED
    _transformationController.addListener(_transListener);

  }
  // --------------------
  @override
  void dispose() {
    _transformationController.removeListener(_transListener);
    _transformationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  void _transListener() {
    if (_transformationController.value.getMaxScaleOnAxis() > 1.5) {
      // blog('XX its bigger than 1.5 now');
    }
  }
  // -----------------------------------------------------------------------------

  /// ACTIONS

  // --------------------
  Future<void> _resetZoom() async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    void _listener() {

      setNotifier(
          notifier: _transformationController,
          mounted: mounted,
          value: _reset.value,
      );

    }

    /// REMOVED
    _zoomAnimationController.addListener(_listener);

    _zoomAnimationController.reset();

    await _zoomAnimationController.forward();

    _zoomAnimationController.removeListener(_listener);

  }
  // --------------------
  Future<void> _onDoubleTap() async {
    await _resetZoom();
       await Future.delayed(Duration.zero, () {
          Navigator.pop(context);
        });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {

        blog('tapping aho');

        if (widget.isFullScreen == true) {
          await _resetZoom();
        }

        if (widget.onTap != null){
          await widget.onTap!.call();
        }

      },
      onDoubleTap: widget.isFullScreen == false ? null : () => _onDoubleTap(),

      child: InteractiveViewer(
        // key: widget.key,
        // panEnabled: false,
        // scaleEnabled: true,
        transformationController: _transformationController,
        constrained: false,
        maxScale: widget.maxZoom,
        minScale: widget.minZoom,
        boundaryMargin: const EdgeInsets.all(double.infinity),

        // panAxis: PanAxis.free,

        /// MOUSE SCROLL SCALING
        // scaleFactor: 0.1,
        alignment: Alignment.center,
        // interactionEndFrictionCoefficient: 0.5,
        // trackpadScrollCausesScale: false,

        onInteractionEnd: (ScaleEndDetails scaleEndDetails) async {

          if (widget.autoShrink == true) {
            await _resetZoom();
          }

          else {
            // await Future.delayed(Duration(seconds: 5), () async {
            //   await resetZoom();
            // });
          }

        },

        // onInteractionStart: (ScaleStartDetails scaleStartDetails){
        //   blog('scaleStartDetails : $scaleStartDetails');
        //   },
        // onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
        //   blog('scaleUpdateDetails : $scaleUpdateDetails');
        //   },

        child: widget.child ?? const SizedBox(),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
