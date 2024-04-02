part of super_video_player;

class _TheYoutubePlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TheYoutubePlayer({
    required this.superVideoController,
    required this.width,
    required this.corners,
    // super.key
  });
  // --------------------
  final SuperVideoController superVideoController;
  final double width;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = SuperVideoController.getCorners(
      corners: corners,
      width: width,
    );
    // --------------------
    /// THUMBNAIL
    if (superVideoController.youtubeController == null){

      final double _height = width * 9 / 16;

      return Stack(
        children: <Widget>[

          /// IMAGE
          SuperImage(
            pic: superVideoController.getYouTubeVideoCoverImageURL(),
            width: width,
            height: _height,
            loading: false,
            corners: _corners,
          ),

          /// PLAY ICON ON TOP
          SuperBox(
            width: width,
            height: _height,
            icon: Iconz.play,
            iconSizeFactor: 0.6,
            iconColor: Colors.white,
            bubble: false,
            opacity: 0.5,
            onTap: superVideoController.onVideoTap,
          ),

        ],
      );

    }

    /// YOUTUBE PLAYER
    else {
      return _VideoBox(
        width: width,
        boxColor: Colorz.black255,
        corners: _corners,
        aspectRatio: 16/9,
        child: YoutubePlayer(
          /// MAIN
          key: const ValueKey<String>('YoutubeVideoPlayer'),
          controller: superVideoController.youtubeController!,
          /// SIZING
          width: width,
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

            if (superVideoController.isAutoPlay == false){
              superVideoController.pause();
            }

            },
          onEnded: (YoutubeMetaData metaData) {
            blog('YoutubePlayer is ENDED : metaData : $metaData');
            },

        ),
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
