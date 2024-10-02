part of super_video_player;
///
class SuperVideoController {
  // --------------------------------------------------------------------------

  SuperVideoController();

  // --------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  void loadFile({
    required File? file,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
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
        isMuted: isMuted,
      );

      _isFile = true;
      _videoFile = file;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void loadAsset({
    required String? asset,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
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
        isMuted: isMuted,
      );

      _isAsset = true;
      _videoAsset = asset;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void loadURL({
    required String? url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }){

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final bool _isYoutubeLink = checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        _loadYoutubeURL(
          url: url!,
          autoPlay: autoPlay,
          loop: loop,
          isMuted: isMuted,
        );
      }

      /// VIDEO URL
      else {
        _loadVideoURL(
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
  void _loadYoutubeURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool isMuted,
  }){

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
  void _loadVideoURL({
    required String url,
    required bool autoPlay,
    required bool loop,
    required bool showVolumeSlider,
    required bool isMuted,
  }){

    final VideoPlayerOptions _options = VideoPlayerOptions(
      mixWithOthers: true,
      // webOptions: VideoPlayerWebOptions(),
      // allowBackgroundPlayback: false,
    );

    blog('_loadVideoURL:url($url)');

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(url),
      videoPlayerOptions: _options,
      // closedCaptionFile: ,
      httpHeaders: {
        'Range': 'bytes=0-', // Range request header
      },
    );

    _videoPlayerController!.addListener(_listenToVideo);

    _setupFilePlayer(
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
  void _setupFilePlayer({
    required bool loop,
    required bool autoPlay,
    required bool showVolumeSlider,
    required bool isMuted,
  }){

    if (_videoPlayerController != null){
      _videoPlayerController!.initialize();
    }

    setVolume(isMuted ? 0 : 1);

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
  /// TURNED_OFF_YOUTUBE_PLAYER
  // /// TESTED : WORKS PERFECT
  // void _setupYoutubePlayer({
  //   required bool autoPlay,
  //   required bool isMuted,
  // }){
  //
  //   /// VOLUME
  //   _youtubeController?.setVolume(isMuted ? 0 : 100);
  //
  //   /// AUTO PLAY
  //   if (autoPlay == true){
  //     play();
  //   }
  //   else {
  //     pause();
  //   }
  //
  //   /// IS AUTO PLAY
  //   _isAutoPlay = autoPlay;
  //
  // }
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
    /// TURNED_OFF_YOUTUBE_PLAYER
    // _youtubeController?.dispose();
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
  /// TURNED_OFF_YOUTUBE_PLAYER
  // bool _isYoutubeURL = false;
  // bool get isYoutubeURL => _isYoutubeURL;
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
  /// TURNED_OFF_YOUTUBE_PLAYER
  // YoutubePlayerController? _youtubeController;
  // YoutubePlayerController? get youtubeController => _youtubeController;
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

    if (_isPlaying == true){
      pause();
    }
    else {
      play();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void play(){

    if (_isPlaying == false){
      _isPlaying = true;
      _videoPlayerController?.play();
      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.play();
      _videoPlayerController?.setLooping(true);
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void pause(){

    if (_isPlaying == true){
      _isPlaying = false;
      _videoPlayerController?.pause();
      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.pause();
      _videoPlayerController?.setLooping(false);
    }

  }
  // --------------------------------------------------------------------------

  /// LOOPING

  // --------------------
  void setLooping(bool setTo){

    if (setTo == true){
      _videoPlayerController?.setLooping(true);
      play();
    }

    else {
      _videoPlayerController?.setLooping(false);
      pause();
    }

  }
  // --------------------------------------------------------------------------

  /// VOLUME

  // --------------------
  /// TESTED : WORKS PERFECT
  void setVolume(double volume){

    if (_volume.value != volume){

      _videoPlayerController?.setVolume(volume);

      /// TURNED_OFF_YOUTUBE_PLAYER
      // _youtubeController?.setVolume((volume * 100).toInt());

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
  /// TESTED : WORKS PERFECT
  void onMutingTap(){

    final bool _isMuted = checkIsMuted();

    if (_isMuted){
      unMute();
    }

    else {
      mute();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void mute(){
    _volumeBeforeMute = _volume.value;
    setVolume(0);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

    else if (checkIsInitialed() == false) {
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

    else if (checkIsInitialed() == false) {
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

    if (_videoValue.value == null) {
      return true;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.hasError) == true){
      return true;
    }

    else if (checkIsInitialed() == false) {
      return false;
    }

    else if (Mapper.boolIsTrue(_videoValue.value?.isBuffering) == true){
      return false;
    }
    else if (Mapper.boolIsTrue(_videoValue.value?.isPlaying) == true){
      return false;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkHasError(){
    return _videoValue.value != null && _videoValue.value!.hasError == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsInitialed(){
    return Mapper.boolIsTrue(_videoValue.value?.isInitialized);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

    /// TURNED_OFF_YOUTUBE_PLAYER
    // final bool _isYoutubeLink = checkIsValidYoutubeLink(_videoURL);
    //
    // if (_youtubeController != null && _isYoutubeLink == true){
    //
    //   // final String link = 'https://www.youtube.com/watch?v=$videoID';
    //   // final meta.MetaDataModel metaData = await meta.YoutubeMetaData.getData(link);
    //
    //   final YoutubeMetaData? videoMetaData = _youtubeController?.metadata;
    //   final String? id = videoMetaData?.videoId;
    //
    //   if (id != null){
    //     _output = 'https://img.youtube.com/vi/$id/0.jpg';
    //   }
    //
    // }

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
    bool isMuted = false,
  }) async {

    if (object != null){

      /// FILE
      if (object is File){
        loadFile(
          file: object,
          autoPlay: autoPlay,
          showVolumeSlider: showVolumeSlider,
          loop: loop,
          isMuted: isMuted,
        );
      }

      /// URL
      else if (ObjectCheck.isAbsoluteURL(object) == true){
        loadURL(
          url: object,
          loop: loop,
          showVolumeSlider: showVolumeSlider,
          autoPlay: autoPlay,
          isMuted: isMuted,
        );
      }

      /// ASSET
      else if (object is String){
        loadAsset(
          asset: object,
          autoPlay: autoPlay,
          showVolumeSlider: showVolumeSlider,
          loop: loop,
          isMuted: isMuted,
        );
      }

      /// MEDIA MODEL
      else if (object is MediaModel){

        final File? _file = await Filer.createFromMediaModel(
          mediaModel: object,
          includeFileExtension: true, /// breaks on ios if file has no extension
        );

        if (_file != null){
          loadFile(
            file: _file,
            loop: loop,
            showVolumeSlider: showVolumeSlider,
            autoPlay: autoPlay,
            isMuted: isMuted,
          );
        }

      }

      /// BYTES
      else if (object is Uint8List){

        final File? _file = await Filer.createFromBytes(
          bytes: object,
          fileName: fileNameIfObjectIsBytes,
          includeFileExtension: true, /// breaks on ios if file has no extension
        );

        if (_file != null){
          loadFile(
            file: _file,
            autoPlay: autoPlay,
            showVolumeSlider: showVolumeSlider,
            loop: loop,
            isMuted: isMuted,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeightOnScreen({
    required double videoWidth,
    required double videoHeight,
    required double areaWidth,
    required double areaHeight,
  }){
    final Dimensions _dims = Dimensions(width: videoWidth, height: videoHeight);
    final double _areaHeight = areaHeight;

    final double _videoRatio = _dims.getAspectRatio();  // w / h
    final double _areaWidth = areaWidth;

    if (_dims.checkIsSquared() == true){
      return _areaWidth > _areaHeight ? _areaHeight : _areaWidth;
    }
    else if (_dims.checkIsLandscape() == true){
      return _areaWidth / _videoRatio;
    }
    else if (_dims.checkIsPortrait() == true){
      return _areaHeight;
    }
    else {
      return _areaHeight;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getWidthOnScreen({
    required double videoWidth,
    required double videoHeight,
    required double areaWidth,
    required double areaHeight,
  }){

    final Dimensions _dims = Dimensions(width: videoWidth, height: videoHeight);
    final double _videoRatio = _dims.getAspectRatio();  // w / h

    // blog('===> _cropped : $_dims : $_videoRatio');
    // final Dimensions _real = Dimensions.fromSize(controller.videoDimension);
    // blog('===> real : $_real : ${_real.getAspectRatio()}');
    // blog('===> areaWidth : $areaWidth : areaHeight : $areaHeight');

    return _videoRatio * getHeightOnScreen(
      videoWidth: videoWidth,
      videoHeight: videoHeight,
      areaWidth: areaWidth,
      areaHeight: areaHeight,
    );

  }
  // --------------------------------------------------------------------------
}
