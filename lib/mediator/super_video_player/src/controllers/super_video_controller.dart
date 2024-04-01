part of super_video_player;

class SuperVideoController {
  // --------------------------------------------------------------------------

  SuperVideoController();

  // --------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  void loadFile({
    required File? file,
    bool autoPlay = false,
    bool loop = false,
    bool showVolumeSlider = false,
  }){

    if (file != null){

      final VideoPlayerOptions _options = VideoPlayerOptions(
        mixWithOthers: true,
        // webOptions: VideoPlayerWebOptions(),
        // allowBackgroundPlayback: false,
      );

      _videoPlayerController = VideoPlayerController.file(
        file,
        videoPlayerOptions: _options,
        // closedCaptionFile: ,
        // httpHeaders: ,
      );

      _videoPlayerController!.addListener(_listenToVideo);

      _setupPlayer(
        autoPlay: autoPlay,
        loop: loop,
        showVolumeSlider: showVolumeSlider,
      );

      _isFile = true;
      _videoFile = file;

    }

  }
  // --------------------
  ///
  void loadAsset({
    required String? asset,
    bool autoPlay = false,
    bool loop = false,
    bool showVolumeSlider = false,
  }){

    if (asset != null){

      final VideoPlayerOptions _options = VideoPlayerOptions(
        mixWithOthers: true,
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

      _setupPlayer(
        autoPlay: autoPlay,
        loop: loop,
        showVolumeSlider: showVolumeSlider,
      );

      _isAsset = true;
      _videoAsset = asset;

    }

  }
  // --------------------
  ///
  void loadURL({
    required String? url,
    bool autoPlay = false,
    bool loop = false,
    bool showVolumeSlider = false,
  }){

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final bool _isYoutubeLink = YoutubeVideoPlayer.checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        _loadYoutubeURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
          showVolumeSlider: showVolumeSlider,
        );
      }

      /// VIDEO URL
      else {
        _loadVideoURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
          showVolumeSlider: showVolumeSlider,
        );
      }

    }

  }
  // --------------------
  ///
  void _loadYoutubeURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
  }){


    _isYoutubeURL = true;
    _videoURL = url;

    /// SHOW VOLUME SLIDER
    _showVolumeSlider = showVolumeSlider;

  }
  // --------------------
  ///
  void _loadVideoURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
  }){

    final VideoPlayerOptions _options = VideoPlayerOptions(
      mixWithOthers: true,
      // webOptions: VideoPlayerWebOptions(),
      // allowBackgroundPlayback: false,
    );

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
      videoPlayerOptions: _options,
      // closedCaptionFile: ,
      // httpHeaders: ,
    );

    _videoPlayerController!.addListener(_listenToVideo);

    _setupPlayer(
      autoPlay: autoPlay,
      loop: loop,
      showVolumeSlider: showVolumeSlider,
    );

    _isVideoURL = true;
    _videoURL = url;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setupPlayer({
    required bool loop,
    required bool autoPlay,
    required bool showVolumeSlider,
  }){

    if (_videoPlayerController != null){
      _videoPlayerController!..initialize()..setVolume(1);
    }

    /// LOOP
    if (loop == true){
      _videoPlayerController?.setLooping(true);
    }

    /// AUTO PLAY
    if (autoPlay == true){
      _videoPlayerController?.play();
    }
    else {
      _videoPlayerController?.pause();
    }

    /// SHOW VOLUME SLIDER
    _showVolumeSlider = showVolumeSlider;

  }
  // --------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    _videoPlayerController?.removeListener(_listenToVideo);
    _videoValue.dispose();
    _isChangingVolume.dispose();
    _videoPlayerController?.dispose();
    _volume.dispose();
  }
  // --------------------------------------------------------------------------

  /// VARIABLES

  // --------------------
  final ValueNotifier<VideoPlayerValue?> _videoValue = ValueNotifier(null);
  ValueNotifier<VideoPlayerValue?> get videoValue => _videoValue;
  // --------------------
  final ValueNotifier<bool> _isChangingVolume = ValueNotifier(false);
  ValueNotifier<bool> get isChangingVolume => _isChangingVolume;
  // --------------------
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  // --------------------
  final ValueNotifier<double> _volume = ValueNotifier(1);
  ValueNotifier<double> get volume => _volume;
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
  bool _isYoutubeURL = false;
  bool get isYoutubeURL => _isYoutubeURL;
  // --------------------
  File? _videoFile;
  File? get videoFile => _videoFile;
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
  // --------------------------------------------------------------------------

  /// LISTENING

  // --------------------
  /// TESTED : WORKS PERFECT
  void _listenToVideo(){

    setNotifier(
      notifier: _videoValue,
      mounted: true,
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
  void play(){
    _videoPlayerController?.play();
    _videoPlayerController?.setLooping(true);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void pause(){
    _videoPlayerController?.pause();
    _videoPlayerController?.setLooping(false);
  }
  // --------------------------------------------------------------------------

  /// VOLUME

  // --------------------
  /// TESTED : WORKS PERFECT
  void setVolume(double volume){

    if (_volume.value != volume){

      _videoPlayerController?.setVolume(volume);

      setNotifier(
          notifier: _volume,
          mounted: true,
          value: volume
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onVolumeChangeStarted(double volume) {

    setNotifier(
      notifier: _isChangingVolume,
      mounted: true,
      value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onVolumeChangeEnded(double volume) async {

    await Future.delayed(const Duration(seconds: 1), () async {
      setNotifier(
        notifier: _isChangingVolume,
        mounted: true,
        value: false,
      );
    });

  }
  // --------------------------------------------------------------------------

  /// MUTING

  // --------------------
  ///
  void mute(){
    _volumeBeforeMute = _volume.value;
    setVolume(0);
  }
  // --------------------
  ///
  void unMute(){
    setVolume(_volumeBeforeMute);
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkVideoIsLoading(){

    if (_videoValue.value == null) {
      return true;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.hasError) == true){
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isInitialized) == false) {
      return true;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isBuffering) == true){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkCanShowPlayIcon(){

    if (_videoValue.value == null) {
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.hasError) == true){
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isInitialized) == false) {
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isBuffering) == true){
      return false;
    }
    else if (Mapper.boolIsTrue(_videoValue.value?.isPlaying) == true){
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkCanShowVideo(){

    if (_videoValue.value == null || _videoPlayerController == null) {
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.hasError) == true){
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isInitialized) == false) {
      return false;
    }
    else {
      return true;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkHasError(){
    return _videoValue.value != null && _videoValue.value!.hasError == true;
  }
  // --------------------
  ///
  bool checkIsMuted(){
    return _volume.value == 0;
  }
  // --------------------------------------------------------------------------
}
