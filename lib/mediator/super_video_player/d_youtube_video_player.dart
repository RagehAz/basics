import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/mediator/models/video_model.dart';
import 'package:basics/mediator/super_video_player/b_video_box.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_metadata/youtube.dart' as meta;

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

    final bool _isValidVideoID = VideoModel.checkIsValidYoutubeVideoID(widget.videoID);

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
  /// TESTED : WORKS PERFECT
  Future<String?> getYouTubeVideoCoverImage(String? videoID) async {

    final String link = 'https://www.youtube.com/watch?v=$videoID';
    final meta.MetaDataModel metaData = await meta.YoutubeMetaData.getData(link);

    blog('metaData.title : ${metaData.title}');
    blog('metaData.authorName : ${metaData.authorName}');
    blog('metaData.authorUrl : ${metaData.authorUrl}');
    blog('metaData.type : ${metaData.type}');
    blog('metaData.height : ${metaData.height}');
    blog('metaData.width : ${metaData.width}');
    blog('metaData.version : ${metaData.version}');
    blog('metaData.providerName : ${metaData.providerName}');
    blog('metaData.providerUrl : ${metaData.providerUrl}');
    blog('metaData.thumbnailHeight : ${metaData.thumbnailHeight}');
    blog('metaData.thumbnailWidth : ${metaData.thumbnailWidth}');
    blog('metaData.thumbnailUrl : ${metaData.thumbnailUrl}');
    blog('metaData.html : ${metaData.html}');
    blog('metaData.url : ${metaData.url}');
    blog('metaData.description : ${metaData.description}');

    return metaData.thumbnailUrl;
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
