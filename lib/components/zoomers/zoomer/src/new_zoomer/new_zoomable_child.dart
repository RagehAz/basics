// ignore_for_file: unused_element, unused_element_parameter

part of zoomer;

class _ZoomableChild extends StatefulWidget {
  // --------------------
  const _ZoomableChild({
    required this.child,
    required this.autoShrink,
    this.minZoom = 0.8,
    this.maxZoom = 8,
    this.transformationController,

    this.boundaryMargin = EdgeInsets.zero,

    this.maxOverlayOpacity = 0.5,
    this.overlayColor = Colors.black,
    this.fingersRequiredToPinch = 2,
    this.twoFingersOn,
    this.twoFingersOff,

    this.useOverlay = true,
    this.rootOverlay = false,
    this.resetDuration = defaultResetDuration,
    this.resetCurve = Curves.ease,
    this.clipBehavior = Clip.none,
    super.key,
  })  : assert(minZoom > 0, 'minScale should be bigger than zero'),
        assert(maxZoom > 0, 'maxScale should be bigger than zero'),
        assert(maxZoom >= minZoom, 'maxScale should be bigger than minScale');
  // --------------------------------------------------------------------------
  final Widget child;
  final double maxZoom;
  final double minZoom;
  final TransformationController? transformationController;
  final EdgeInsets boundaryMargin;
  final bool autoShrink;

  final double maxOverlayOpacity;
  final Color overlayColor;
  /// Fingers required to start a pinch,
  /// if it's zero or below zero no validation will be performed
  final int fingersRequiredToPinch;
  /// This function is super useful to block scroll and make the pinch to zoom easier
  final void Function()? twoFingersOn;
  /// Function to unblock scroll again
  final void Function()? twoFingersOff;

  /// If it's true will create a new widget to zoom, to occupy the entire screen
  ///
  /// The problem of using an overlay is if you want to zoom in a scrollable widget
  /// as the widget is rebuilt to occupy the entire screen
  /// can lose the scroll or any other state
  final bool useOverlay;
  /// If `rootOverlay` is set to true, the state from the furthest instance of
  /// this class is given instead. Useful for installing overlay entries above
  /// all subsequent instances of [Overlay].
  final bool rootOverlay;
  final Duration resetDuration;
  final Curve resetCurve;
  final Clip clipBehavior;
  // --------------------
  static const Duration defaultResetDuration = Duration(milliseconds: 200);
  // --------------------
  @override
  State<_ZoomableChild> createState() => _ZoomableChildState();
  // --------------------------------------------------------------------------
}

