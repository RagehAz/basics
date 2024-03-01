part of super_video_player;

class YoutubeVideoPlayer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const YoutubeVideoPlayer({
    required this.videoID,
    this.width,
    this.autoPlay = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final String? videoID;
  final double? width;
  final bool autoPlay;
  // --------------------------------------------------------------------------
  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
  // -----------------------------------------------------------------------------

  /// CHECKERS

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
  // --------------------------------------------------------------------------
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  // --------------------------------------------------------------------------
  YoutubePlayerController? _controller;
  bool _canPlay = false;
  String? _coverURL;
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

    final bool _isValidVideoID = YoutubeVideoPlayer.checkIsValidYoutubeVideoID(widget.videoID);

    if (_isValidVideoID == true && widget.videoID != null){
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoID!,
        // flags: const YoutubePlayerFlags(
        //   autoPlay: true,
        // ),
      );

     if (widget.autoPlay == true){
      _controller?.play();
      _canPlay = true;
     }

    }

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        if (widget.autoPlay == false){
          final String? _cover = await getYouTubeVideoCoverImage(widget.videoID);
          if (mounted == true){
            setState(() {
              _coverURL = _cover;
            });
          }
        }

        await _triggerLoading(setTo: false);
      });

    }

    super.didChangeDependencies();
  }
  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  Future<String?> getYouTubeVideoCoverImage(String? videoID) async {

    // final String link = 'https://www.youtube.com/watch?v=$videoID';
    // final meta.MetaDataModel metaData = await meta.YoutubeMetaData.getData(link);

    final YoutubeMetaData? videoMetaData = _controller?.metadata;
    final String? id = videoMetaData?.videoId;

    if (id == null){
      return null;
    }
    else {
      return 'https://img.youtube.com/vi/$id/0.jpg';
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onPlay(){
    setState(() {
      _canPlay = true;
    });
    _controller?.play();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = widget.width ?? Scale.screenWidth(context);

    /// NO VIDEO
    if (_controller == null){
      return VideoBox(
        width: _width,
        boxColor: Colorz.yellow255,
      );
    }

    /// THUMBNAIL
    else if (widget.autoPlay == false && _canPlay == false){

      final double _height = _width * 9 / 16;

      return Stack(
        children: <Widget>[

          /// IMAGE
          SuperImage(
            pic: _coverURL,
            width: _width,
            height: _height,
            loading: false,
            corners: VideoBox.getCorners(
              width: _width,
            ),
          ),

          /// PLAY ICON ON TOP
          SuperBox(
            width: _width,
            height: _height,
            icon: Iconz.play,
            iconSizeFactor: 0.6,
            iconColor: Colors.white,
            bubble: false,
            opacity: 0.5,
            onTap: _onPlay,
          ),

        ],
      );

    }

    /// YOUTUBE PLAYER
    else {
      return VideoBox(
        width: _width,
        child: YoutubePlayer(
        /// MAIN
        key: const ValueKey<String>('YoutubeVideoPlayer'),
        controller: _controller!,

        /// SIZING
        width: _width,
        // aspectRatio: 16 / 9,
        // actionsPadding: EdgeInsets.all(8.0),

        /// STYLING
        showVideoProgressIndicator: true,
        // bufferIndicator: true,
        liveUIColor: const Color(0xFFff0000),
        // thumbnail: ,

        /// BEHAVIOUR
        // controlsTimeOut: const Duration(seconds: 3),

        /// PROGRESS
        progressIndicatorColor: const Color(0xFFff0000),
        // progressColors: ,

        /// ACTIONS
        // topActions: ,
        // bottomActions: ,

        /// FUNCTIONS
        onReady: () {

          blog('YoutubePlayer is READY');

          if (widget.autoPlay == false){
            _controller!.pause();
          }


        },
        onEnded: (YoutubeMetaData metaData) {
          blog('YoutubePlayer is ENDED : metaData : $metaData');
        },

    ),
      );
    }

  }
  // --------------------------------------------------------------------------
}
