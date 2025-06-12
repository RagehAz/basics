part of super_video_player;
///
class SuperVideoController {
  // --------------------
  VoidCallback? refresh;
  // --------------------
  bool mounted = true;
  // --------------------
  Wire<VideoPlayerValue?>? _videoValue = Wire<VideoPlayerValue?>(null);
  Wire<VideoPlayerValue?>? get videoValue => _videoValue;
  // --------------------
  final Wire<bool> _isChangingVolume = Wire<bool>(false);
  Wire<bool> get isChangingVolume => _isChangingVolume;
  // --------------------
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  // --------------------
  final Wire<double> _volume = Wire<double>(1);
  Wire<double> get volume => _volume;
  // --------------------
  bool _isFile = false;
  bool get isFile => _isFile;
  // --------------------
  bool _isAsset = false;
  bool get isAsset => _isAsset;
  // --------------------
  bool _isVideoURL = false;
  bool get isVideoURL => _isVideoURL;
  // --------------------
  /// TURNED_OFF_YOUTUBE_PLAYER
  /*
  bool _isYoutubeURL = false;
  bool get isYoutubeURL => _isYoutubeURL;
   */
  // --------------------
  File? _videoFile;
  File? get videoFile => _videoFile;
  File? _deleteMeOnDispose;
  // --------------------
  String? _videoURL;
  String? get videoURL => _videoURL;
  // --------------------
  String? _videoAsset;
  String? get videoAsset => _videoAsset;
  // --------------------
  bool _showVolumeSlider = false;
  bool get showVolumeSlider => _showVolumeSlider;
  // --------------------
  double _volumeBeforeMute = 1;
  double get volumeBeforeMute => _volumeBeforeMute;
  // --------------------
  /// TURNED_OFF_YOUTUBE_PLAYER
  /*
  YoutubePlayerController? _youtubeController;
  YoutubePlayerController? get youtubeController => _youtubeController;
   */
  // --------------------
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  // --------------------
  bool _isAutoPlay = false;
  bool get isAutoPlay => _isAutoPlay;
  // --------------------
  bool _isLoading = false;
  // --------------------------------------------------------------------------

  /// INIT

