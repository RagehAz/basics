part of super_video_player;

class _SuperVideoDynamicObjectLoader extends StatefulWidget {
  // --------------------------------------------------------------------------
  const _SuperVideoDynamicObjectLoader({
    required this.width,
    this.media,
    this.corners,
    this.errorIcon,
    this.isMuted = false,
    this.autoPlay = true,
    this.loop = false,
  });
  // --------------------
  final double width;
  final dynamic corners;
  final String? errorIcon;
  final dynamic media;
  final bool isMuted;
  final bool autoPlay;
  final bool loop;
  // --------------------
  @override
  _SuperVideoDynamicObjectLoaderState createState() => _SuperVideoDynamicObjectLoaderState();
// --------------------------------------------------------------------------
}

class _SuperVideoDynamicObjectLoaderState extends State<_SuperVideoDynamicObjectLoader> {
  // -----------------------------------------------------------------------------
  SuperVideoController? _controller;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _loadController();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(_SuperVideoDynamicObjectLoader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.media != widget.media) {
      _loadController();
    }

    else if (oldWidget.isMuted != widget.isMuted){
      _controller?.onMutingTap();
    }

    else if (oldWidget.loop != widget.loop){
      _controller?.setLooping(widget.loop);
    }

    else if (oldWidget.autoPlay != widget.autoPlay){
      if (widget.autoPlay == true){
        _controller?.play();
      }
      else {
        _controller?.pause();
      }
    }

    else if (
        oldWidget.width != widget.width ||
        oldWidget.corners != widget.corners ||
        oldWidget.errorIcon != widget.errorIcon
    ){
      setState(() {});
    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _controller?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD CONTROLLER

  // --------------------
  Future<void> _loadController() async {

    await _triggerLoading(setTo: true);

    _controller = SuperVideoController();

    await _controller!.superLoadMedia(
      object: widget.media,
      autoPlay: widget.autoPlay,
      loop: widget.loop,
      isMuted: widget.isMuted,
    );

    setState(() {});

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NULL
    if (_controller == null){
      return const SizedBox();
    }
    // --------------------
    /// PLAYER
    else {
      return _SuperVideoControllerPlayer(
        width: widget.width,
        superVideoController: _controller,
        corners: widget.corners,
        errorIcon: widget.errorIcon,
      );
    }
    // --------------------
  }
// -----------------------------------------------------------------------------
}
