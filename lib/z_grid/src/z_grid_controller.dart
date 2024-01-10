part of z_grid;

class ZGridController {
  // -----------------------------------------------------------------------------
  const ZGridController({
    required this.isZoomed,
    required this.scrollController,
    required this.lastOffset,
    required this.transformationController,
    required this.animationController,
    required this.animation,
    required this.shouldDisposeScrollController,
  });
  // --------------------
  final ValueNotifier<bool> isZoomed;
  final ScrollController scrollController;
  final ValueNotifier<double> lastOffset;
  final TransformationController transformationController;
  final AnimationController animationController;
  final CurvedAnimation animation;
  final bool shouldDisposeScrollController;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  static ZGridController initialize({
    required TickerProvider vsync,
    required ScrollController? scrollController,
  }){

     final AnimationController _animationController = AnimationController(
        vsync: vsync,
        duration: zoomingDuration,
      );

     final CurvedAnimation _animation = CurvedAnimation(
        parent: _animationController,
        curve: zoomingCurve,
        reverseCurve: zoomingCurve,
      );

    return ZGridController(
      animation: _animation,
      animationController: _animationController,
      scrollController: scrollController ?? ScrollController(),
      shouldDisposeScrollController: scrollController == null,
      isZoomed: ValueNotifier(false),
      lastOffset: ValueNotifier(0),
      transformationController: TransformationController(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  void dispose(){
    animationController.dispose();
    isZoomed.dispose();
    lastOffset.dispose();
    transformationController.dispose();
    animation.dispose();
    if (shouldDisposeScrollController) {
      scrollController.dispose();
    }
  }

  // -----------------------------------------------------------------------------

  /// ANIMATION DURATIONS - CURVES

  // --------------------
  static const Duration zoomedItemFadeInDuration = Duration(milliseconds: 200);
  static const Curve zoomedItemFadeInCurve = Curves.easeInOutCubic;
  static const Duration zoomingDuration = Duration(milliseconds: 300);
  static const Curve zoomingCurve = Curves.easeOutExpo;

  static const Duration backgroundBlurDelayDuration = Duration(milliseconds: 300);
  // -----------------------------------------------------------------------------

  /// MICRO ZOOMING CONTROLLERS

  // --------------------
  static Future<void> scrollToRow({
    required BuildContext context,
    required int itemIndex,
    required double gridWidth,
    required double gridHeight,
    required int columnCount,
    required double itemAspectRatio,
    required bool mounted,
    required ZGridController zGridController,
    required bool hasResponsiveSideMargin,
  }) async {

    final double _newOffset = ZGridScale._getRowOffset(
      context: context,
      rowIndex: itemIndex ~/ columnCount,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    setNotifier(
        notifier: zGridController.lastOffset,
        mounted: mounted,
        value: zGridController.scrollController.offset,
    );

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: _newOffset,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

  }
  // -----------------------------------------------------------------------------
  static Future<void> _zoomToMatrix({
    required Matrix4 matrix,
    required ZGridController zGridController,
  }) async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: zGridController.transformationController.value,
      end: matrix,
    ).animate(zGridController.animation);

    void _listener(){
      zGridController.transformationController.value = _reset.value;
    }

    /// REMOVED
    zGridController.animation.addListener(_listener);

    zGridController.animationController.reset();

    await zGridController.animationController.forward();

    zGridController.animation.removeListener(_listener);
  }
  // -----------------------------------------------------------------------------

  /// ZOOMING

  // --------------------
  static Future<void> zoomIn({
    required BuildContext context,
    required int itemIndex,
    required bool mounted,
    required Function? onZoomInStart,
    required Function? onZoomInEnd,
    required ZGridController zGridController,
    required ZGridScale gridScale,
    required bool appIsLTR,
    required Function closeKeyboardFunction,
  }) async {

    await closeKeyboardFunction.call();

    // blog('zoomIn : itemIndex ~/ rowsCount = ${itemIndex ~/ _columnsCount}');

    if (onZoomInStart != null){
      await onZoomInStart();
    }

    unawaited(scrollToRow(
      context: context,
      itemIndex: itemIndex,
      columnCount: gridScale.columnCount,
      gridWidth: gridScale.gridWidth,
      gridHeight: gridScale.gridHeight,
      itemAspectRatio: gridScale.itemAspectRatio,
      zGridController: zGridController,
      mounted: mounted,
      hasResponsiveSideMargin: gridScale.hasResponsiveSideMargin,
    ));

    /// APP IS LEFT TO RIGHT INDEX
    final int _ltrIndex = itemIndex % gridScale.columnCount;
    /// APP IS RIGHT TO LEFT INDEX
    final int _reverseIndex = gridScale.columnCount - (itemIndex % gridScale.columnCount) - 1;

    await _zoomToMatrix(
      zGridController: zGridController,
      matrix: ZGridScale._getZoomMatrix(
        context: context,
        rowIndex: 0,
        columnIndex: appIsLTR ? _ltrIndex : _reverseIndex,
        columnCount: gridScale.columnCount,
        gridWidth: gridScale.gridWidth,
        gridHeight: gridScale.gridHeight,
        itemAspectRatio: gridScale.itemAspectRatio,
        topPaddingOnZoomOut: gridScale.topPaddingOnZoomOut,
        hasResponsiveSideMargin: gridScale.hasResponsiveSideMargin,
      ),
    );

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: true,
    );

    if (onZoomInEnd != null){
      await onZoomInEnd();
    }

  }
  // --------------------
  static Future<void> zoomOut({
    required bool mounted,
    required  Function? onZoomOutStart,
    required  Function? onZoomOutEnd,
    required ZGridController zGridController,
  }) async {

    if (onZoomOutStart != null){
      await onZoomOutStart();
    }

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: false,
    );

    unawaited(_zoomToMatrix(
      zGridController: zGridController,
      matrix: Matrix4.identity(),
    ));

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: zGridController.lastOffset.value,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

    if (onZoomOutEnd != null){
      await onZoomOutEnd();
    }

  }
  // --------------------
  static Future<void> onDismissBigItem({
    required Function? onZoomOutStart,
    required Function? onZoomOutEnd,
    required bool mounted,
    required ZGridController zGridController,
  }) async {

    if (onZoomOutStart != null){
      await onZoomOutStart();
    }

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: false,
    );

    unawaited(_zoomToMatrix(
      matrix: Matrix4.identity(),
      zGridController: zGridController,
    ));

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: zGridController.lastOffset.value,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

    if (onZoomOutEnd != null){
      await onZoomOutEnd();
    }


  }
  // -----------------------------------------------------------------------------
}
