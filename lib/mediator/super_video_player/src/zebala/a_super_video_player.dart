part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVideoPlayer({
    required this.superVideoController,
    required this.width,
    this.errorIcon,
    this.corners = 10,
    super.key
  });
  // --------------------
  final SuperVideoController? superVideoController;
  final double width;
  final String? errorIcon;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (superVideoController == null){
      return VideoBox(
        width: width,
        aspectRatio: 19/6,//aspectRatio,
      );
    }

    else {
      return _TheVideoPlayer(
        superVideoController: superVideoController!,
        width: width,
        corners: corners,
        errorIcon: errorIcon,
      );
    }

    // /// ASSET OR FILE
    // if (superVideoController != null || asset != null || file != null){
    //     return FileAndURLVideoPlayer(
    //       width: width,
    //       asset: asset,
    //       file: file,
    //       autoPlay: autoPlay,
    //       loop: loop,
    //       errorIcon: errorIcon,
    //       // controller: controller,
    //       superVideoController: superVideoController,
    //       corners: corners,
    //       url: url,
    //     );
    // }
    //
    // /// URL
    // else if (url != null){
    //
    //   final bool _isYoutubeLink = YoutubeVideoPlayer.checkIsValidYoutubeLink(url);
    //
    //   /// YOUTUBE URL
    //   if (_isYoutubeLink == true){
    //     return YoutubeVideoPlayer(
    //       videoID: YoutubeVideoPlayer.extractVideoIDFromYoutubeURL(url),
    //       width: width,
    //       autoPlay: autoPlay,
    //       /// LOOPING WAS NOT CONNECTED HERE
    //     );
    //   }
    //
    //   /// MP4 URL
    //   else {
    //     return FileAndURLVideoPlayer(
    //       url: url,
    //       width: width,
    //       autoPlay: autoPlay,
    //       loop: loop,
    //       errorIcon: errorIcon,
    //       // controller: controller,
    //       corners: corners,
    //       superVideoController: superVideoController,
    //       file: file,
    //       asset: asset,
    //     );
    //   }
    //
    // }
    //
    // /// NOTHING
    // else {
    //   return VideoBox(
    //     width: width,
    //     aspectRatio: 19/6,//aspectRatio,
    //   );
    // }

  }
  /// --------------------------------------------------------------------------
}
