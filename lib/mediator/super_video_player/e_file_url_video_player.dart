import 'dart:io';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'c_video_viewer.dart';

class FileAndURLVideoPlayer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FileAndURLVideoPlayer({
    this.file,
    this.asset,
    this.url,
    this.controller,
    this.width,
    this.autoPlay = false,
    this.loop = false,
    this.errorIcon,
    super.key
  });
  // --------------------
  final String? url;
  final String? asset;
  final File? file;
  final VideoPlayerController? controller;
  final double? width;
  final bool autoPlay;
  final bool loop;
  final String? errorIcon;
  /// --------------------------------------------------------------------------
  @override
  _FileAndURLVideoPlayerState createState() => _FileAndURLVideoPlayerState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static VideoPlayerController? initializeVideoController({
    required ValueNotifier<VideoPlayerValue?> videoValue,
    required bool mounted,
    String? url,
    String? asset,
    File? file,
    bool autoPlay = false,
    bool loop = false,
  }) {
    VideoPlayerController? _output;

    final String _link = url ??
        'https://commondatastorage.googleapis'
            '.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

    final VideoPlayerOptions _options = VideoPlayerOptions(
      mixWithOthers: true,
      // allowBackgroundPlayback: false,
    );

    if (url != null) {
      _output = VideoPlayerController.networkUrl(Uri.parse(_link),
          videoPlayerOptions: _options
      );
    }

    if (asset != null) {
      _output = VideoPlayerController.asset(asset,
          videoPlayerOptions: _options
      );
    }

    if (file != null) {
      _output = VideoPlayerController.file(file,
          videoPlayerOptions: _options
      );
    }

    if (_output != null){
      _output..initialize()..setVolume(1);
    }

    if (loop == true){
      _output?.setLooping(true);
    }

    if (autoPlay == true){
      _output?.play();
    }
    else {
      _output?.pause();
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _listenToVideo({
    required ValueNotifier<VideoPlayerValue?> videoValue,
    required VideoPlayerController? videoPlayerController,
    required bool mounted,
  }) {
    setNotifier(
      notifier: videoValue,
      mounted: mounted,
      value: videoPlayerController?.value,
      /// the configuration below fixes resetting videoValue while its disposed
      // addPostFrameCallBack: false,
      shouldHaveListeners: true,
    );
  }
// --------------------------------------------------------------------------
}

class _FileAndURLVideoPlayerState extends State<FileAndURLVideoPlayer> {
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  @override
  void didUpdateWidget(FileAndURLVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // String? url;
    // String? asset;
    // File? file;
    // VideoPlayerController? controller;
    // double? width;
    // bool autoPlay;
    // bool loop;
    // String? errorIcon;

    if (
        oldWidget.url != widget.url ||
        oldWidget.asset != widget.asset ||
        Filers.checkFilesAreIdentical(file1: oldWidget.file, file2: widget.file) == false
    ) {

      _reload();

    }
  }
  // --------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  bool _show = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _reload() {

    asyncInSync(() async {

      setState(() {
        _show = false;
      });

      await Future.delayed(const Duration(milliseconds: 300));

      setState(() {
        _show = true;
      });

  });

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (_show == false){
      return const SizedBox();
    }
    // --------------------
    else {
      return FileAndURLVideoPlayerX(
        controller: widget.controller,
        file: widget.file,
        url: widget.url,
        asset: widget.asset,
        loop: widget.loop,
        autoPlay: widget.autoPlay,
        width: widget.width ?? Scale.screenWidth(context),
        errorIcon: widget.errorIcon,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class FileAndURLVideoPlayerX extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FileAndURLVideoPlayerX({
    this.file,
    this.asset,
    this.url,
    this.controller,
    this.width,
    this.autoPlay = false,
    this.loop = false,
    this.errorIcon,
    super.key
  });
  // --------------------
  final String? url;
  final String? asset;
  final File? file;
  final VideoPlayerController? controller;
  final double? width;
  final bool autoPlay;
  final bool loop;
  final String? errorIcon;
  /// --------------------------------------------------------------------------
  @override
  _FileAndURLVideoPlayerXState createState() => _FileAndURLVideoPlayerXState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static VideoPlayerController? initializeVideoController({
    required ValueNotifier<VideoPlayerValue?> videoValue,
    required bool mounted,
    String? url,
    String? asset,
    File? file,
    bool autoPlay = false,
    bool loop = false,
  }) {
    VideoPlayerController? _output;

    final VideoPlayerOptions _options = VideoPlayerOptions(
      mixWithOthers: true,
      // allowBackgroundPlayback: false,
    );

    if (url != null) {
      _output = VideoPlayerController.networkUrl(Uri.parse(url),
          videoPlayerOptions: _options
      );
    }

    if (asset != null) {
      _output = VideoPlayerController.asset(asset,
          videoPlayerOptions: _options
      );
    }

    if (file != null) {
      _output = VideoPlayerController.file(file,
        videoPlayerOptions: _options,
      );
    }

    if (_output != null){
      _output..initialize()..setVolume(1);
    }

    if (loop == true){
      _output?.setLooping(true);
    }

    if (autoPlay == true){
      _output?.play();
    }
    else {
      _output?.pause();
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _listenToVideo({
    required ValueNotifier<VideoPlayerValue?> videoValue,
    required VideoPlayerController? videoPlayerController,
    required bool mounted,
  }) {
    setNotifier(
      notifier: videoValue,
      mounted: mounted,
      value: videoPlayerController?.value,
      /// the configuration below fixes resetting videoValue while its disposed
      // addPostFrameCallBack: false,
      shouldHaveListeners: true,
    );
  }
  // --------------------------------------------------------------------------
}

class _FileAndURLVideoPlayerXState extends State<FileAndURLVideoPlayerX> {
  // --------------------------------------------------------------------------
  late ValueNotifier<VideoPlayerValue?> _videoValue;
  late ValueNotifier<bool> _isChangingVolume;
  VideoPlayerController? _videoPlayerController;
  // --------------------
  double _volume = 1;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

     _videoValue = ValueNotifier(null);
    _isChangingVolume = ValueNotifier(false);

    _videoPlayerController = widget.controller ?? FileAndURLVideoPlayer.initializeVideoController(
      url: widget.url,
      file: widget.file,
      videoValue: _videoValue,
      mounted: mounted,
      autoPlay: widget.autoPlay,
      asset: widget.asset,
      loop: widget.loop,
      // addListener: true,
    )!;

    /// REMOVED
    _videoPlayerController!.addListener(listen);


  }
  // --------------------
  /*
  @override
  void didUpdateWidget(FileAndURLVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // String? url;
    // String? asset;
    // File? file;
    // VideoPlayerController? controller;
    // double? width;
    // bool autoPlay;
    // bool loop;
    // String? errorIcon;

    if (
        oldWidget.url != widget.url ||
        oldWidget.asset != widget.asset ||
        Filers.checkFilesAreIdentical(file1: oldWidget.file, file2: widget.file) == false
    ) {

      blog('should restart video player');

      _pause();

      _videoValue.value = null;
      _isChangingVolume.value = false;

      _videoPlayerController?.removeListener(listen);
      _videoPlayerController?.dispose();
      _videoPlayerController = null;

      _videoPlayerController = FileAndURLVideoPlayer.initializeVideoController(
        url: widget.url,
        file: widget.file,
        videoValue: _videoValue,
        mounted: mounted,
        autoPlay: widget.autoPlay,
        asset: widget.asset,
        loop: widget.loop,
        // addListener: true,
      )!;

      /// REMOVED
      // _videoPlayerController!.initialize();
      _videoPlayerController!.addListener(listen);

      setState(() {});

    }
  }
   */
  // --------------------
  void listen(){
    FileAndURLVideoPlayer._listenToVideo(
      mounted: mounted,
      videoValue: _videoValue,
      videoPlayerController: _videoPlayerController,
    );
  }
  // --------------------
  @override
  void dispose() {
    _videoPlayerController?.removeListener(listen);
    _videoPlayerController?.dispose();
    _isChangingVolume.dispose();
    _videoValue.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _play() {

    setState(() {
      _videoPlayerController?.play();
      _videoPlayerController?.setLooping(true);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _pause() {

    setState(() {
      _videoPlayerController?.pause();
      _videoPlayerController?.setLooping(false);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _setVolume(double volume) async {

    if (_volume != volume){
      setState(() {
        _videoPlayerController?.setVolume(volume);
        _volume = volume;
      });
    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  Future<void> _increaseVolume() async {

    final bool _canIncrease = _volume < _maxVolume;

    blog('canIncrease : $_canIncrease : _volume : $_volume : _maxVolume : $_maxVolume');

    if (_canIncrease){
      await _setVolume(
        _fixVolume(
          num: _volume + 0.1,
          isIncreasing: true,
        ),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _decreaseVolume() async {

    if (_volume > 0){
      await _setVolume(
        _fixVolume(
          num: _volume - 0.1,
          isIncreasing: false,
        ),
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _fixVolume({
    required double num,
    required bool isIncreasing,
  }){

    /// INCREASING
    if (isIncreasing){
      final double _n = (num * 10).ceilToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

    /// DECREASING
    else {
      final double _n = (num * 10).floorToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

  }
   */
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return VideoViewer(
      onPlay: _play,
      onPause: _pause,
      width: widget.width ?? Scale.screenWidth(context),
      videoPlayerController: _videoPlayerController,
      videoValue: _videoValue,
      onVolumeChanged: _setVolume,
      isChangingVolume: _isChangingVolume,
      errorIcon: widget.errorIcon,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
