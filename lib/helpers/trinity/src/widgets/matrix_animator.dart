// ignore_for_file: unused_element
part of trinity;

class MatrixAnimator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MatrixAnimator({
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
    widget.curve != oldWidget.curve ||
    Trinity.checkMatrixesAreIdentical(matrix1: widget.matrix, matrixReloaded: oldWidget.matrix) == false ||
    Trinity.checkMatrixesAreIdentical(matrix1: widget.matrixFrom, matrixReloaded: oldWidget.matrixFrom) == false
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
        begin: widget.matrixFrom ?? Matrix4.identity(),
        end: widget.matrix,
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

    if (widget.matrix == null){
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
