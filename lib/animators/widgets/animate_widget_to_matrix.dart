// ignore_for_file: unused_element
import 'package:flutter/material.dart';

class AnimateWidgetToMatrix extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimateWidgetToMatrix({
    required this.child,
    required this.matrix,
    required this.matrixFrom,
    this.duration = const Duration(seconds: 3),
    // this.origin,
    this.canAnimate = true,
    this.curve = Curves.easeInExpo,
    this.onAnimationEnds,
    this.replayOnRebuild = false,
    this.repeat = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final Matrix4? matrix;
  final Matrix4? matrixFrom;
  final Duration duration;
  // final Offset origin;
  final bool canAnimate;
  final Curve curve;
  final Function? onAnimationEnds;
  final bool replayOnRebuild;
  final bool repeat;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canAnimate == true && matrix != null){
      return _AnimatedChild(
        duration: duration,
        matrix: matrix,
        matrixFrom: matrixFrom,
        curve: curve,
        onAnimationEnds: onAnimationEnds,
        replayOnRebuild: replayOnRebuild,
        repeat: repeat,
        child: child,
      );
    }
    else if (canAnimate == false && matrix != null){
      return Transform(
        transform: matrix!,
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

class _AnimatedChild extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _AnimatedChild({
    required this.child,
    required this.matrix,
    required this.matrixFrom,
    required this.duration,
    required this.curve,
    required this.onAnimationEnds,
    required this.replayOnRebuild,
    required this.repeat,
    // required this.origin,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final Matrix4? matrix;
  final Matrix4? matrixFrom;
  final Duration? duration;
  final Curve? curve;
  final Function? onAnimationEnds;
  final bool replayOnRebuild;
  final bool repeat;
  // final Offset origin;
  /// --------------------------------------------------------------------------
  @override
  __AnimatedChildState createState() => __AnimatedChildState();
  /// --------------------------------------------------------------------------
}

class __AnimatedChildState extends State<_AnimatedChild> with TickerProviderStateMixin {
  // --------------------------------------------------------------------------
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration ?? const Duration(seconds: 3),
      reverseDuration: widget.duration ?? const Duration(seconds: 3),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController.view,
      curve: widget.curve ?? Curves.easeInExpo,
    );

    // blog('initState matrix animator');
    play();

  }
  // --------------------
  @override
  void didUpdateWidget(_AnimatedChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.replayOnRebuild == true){
      // blog('didUpdateWidget in matrix animator');
      play();
    }

  }
  // --------------------
  @override
  void dispose() {
    _animationController.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  Future<void> play() async {

    // blog('should play the damn animation : ${_animationController.value}');

    if (widget.repeat == true){
      await _animationController.repeat(
        // reverse: false,
      );
    }
    else {
      await _animationController.forward(from: 0);
    }

    if (widget.onAnimationEnds != null) {
      widget.onAnimationEnds?.call();
    }



  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.matrix == null){
      return widget.child;
    }

    else {

      return AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (_, Widget? child){

          final Matrix4 matrix = Matrix4Tween(
            begin: widget.matrixFrom ?? Matrix4.identity(),
            end: widget.matrix,
          ).evaluate(_curvedAnimation.parent);

          return Transform(
            transform: matrix,
            child: child,
          );

        },
      );
    }

  }
  // --------------------------------------------------------------------------
}
