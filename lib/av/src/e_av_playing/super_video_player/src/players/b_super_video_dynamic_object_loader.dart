part of super_video_player;

class _SuperVideoDynamicLoader extends StatefulWidget {
  // --------------------------------------------------------------------------
  const _SuperVideoDynamicLoader({
    required this.canvasWidth,
    required this.canvasHeight,
    required this.cover,
    this.video,
    this.corners,
    this.errorIcon,
    this.isMuted = false,
    this.autoPlay = true,
    this.loop = false,
  });
  // --------------------
  final double canvasWidth;
  final double canvasHeight;
  final dynamic corners;
  final String? errorIcon;
  final dynamic video;
  final bool isMuted;
  final bool autoPlay;
  final bool loop;
  final dynamic cover;
  // --------------------
  @override
  _SuperVideoDynamicLoaderState createState() => _SuperVideoDynamicLoaderState();
  // --------------------------------------------------------------------------
}

class _SuperVideoDynamicLoaderState extends State<_SuperVideoDynamicLoader> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  final SuperVideoController _controller = SuperVideoController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _controller.onInit(
      onSetState: () => setState((){}),
    );

  }
  // --------------------
  /// pauses playback the moment the app is backgrounded -- otherwise a
  /// playing flyer video (and its audio) keeps running behind the lock
  /// screen/home screen, since video_player has no such awareness on its
  /// own. Deliberately doesn't auto-resume on `resumed`: matches the
  /// existing play/pause model where resuming is always an explicit user
  /// tap (`onVideoTap`), never automatic.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden
    ) {
      unawaited(_controller.pause());
    }

    super.didChangeAppLifecycleState(state);
  }
  // --------------------
  @override
  void didChangeDependencies() {

    _controller.onDidChangeDependencies(
      object: widget.video,
      autoPlay: widget.autoPlay,
      loop: widget.loop,
      isMuted: widget.isMuted,
    );

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(_SuperVideoDynamicLoader oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.onDidUpdateWidget(

      oldVideo: oldWidget.video,
      newVideo: widget.video,

      oldAutoPlay: oldWidget.autoPlay,
      newAutoPlay: widget.autoPlay,

      oldLoop: oldWidget.loop,
      newLoop: widget.loop,

      oldIsMuted: oldWidget.isMuted,
      newIsMuted: widget.isMuted,

      oldCanvasWidth: oldWidget.canvasWidth,
      newCanvasWidth: widget.canvasWidth,

      oldCanvasHeight: oldWidget.canvasHeight,
      newCanvasHeight: widget.canvasHeight,

      oldCanvasCorners: oldWidget.corners,
      newCanvasCorners: widget.corners,

      oldCover: oldWidget.cover,
      newCover: widget.cover,

      oldErrorIcon: oldWidget.errorIcon,
      newErrorIcon: widget.errorIcon,

    );

  }
  // --------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return _SuperVideoControllerPlayer(
      canvasHeight: widget.canvasHeight,
      canvasWidth: widget.canvasWidth,
      superVideoController: _controller,
      corners: widget.corners,
      errorIcon: widget.errorIcon,
      cover: widget.cover,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
