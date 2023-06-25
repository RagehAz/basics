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
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget child;
  final bool autoShrink;
  final bool isFullScreen;
  final Function? onTap;
  final TransformationController? transformationController;
  final bool canZoom;
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
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final Widget? child;
  final bool autoShrink;
  final bool isFullScreen;
  final Function? onTap;
  final TransformationController? transformationController;
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
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _transformationController.addListener(() {
      if (_transformationController.value.getMaxScaleOnAxis() > 1.5) {
        // blog('XX its bigger than 1.5 now');
      }
    });
  }
  // --------------------
  @override
  void dispose() {
    _transformationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _resetZoom() async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {

      setNotifier(
          notifier: _transformationController,
          mounted: mounted,
          value: _reset.value,
      );

    });

    _zoomAnimationController.reset();
    await _zoomAnimationController.forward();
  }
  // -----------------------------------------------------------------------------
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
        // panEnabled: true,
        // scaleEnabled: true,
        transformationController: _transformationController,
        constrained: false,
        maxScale: 10,
        minScale: 0.3,
        // scaleFactor: 0.8,
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
