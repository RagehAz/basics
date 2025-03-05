part of zoomer;

class Zoomer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const Zoomer({
    required this.child,
    this.onTap,
    this.autoShrink = true,
    this.canZoom = true,
    this.transformationController,
    this.minZoom = 0.3,
    this.maxZoom = 3,
    this.boundaryMargin = EdgeInsets.zero,
    super.key
  });
  // --------------------
  final Widget child;
  final bool autoShrink;
  final Function? onTap;
  final TransformationController? transformationController;
  final bool canZoom;
  final double minZoom;
  final double maxZoom;
  final EdgeInsets boundaryMargin;
  // --------------------
  static Future<void> animateToMatrix({
    required Matrix4 matrixTo,
    required TransformationController transformationController,
    required AnimationController zoomAnimationController,
    required bool mounted,
  }) async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: transformationController.value,
      end: matrixTo,
    ).animate(zoomAnimationController);

    void _listener() {

      setNotifier(
        notifier: transformationController,
        mounted: mounted,
        value: _reset.value,
      );

    }

    /// REMOVED
    zoomAnimationController.addListener(_listener);

    zoomAnimationController.reset();

    await zoomAnimationController.forward();

    zoomAnimationController.removeListener(_listener);

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canZoom == true){
      return _ZoomableChild(
        key: const ValueKey<String>('_TheNewZoomableChild'),
        // onTap: onTap,
        autoShrink: autoShrink,
        transformationController: transformationController,
        minZoom: minZoom,
        maxZoom: maxZoom,
        child: child,
      );
    }
    // --------------------
    else {
      return child;
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
