import 'dart:async';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/trinity.dart';
import 'package:flutter/material.dart';

class Zoomer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Zoomer({
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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canZoom == true){
      return _ZoomableChild(
        key: const ValueKey<String>('TheZoomerChild'),
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
    // --------------------
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
  Matrix4 _initialMatrix = Matrix4.identity();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _transformationController = widget.transformationController ?? TransformationController();

    if (widget.offset != null){

      _initialMatrix = Trinity.move(
        matrix: Matrix4.identity(),
        x: widget.offset!.dx,
        y: widget.offset!.dy,
      );

      _transformationController.value = _initialMatrix;

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
  Future<void> _animateToMatrix(Matrix4 matrixTo) async {

    await Zoomer.animateToMatrix(
      matrixTo: matrixTo,
      mounted: mounted,
      transformationController: _transformationController,
      zoomAnimationController: _zoomAnimationController,
    );

  }
  // --------------------
  Future<void> _resetZoom() async {
    await _animateToMatrix(_initialMatrix);
  }
  // --------------------
  Future<void> _onDoubleTap() async {

    Matrix4 _matrix = _transformationController.value;

    _matrix = Trinity.scale(
      matrix: _matrix,
      x: Trinity.getXScale(_matrix)! * 1.1,
      y: Trinity.getYScale(_matrix)! * 1.1,
    );

    await _animateToMatrix(_matrix);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('is Constrained aho');

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
      onDoubleTap: _onDoubleTap,
      onLongPress: _resetZoom,
      child: InteractiveViewer(
        // key: widget.key,
        // panEnabled: false,
        // scaleEnabled: true,
        transformationController: _transformationController,
        // constrained: true,
        maxScale: widget.maxZoom,
        minScale: widget.minZoom,
        boundaryMargin: const EdgeInsets.all(double.infinity),
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

        child: Center(
          child: widget.child ?? const SizedBox(),
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
