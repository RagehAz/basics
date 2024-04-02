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

      _setupFilePlayer(
        autoPlay: autoPlay,
        loop: loop,
        showVolumeSlider: showVolumeSlider,
      );

      _isFile = true;
      _videoFile = file;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

      _setupFilePlayer(
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

      final bool _isYoutubeLink = checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        _loadYoutubeURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
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
  }){

    final String? _videoID = extractVideoIDFromYoutubeURL(url);

    final bool _isValidVideoID = checkIsValidYoutubeVideoID(_videoID);

    if (_videoID != null && _isValidVideoID == true){

      _youtubeController = YoutubePlayerController(
        initialVideoId: _videoID,
        // flags: const YoutubePlayerFlags(
        //   autoPlay: true,
        // ),
      );

      _setupYoutubePlayer(
        autoPlay: autoPlay,
      );

    }

    _isYoutubeURL = true;
    _videoURL = url;

    /// SHOW VOLUME SLIDER
    _showVolumeSlider = true;

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

    _setupFilePlayer(
      autoPlay: autoPlay,
      loop: loop,
      showVolumeSlider: showVolumeSlider,
    );

    _isVideoURL = true;
    _videoURL = url;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setupFilePlayer({
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
      play();
    }
    else {
      pause();
    }

    /// SHOW VOLUME SLIDER
    _showVolumeSlider = showVolumeSlider;

    /// IS AUTO PLAY
    _isAutoPlay = autoPlay;

  }

  // --------------------
  /// TESTED : WORKS PERFECT
  void _setupYoutubePlayer({
    required bool autoPlay,
  }){

    /// VOLUME
    _youtubeController?.setVolume(100);

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
    _youtubeController?.dispose();
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
  // --------------------
  YoutubePlayerController? _youtubeController;
  YoutubePlayerController? get youtubeController => _youtubeController;
  // --------------------
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  // --------------------
  bool _isAutoPlay = false;
  bool get isAutoPlay => _isAutoPlay;
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
  void onVideoTap(){

    if (Mapper.boolIsTrue(_videoValue.value?.isPlaying) == true){
      pause();
    }
    else {
      play();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void play(){

    if (_isPlaying = false){
      _isPlaying = true;
      _videoPlayerController?.play();
      _youtubeController?.play();
    }

    // _videoPlayerController?.setLooping(true);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void pause(){

    if (_isPlaying = true){
      _videoPlayerController?.pause();
      _youtubeController?.pause();
    }

    // _videoPlayerController?.setLooping(false);
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
  // -----------------------------------------------------------------------------

  /// YOUTUBE CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeVideoID(String? videoID) {
    if (videoID == null){
      return false;
    }
    else {
      final youtubeVideoIdPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
      return youtubeVideoIdPattern.hasMatch(videoID) && videoID.length <= 11;
    }
  }
  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeLink(String? link) {

    if (TextCheck.isEmpty(link) == true){
      return false;
    }

    else {
      final youtubeLinkPattern = RegExp(
          r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');
      return youtubeLinkPattern.hasMatch(link!);
    }

  }
  // -----------------------------------------------------------------------------

  /// YOUTUBE VIDEO ID

  // --------------------
  /// AI TESTED
  static String? extractVideoIDFromYoutubeURL(String? youtubeURL) {
    String? _output;

    if (checkIsValidYoutubeLink(youtubeURL) == true) {

      final youtubeLinkPattern = RegExp(
          r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');

      final match = youtubeLinkPattern.firstMatch(youtubeURL!);

      if (match != null){
        _output = match.group(3);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// YOUTUBE COVER IMAGE

  // --------------------
  /// TASK : TEST ME
  String? getYouTubeVideoCoverImageURL(){
    String? _output;

    final bool _isYoutubeLink = checkIsValidYoutubeLink(_videoURL);

    if (_youtubeController != null && _isYoutubeLink == true){

      // final String link = 'https://www.youtube.com/watch?v=$videoID';
      // final meta.MetaDataModel metaData = await meta.YoutubeMetaData.getData(link);

      final YoutubeMetaData? videoMetaData = _youtubeController?.metadata;
      final String? id = videoMetaData?.videoId;

      if (id != null){
        _output = 'https://img.youtube.com/vi/$id/0.jpg';
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// SUPER LOADER

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> superLoadMedia({
    required dynamic object,
    bool autoPlay = true,
    bool loop = false,
    bool showVolumeSlider = false,
    String? fileNameIfObjectIsBytes,
  }) async {

    if (object != null){

      /// FILE
      if (object is File){
        loadFile(
          file: object,
          autoPlay: autoPlay,
          showVolumeSlider: showVolumeSlider,
          loop: loop,
        );
      }

      /// URL
      else if (ObjectCheck.isAbsoluteURL(object) == true){
        loadURL(
          url: object,
          loop: loop,
          showVolumeSlider: showVolumeSlider,
          autoPlay: autoPlay,
        );
      }

      /// ASSET
      else if (object is String){
        loadAsset(
          asset: object,
          autoPlay: autoPlay,
          showVolumeSlider: showVolumeSlider,
          loop: loop,
        );
      }

      /// MEDIA MODEL
      else if (object is MediaModel){

        final File? _file = await Filer.createFromMediaModel(
          mediaModel: object,
        );

        if (_file != null){
          loadFile(
            file: _file,
            loop: loop,
            showVolumeSlider: showVolumeSlider,
            autoPlay: autoPlay,
          );
        }

      }

      /// BYTES
      else if (object is Uint8List){

        final File? _file = await Filer.createFromBytes(
          bytes: object,
          fileName: fileNameIfObjectIsBytes,
        );

        if (_file != null){
          loadFile(
            file: _file,
            autoPlay: autoPlay,
            showVolumeSlider: showVolumeSlider,
            loop: loop,
          );
        }

      }

    }

  }
  // --------------------------------------------------------------------------

  /// SCALES

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeightByAspectRatio({
    required double? aspectRatio,
    required double width,
    required bool force169,
  }){
    double _output = width / (16 / 9);

    if (aspectRatio != null && force169 == false) {
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so heightB = widthB / aspectRatio
      _output = width / aspectRatio;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCorners({
    required double width,
    required dynamic corners,
  }) {
    return Borderers.superCorners(
      corners: corners ?? BorderRadius.circular(width * 0.02),
    );
  }
  // --------------------------------------------------------------------------
}