  // --------------------
  ///
  void onInit({
    required VoidCallback onSetState,
  }){

    mounted = true;
    refresh = onSetState;

  }
  // --------------------
  ///
  bool _isInit = true;
  Future<void> onDidChangeDependencies({
    required dynamic object,
    bool autoPlay = true,
    bool loop = false,
    bool showVolumeSlider = false,
    String? fileNameIfObjectIsBytes,
    bool isMuted = false,
  }) async {

    if (_isInit && mounted) {
      _isInit = false; // good

      /// REBUILD
      if (mounted == true){
        _isLoading = true;
        refresh?.call();
      }

      if (object != null){

        /// FILE
        if (object is File){
          await _loadFile(
            file: object,
            autoPlay: autoPlay,
            showVolumeSlider: showVolumeSlider,
            loop: loop,
            isMuted: isMuted,
          );
        }

        /// AV MODEL
        else if (object is AvModel){

          // blog('[superVideoController].starting av');
          final File? _file = await AvOps.cloneFileToHaveExtension(
            avModel: object,
          );
          blog('[superVideoController].got file(${_file?.path})');

          if (_file != null){
            _deleteMeOnDispose = _file;
            await _loadFile(
              file: _file,
              loop: loop,
              showVolumeSlider: showVolumeSlider,
              autoPlay: autoPlay,
              isMuted: isMuted,
            );
            blog('[superVideoController].file loaded');
          }

        }

        /// URL
        else if (ObjectCheck.isAbsoluteURL(object) == true){
          await _loadURL(
            url: object,
            loop: loop,
            showVolumeSlider: showVolumeSlider,
            autoPlay: autoPlay,
            isMuted: isMuted,
          );
        }

        /// ASSET
        else if (object is String){
          await _loadAsset(
            asset: object,
            autoPlay: autoPlay,
            showVolumeSlider: showVolumeSlider,
            loop: loop,
            isMuted: isMuted,
          );
        }

        /// BYTES
        else if (object is Uint8List){

          final File? _file = await Filer.createFromBytes(
            bytes: object,
            fileName: fileNameIfObjectIsBytes ?? '${Idifier.createUniqueIDString()}.mp4',
            includeFileExtension: true, /// breaks on ios if file has no extension
          );

          if (_file != null){
            _deleteMeOnDispose = _file;
            await _loadFile(
              file: _file,
              autoPlay: autoPlay,
              showVolumeSlider: showVolumeSlider,
              loop: loop,
              isMuted: isMuted,
            );
          }

        }

      }

      /// REBUILD
      if (mounted == true){
        _isLoading = false;
        refresh?.call();
      }

    }

  }
  // --------------------
  void onDidUpdateWidget({

    required dynamic oldVideo,
    required dynamic newVideo,

    required bool oldAutoPlay,
    required bool newAutoPlay,

    required bool oldLoop,
    required bool newLoop,

    required bool oldIsMuted,
    required bool newIsMuted,

    required double newCanvasWidth,
    required double oldCanvasWidth,

    required double newCanvasHeight,
    required double oldCanvasHeight,

    required dynamic newCanvasCorners,
    required dynamic oldCanvasCorners,

    required dynamic newCover,
    required dynamic oldCover,

    required String? newErrorIcon,
    required String? oldErrorIcon,

  }){

    asyncInSync(() async {

      if (oldVideo != newVideo) {
        _isInit = true;
        await onDidChangeDependencies(
          object: newVideo,
          autoPlay: newAutoPlay,
          loop: newLoop,
          isMuted: newIsMuted,
        );
      }

      else if (oldIsMuted != newIsMuted){
        await onMutingTap();
      }

      else if (oldLoop != newLoop){
        await setLooping(newLoop);
      }

      else if (oldAutoPlay != newAutoPlay){
        if (newAutoPlay == true){
          await setLooping(true);
          await play();
        }
        else {
          await setLooping(false);
          await pause();
        }
      }

      else if (
          oldCanvasWidth != newCanvasWidth ||
          oldCanvasHeight != newCanvasHeight ||
          oldCanvasCorners != newCanvasCorners ||
          oldCover != newCover ||
          oldErrorIcon != newErrorIcon
      ){
        if (mounted == true){
          refresh!();
        }
      }

    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    if (mounted == true){
    blog('[DISPOSING].VIDEO_CONTROLLER.($_deleteMeOnDispose)');
      mounted = false;
      _videoPlayerController?.removeListener(_listenToVideo);
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _videoValue?.dispose();
      _videoValue = null;
      _isChangingVolume.dispose();
      _volume.dispose();
      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.dispose();
      Filer.deleteFile(_deleteMeOnDispose);
    }
  }
  // --------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadFile({
    required File? file,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }) async {

    if (file != null){

      final VideoPlayerOptions _options = VideoPlayerOptions(
        // mixWithOthers: true,
        // webOptions: VideoPlayerWebOptions(),
        // allowBackgroundPlayback: false,
      );

      // blog('loading file aho ya 3ars $file');
      _videoPlayerController = VideoPlayerController.file(
        file,
        videoPlayerOptions: _options,
        // closedCaptionFile: ,
        // httpHeaders: ,
      );

      _videoPlayerController!.addListener(_listenToVideo);

      await _setupFilePlayer(
        autoPlay: autoPlay,
        loop: loop,
        showVolumeSlider: showVolumeSlider,
        isMuted: isMuted,
      );

      _isFile = true;
      _videoFile = file;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadAsset({
    required String? asset,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }) async {

    if (asset != null){

      final VideoPlayerOptions _options = VideoPlayerOptions(
        // mixWithOthers: true,
        // webOptions: VideoPlayerWebOptions(),
        // allowBackgroundPlayback: false,
      );

      _videoPlayerController = VideoPlayerController.asset(
        asset,
        videoPlayerOptions: _options,
        // closedCaptionFile: ,
        // httpHeaders: ,
      );

      _videoPlayerController!.addListener(_listenToVideo);

      await _setupFilePlayer(
        autoPlay: autoPlay,
        loop: loop,
        showVolumeSlider: showVolumeSlider,
        isMuted: isMuted,
      );

      _isAsset = true;
      _videoAsset = asset;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadURL({
    required String? url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }) async {

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final bool _isYoutubeLink = SuperVideoCheckers.checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        await _loadYoutubeURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
          isMuted: isMuted,
        );
      }

      /// VIDEO URL
      else {
        await _loadVideoURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
          showVolumeSlider: showVolumeSlider,
          isMuted: isMuted,
        );
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadYoutubeURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool isMuted,
  }) async {

    /// TURNED_OFF_YOUTUBE_PLAYER
    // final String? _videoID = extractVideoIDFromYoutubeURL(url);
    //
    // final bool _isValidVideoID = checkIsValidYoutubeVideoID(_videoID);
    //
    // if (_videoID != null && _isValidVideoID == true){
    //
    //   _youtubeController = YoutubePlayerController(
    //     initialVideoId: _videoID,
    //     // flags: const YoutubePlayerFlags(
    //     //   autoPlay: true,
    //     // ),
    //   );
    //
    //   _setupYoutubePlayer(
    //     autoPlay: autoPlay,
    //     isMuted: isMuted,
    //   );
    //
    // }
    //
    // _isYoutubeURL = true;
    // _videoURL = url;
    //
    // /// SHOW VOLUME SLIDER
    // _showVolumeSlider = true;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadVideoURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }) async {

    final VideoPlayerOptions _options = VideoPlayerOptions(
      // mixWithOthers: false,
      // webOptions: VideoPlayerWebOptions(
        // controls: VideoPlayerWebOptionsControls.enabled(
        //   allowDownload: ,
        //   allowFullscreen: ,
        //   allowPictureInPicture: ,
        //   allowPlaybackRate: ,
        // ),
        // allowContextMenu: ,
        // allowRemotePlayback: ,
      // ),
      // allowBackgroundPlayback: false,
    );

    // blog('_loadVideoURL:url($url)');

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
      videoPlayerOptions: _options,
      // closedCaptionFile: ,
      // formatHint: VideoFormat.hls,
      httpHeaders: {
        'Range': 'bytes=0-', // Range request header
      },
    );

    _videoPlayerController!.addListener(_listenToVideo);

    await _setupFilePlayer(
      autoPlay: autoPlay,
      loop: loop,
      showVolumeSlider: showVolumeSlider,
      isMuted: isMuted,
    );

    _isVideoURL = true;
    _videoURL = url;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _setupFilePlayer({
    required bool loop,
    required bool autoPlay,
    required bool showVolumeSlider,
    required bool isMuted,
  }) async {

    if (_videoPlayerController != null){
      await _videoPlayerController!.initialize();
    }

    await setVolume(isMuted ? 0 : 1);

    /// LOOP
    if (loop == true){
      await _videoPlayerController?.setLooping(true);
    }

    /// AUTO PLAY
    if (autoPlay == true){
      await play();
    }
    else {
      await pause();
    }

    /// SHOW VOLUME SLIDER
    _showVolumeSlider = showVolumeSlider;

    /// IS AUTO PLAY
    _isAutoPlay = autoPlay;

  }
  // --------------------
  /// TURNED_OFF_YOUTUBE_PLAYER
  /*
  /// TESTED : WORKS PERFECT
  void _setupYoutubePlayer({
    required bool autoPlay,
    required bool isMuted,
  }){

    /// VOLUME
    _youtubeController?.setVolume(isMuted ? 0 : 100);

    /// AUTO PLAY
    if (autoPlay == true){
      play();
    }
    else {
      pause();
    }

    /// IS AUTO PLAY
    _isAutoPlay = autoPlay;

  }
   */
  // --------------------------------------------------------------------------

  /// LISTENING

  // --------------------
  /// TESTED : WORKS PERFECT
  void _listenToVideo(){

    setNotifier(
      notifier: _videoValue,
      mounted: mounted,
      value: _videoPlayerController?.value,
      /// the configuration below fixes resetting videoValue while its disposed
      // addPostFrameCallBack: false,
      shouldHaveListeners: true,
    );

  }
  // --------------------------------------------------------------------------

  /// PLAYING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onVideoTap() async {

    if (_isPlaying == true){
      await pause();
    }
    else {
      await play();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> play() async {

    if (_isPlaying == false){
      await _videoPlayerController?.play();
      _isPlaying = true;
      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.play();

      /// NO NEED TO RESET LOOPING
      // await _videoPlayerController?.setLooping(true);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> pause() async {

    if (_isPlaying == true){
      await _videoPlayerController?.pause();
      _isPlaying = false;
      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.pause();

      /// NO NEED TO RESET LOOPING
      // await _videoPlayerController?.setLooping(false);
    }

  }
  // --------------------------------------------------------------------------

  /// LOOPING

  // --------------------
  Future<void> setLooping(bool setTo) async {

    if (setTo == true){
      await _videoPlayerController?.setLooping(true);
      await play();
    }

    else {
      await _videoPlayerController?.setLooping(false);
      await pause();
    }

  }
  // --------------------------------------------------------------------------

  /// VOLUME

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> setVolume(double volume) async {

    if (_volume.value != volume){

      await _videoPlayerController?.setVolume(volume);

      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.setVolume((volume * 100).toInt());

      _volume.set(
          mounted: mounted,
          value: volume
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onVolumeChangeStarted(double volume) {

    _isChangingVolume.set(
      mounted: mounted,
      value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onVolumeChangeEnded(double volume) async {

    await Future.delayed(const Duration(seconds: 1), () async {
      _isChangingVolume.set(
        mounted: mounted,
        value: false,
      );
    });

  }
  // --------------------------------------------------------------------------

  /// MUTING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onMutingTap() async {

    final bool _isMuted = checkIsMuted();

    if (_isMuted){
      await unMute();
    }

    else {
      await mute();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> mute() async {
    _volumeBeforeMute = _volume.value;
    await setVolume(0);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> unMute() async {
    await setVolume(_volumeBeforeMute);
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkVideoIsLoading(){

    return _isLoading;

    // if (_videoValue.value == null) {
    //   return true;
    // }
    //
    // else if (Booler.boolIsTrue(_videoValue.value?.hasError) == true){
    //   return false;
    // }
    //
    // else if (checkIsInitialed() == false) {
    //   return true;
    // }
    //
    // else if (Booler.boolIsTrue(_videoValue.value?.isBuffering) == true){
    //   return true;
    // }
    //
    // else {
    //   return false;
    // }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkCanShowPlayIcon(){

    if (_isLoading == true){
      return false;
    }

    else if (_videoValue?.value == null) {
      return false;
    }

    else if (Booler.boolIsTrue(_videoValue?.value?.hasError) == true){
      return false;
    }

    else if (checkIsInitialed() == false) {
      return false;
    }

    else if (Booler.boolIsTrue(_videoValue?.value?.isBuffering) == true){
      return false;
    }
    else if (Booler.boolIsTrue(_videoValue?.value?.isPlaying) == true){
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkCanShowVideo(){

    if (_videoValue?.value == null || _videoPlayerController == null) {
      return false;
    }

    else if (Booler.boolIsTrue(_videoValue?.value?.hasError) == true){
      return false;
    }

    else if (checkIsInitialed() == false) {
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkShowCover(){

    if (_videoValue?.value == null) {
      return true;
    }

    else if (Booler.boolIsTrue(_videoValue?.value?.hasError) == true){
      return true;
    }

    else if (checkIsInitialed() == false) {
      return false;
    }

    else if (Booler.boolIsTrue(_videoValue?.value?.isBuffering) == true){
      return false;
    }
    else if (Booler.boolIsTrue(_videoValue?.value?.isPlaying) == true){
      return false;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkHasError(){
    return _videoValue?.value != null && Booler.boolIsTrue(_videoValue?.value?.hasError) == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsInitialed(){
    return Booler.boolIsTrue(_videoValue?.value?.isInitialized);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsMuted(){
    return _volume.value == 0;
  }
  // --------------------------------------------------------------------------
}