class _ZoomableChildState extends State<_ZoomableChild> with TickerProviderStateMixin {
  // --------------------
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  /// cached across resetAnimation() calls -- only depends on
  /// animationController (stable for the State's lifetime) and
  /// widget.resetCurve (invalidated in didUpdateWidget if it changes),
  /// so there's no need to allocate a new one on every pinch-zoom reset.
  CurvedAnimation? _resetCurvedAnimation;
  OverlayEntry? entry;
  List<OverlayEntry> overlayEntries = [];
  double scale = 1;
  final List<int> events = [];
  // --------------------
  @override
  void initState() {

    super.initState();


    transformationController = TransformationController();

    animationController = AnimationController(
      vsync: this,
      duration: widget.resetDuration,
    )
      ..addListener(transformationListener)
      ..addStatusListener(transformationStatusListener);

  }
  // --------------------
  @override
  void didUpdateWidget(_ZoomableChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetCurve != widget.resetCurve){
      _resetCurvedAnimation?.dispose();
      _resetCurvedAnimation = null;
    }
  }
  // --------------------
  @override
  void dispose() {
    transformationController.dispose();
    animationController.dispose();
    _resetCurvedAnimation?.dispose();

    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  ///
  void transformationListener(){
    transformationController.value = animation!.value;
  }
  // --------------------
  ///
  void transformationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed && widget.useOverlay) {
      Future.delayed(const Duration(milliseconds: 100), removeOverlay);
    }
  }
  // --------------------------------------------------------------------------

  /// OVER-LAY

  // --------------------
  ///
  void showOverlay(BuildContext context) {

    final OverlayState overlay = Overlay.of(
      context,
      rootOverlay: widget.rootOverlay,
    );

    final RenderBox renderBox = context.findRenderObject()! as RenderBox;

    final Offset offset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay.context.findRenderObject(),
    );

    entry = OverlayEntry(
        builder: (context) {

          final double _unClampedOpacity = (scale - 1) / (widget.maxZoom - 1);
          final double opacity = _unClampedOpacity.clamp(0, widget.maxOverlayOpacity);

          return Material(
            color: Colors.green.withAlpha(0),
            child: Stack(
              children: <Widget>[

                Positioned.fill(
                  child: Opacity(
                    opacity: opacity,
                    child: Container(color: widget.overlayColor),
                  ),
                ),

                Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: SizedBox(
                    width: renderBox.size.width,
                    height: renderBox.size.height,
                    child: buildWidget(widget.child),
                  ),
                ),

              ],
            ),
          );
        });

    overlay.insert(entry!);

    // We need to control all the overlays added to avoid problems in scrolling,
    overlayEntries.add(entry!);

  }
  // --------------------
  ///
  void removeOverlay() {

    for (final OverlayEntry entry in overlayEntries) {
      entry.remove();
    }

    overlayEntries.clear();
    entry = null;

  }
  // --------------------------------------------------------------------------

  /// ANIMATION

  // --------------------
  ///
  void resetAnimation() {

    if (mounted) {

      final CurvedAnimation _curvedAnimation = _resetCurvedAnimation ??= CurvedAnimation(
        parent: animationController,
        curve: widget.resetCurve,
      );

      animation = Matrix4Tween(
          begin: transformationController.value,
          end: Matrix4.identity()
      ).animate(_curvedAnimation);

      animationController.forward(from: 0);

    }

  }
  // --------------------------------------------------------------------------

  /// GESTURES

  // --------------------
  ///
  void onPointerDown(PointerEvent event) {

    events.add(event.pointer);

    final int pointers = events.length;

    if (pointers >= 2 && widget.twoFingersOn != null) {
      widget.twoFingersOn!.call();
    }

  }
  // --------------------
  ///
  void onPointerUp(PointerUpEvent event) {

    events.clear();

    if (widget.twoFingersOff != null) {
      widget.twoFingersOff!.call();
    }

  }
  // --------------------
  ///
  void onInteractionStart(ScaleStartDetails details) {

    if (widget.fingersRequiredToPinch > 0 && details.pointerCount != widget.fingersRequiredToPinch) {
      return;
    }

    if (widget.useOverlay) {
      showOverlay(context);
    }

  }
  // --------------------
  ///
  void onInteractionEnd(ScaleEndDetails details) {

    if (overlayEntries.isEmpty) {
      return;
    }

    if (widget.autoShrink == true) {
      resetAnimation();
    }

    else {
      removeOverlay();
    }

  }
  // --------------------
  ///
  void onInteractionUpdate(ScaleUpdateDetails details) {
    if (entry == null) {
      return;
    }

    /// skip the rebuild when the scale barely moved -- imperceptible in the
    /// overlay opacity it drives, but avoids a markNeedsBuild() on every
    /// single gesture-update event.
    if ((details.scale - scale).abs() < 0.001) {
      return;
    }

    scale = details.scale;
    entry?.markNeedsBuild();
  }
  // --------------------------------------------------------------------------

  /// WIDGET BUILDER

  // --------------------
  Widget buildWidget(Widget zoomableWidget) => Builder(
    builder: (context) => Listener(
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      child: InteractiveViewer(
        clipBehavior: widget.clipBehavior,
        minScale: widget.minZoom,
        maxScale: widget.maxZoom,
        transformationController: transformationController,
        onInteractionStart: onInteractionStart,
        onInteractionEnd: onInteractionEnd,
        onInteractionUpdate: onInteractionUpdate,
        panEnabled: false,
        boundaryMargin: widget.boundaryMargin,
        // alignment: ,
        // scaleFactor: ,
        // key: ,
        // constrained: ,
        // interactionEndFrictionCoefficient: ,
        // panAxis: ,
        // scaleEnabled: ,
        // trackpadScrollCausesScale: ,
        child: widget.child,
      ),
    ),
  );
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context){

    return buildWidget(widget.child);

  }
  // --------------------------------------------------------------------------
}
