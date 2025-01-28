// ignore_for_file: unused_element
part of trinity;

class NeoPlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const NeoPlayer({
    required this.child,
    this.viewMatrixTo,
    this.viewMatrixFrom,
    this.normalMatrixTo,
    this.normalMatrixFrom,
    this.viewWidth,
    this.viewHeight,
    this.duration = const Duration(seconds: 3),
    // this.origin,
    this.canAnimate = true,
    this.curve = Curves.easeInExpo,
    this.onAnimationEnds,
    this.replayOnRebuild = false,
    this.repeat = true,
    super.key
  });
  // --------------------
  final Widget child;
  final Matrix4? viewMatrixTo;
  final Matrix4? viewMatrixFrom;
  final Matrix4? normalMatrixTo;
  final Matrix4? normalMatrixFrom;
  final double? viewWidth;
  final double? viewHeight;
  final Duration duration;
  // final Offset origin;
  final bool canAnimate;
  final Curve curve;
  final Function? onAnimationEnds;
  final bool replayOnRebuild;
  final bool repeat;
  // --------------------------------------------------------------------------
  Matrix4? getViewMatrixTo(){

    if (viewMatrixTo != null){
      return viewMatrixTo;
    }
    else if (normalMatrixTo != null){
      return NeoRender.toView(normalMatrix: normalMatrixTo, viewWidth: viewWidth, viewHeight: viewHeight);
    }
    else {
      return null;
    }

  }
  // --------------------
  Matrix4? getViewMatrixFrom(){

    if (viewMatrixFrom != null){
      return viewMatrixFrom;
    }
    else if (normalMatrixFrom != null){
      return NeoRender.toView(normalMatrix: normalMatrixFrom, viewWidth: viewWidth, viewHeight: viewHeight);
    }
    else {
      return null;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Matrix4? _viewMatrixTo = getViewMatrixTo();
    final Matrix4? _viewMatrixFrom = getViewMatrixFrom();

    // --------------------
    if (canAnimate == true && _viewMatrixTo != null){
      return _AnimatedChild(
        duration: duration,
        viewMatrixTo: _viewMatrixTo,
        viewMatrixFrom: getViewMatrixFrom(),
        curve: curve,
        onAnimationEnds: onAnimationEnds,
        replayOnRebuild: replayOnRebuild,
        repeat: repeat,
        child: child,
      );
    }
    // --------------------
    else if (canAnimate == false && (_viewMatrixTo != null || _viewMatrixFrom != null)){
      return Transform(
        transform: _viewMatrixTo ?? _viewMatrixFrom ?? Matrix4.identity(),
        child: child,
        // child: Container(),
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

class _AnimatedChild extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _AnimatedChild({
    required this.child,
    required this.viewMatrixTo,
    required this.viewMatrixFrom,
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
  final Matrix4? viewMatrixTo;
  final Matrix4? viewMatrixFrom;
  final Duration? duration;
  final Curve? curve;
  final Function? onAnimationEnds;
  final bool replayOnRebuild;
  final bool repeat;
  // final Offset origin;
  // --------------------------------------------------------------------------
  @override
  __AnimatedChildState createState() => __AnimatedChildState();
  // --------------------------------------------------------------------------
}

class __AnimatedChildState extends State<_AnimatedChild> with TickerProviderStateMixin {
  // --------------------------------------------------------------------------
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<Matrix4?> _matrixAnimation;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initialize();

    play();

  }
  // --------------------
  @override
  void didUpdateWidget(_AnimatedChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (
    widget.duration != oldWidget.duration
    ){
      if (mounted == true){
        _setController();
      }
    }

    if (
    widget.curve != oldWidget.curve
        ||
    NeoCypher.checkMatrixesAreIdentical(matrix1: widget.viewMatrixTo, matrixReloaded: oldWidget.viewMatrixTo) == false
        ||
    NeoCypher.checkMatrixesAreIdentical(matrix1: widget.viewMatrixFrom, matrixReloaded: oldWidget.viewMatrixFrom) == false
    ){
      if (mounted == true){
        _setCurvedAnimation();
        _setMatrixAnimation();
      }
    }

    if (widget.replayOnRebuild == true || widget.repeat == true){
      if (mounted == true){
        play();
      }
    }

  }
  // --------------------
  @override
  void dispose() {
    _controller.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  void _initialize(){

    _setController();

    _setCurvedAnimation();

    _setMatrixAnimation();

  }
  // --------------------
  void _setController(){
    if (mounted == true){
      _controller = AnimationController(
        duration: widget.duration ?? const Duration(seconds: 3),
        reverseDuration: widget.duration ?? const Duration(seconds: 3),
        // value: 0.95,
        // lowerBound: 0.0,
        // upperBound: 1.0,
        vsync: this,
      );

    }
  }
  // --------------------
  void _setCurvedAnimation(){
    if (mounted == true){
      _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? Curves.easeInOut,
        reverseCurve: widget.curve ?? Curves.easeInOut,
      );
    }
  }
  // --------------------
  void _setMatrixAnimation(){
    if (mounted == true){
      _matrixAnimation = Matrix4Tween(
        begin: widget.viewMatrixFrom ?? Matrix4.identity(),
        end: widget.viewMatrixTo,
      ).animate(_curvedAnimation);
    }
  }
  // --------------------------------------------------------------------------
  Future<void> play() async {

    if (mounted == true){

      if (widget.repeat == true){
        await _controller.repeat(
          // reverse: false,
        );
      }
      else {
        await _controller.forward(from: 0);
      }
  
      if (widget.onAnimationEnds != null) {
        if (mounted == true){
          widget.onAnimationEnds?.call();
        }
      }

    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.viewMatrixTo == null){
      return widget.child;
    }

    else {

      return AnimatedBuilder(
        animation: _matrixAnimation,
        child: widget.child,
        builder: (_, Widget? child){

          return Transform(
            transform: _matrixAnimation.value ?? Matrix4.identity(),
            child: child,
          );

        },
      );
    }

  }
  // --------------------------------------------------------------------------
}
