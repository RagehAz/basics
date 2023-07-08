// ignore_for_file: unused_element

import 'package:flutter/material.dart';

enum FadeType{
  fadeIn,
  fadeOut,
  repeatAndReverse,
  repeatForwards,
  stillAtMin,
  stillAtMax,
}

class WidgetFader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WidgetFader({
    required this.fadeType,
    this.child,
    this.max = 1,
    this.min = 0,
    this.duration,
    this.curve = Curves.easeInOut,
    this.ignorePointer = false,
    this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget? child;
  final FadeType fadeType;
  final double max;
  final double min;
  final Duration? duration;
  final Curve curve;
  final bool ignorePointer;
  final Widget Function(double value, Widget? child)? builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (fadeType == FadeType.stillAtMin || fadeType == FadeType.stillAtMax) {
      return _StillFade(
        fadeType: fadeType,
        builder: builder,
        max: max,
        min: min,
        ignorePointer: ignorePointer,
        child: child,
      );
    }

    else {
      return _AnimatedFade(
        fadeType: fadeType,
        builder: builder,
        max: max,
        min: min,
        duration: duration,
        curve: curve,
        ignorePointer: ignorePointer,
        child: child,
      );
    }
  }
/// --------------------------------------------------------------------------
}

class _AnimatedFade extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _AnimatedFade({
    required this.fadeType,
    required this.child,
    required this.max,
    required this.min,
    required this.duration,
    required this.curve,
    required this.ignorePointer,
    required this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget? child;
  final FadeType fadeType;
  final double max;
  final double min;
  final Duration? duration;
  final Curve curve;
  final bool ignorePointer;
  final Widget Function(double value, Widget? child)? builder;
  /// --------------------------------------------------------------------------
  @override
  _AnimatedFadeState createState() => _AnimatedFadeState();
  /// --------------------------------------------------------------------------
}

class _AnimatedFadeState extends State<_AnimatedFade> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  AnimationController? _animationController;
  // Animation<double> _opacityTween;
  CurvedAnimation? _animation;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final Duration _duration = widget.duration ?? const Duration(seconds: 2);

    _animationController = AnimationController(
        reverseDuration: _duration,
        duration: _duration,
        lowerBound: widget.min,
        upperBound: widget.max,
        vsync: this
    );

    _animation = CurvedAnimation(
      parent: _animationController!.view,
      curve: widget.curve,
      reverseCurve: widget.curve,
    );

    _animate();

  }
  // --------------------
  @override
  void dispose() {
    _animationController?.dispose();
    _animation?.dispose();
    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant _AnimatedFade oldWidget) {
    if (
    oldWidget.fadeType  != widget.fadeType  ||
        oldWidget.duration  != widget.duration  ||
        oldWidget.curve     != widget.curve     ||
        oldWidget.max       != widget.max       ||
        oldWidget.min       != widget.min
    ){
      setState(() {
        _animate();
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  Future<void> _animate() async {

    if (widget.fadeType == FadeType.fadeIn){
      await _animationController?.forward(
        from: widget.min,
      );
    }
    else if (widget.fadeType == FadeType.fadeOut){
      await _animationController?.reverse(from: widget.max);
    }
    else if (widget.fadeType == FadeType.repeatAndReverse){
      await _animationController?.repeat(
        min: widget.min,
        max: widget.max,
        reverse: true,
        period: widget.duration,
      );
    }
    else if (widget.fadeType == FadeType.repeatForwards){
      await _animationController?.repeat(
        min: widget.min,
        max: widget.max,
        // reverse: false,
        period: widget.duration,
      );
    }
    else if (widget.fadeType == FadeType.stillAtMin){
      _animationController?.value  = widget.min;
    }
    else if (widget.fadeType == FadeType.stillAtMax){
      _animationController?.value  = widget.max;
    }
    else {
      await _animationController?.forward(from: widget.min,);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
        ignoring: widget.ignorePointer,
        child:

        widget.builder == null ?

        FadeTransition(
          opacity: _animation!.parent,
          child: widget.child,
        )

            :

        AnimatedBuilder(
            animation: _animation!.parent,
            child: widget.child,
            builder: (_, Widget? child){

              if (widget.builder == null) {
                return child ?? const SizedBox();
              }

              else {
                final double _value = _animation!.value;
                return widget.builder!(_value, child);
              }

            }
        )

    );

  }
// -----------------------------------------------------------------------------
}

class _StillFade extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _StillFade({
    required this.fadeType,
    required this.builder,
    required this.child,
    required this.max,
    required this.min,
    required this.ignorePointer,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget? child;
  final FadeType fadeType;
  final double max;
  final double min;
  final bool ignorePointer;
  final Widget Function(double value, Widget? child)? builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _opacity = fadeType == FadeType.stillAtMin ? min : max;

    final Widget? _child = builder == null ? child : builder!(_opacity, child);

    return IgnorePointer(
      ignoring: ignorePointer,
      child: Opacity(
        opacity: _opacity,
        child: _child,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
