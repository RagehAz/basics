part of super_video_player;

class _SuperVideoControllerPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _SuperVideoControllerPlayer({
    required this.superVideoController,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.cover,
    this.errorIcon,
    this.corners = 10,
  });
  // --------------------
  final SuperVideoController? superVideoController;
  final double canvasWidth;
  final double canvasHeight;
  final String? errorIcon;
  final dynamic corners;
  final dynamic cover;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (superVideoController == null){
      return _VideoBox(
        width: canvasWidth,
        aspectRatio: canvasWidth / canvasHeight,
        corners: corners,
        boxColor: Colorz.black255,
        child: null,
      );
    }

    else {

      /// TURNED_OFF_YOUTUBE_PLAYER
      // if (superVideoController!.isYoutubeURL == true){
      //   return _TheYoutubePlayer(
      //     superVideoController: superVideoController!,
      //     width: width,
      //     corners: corners,
      //   );
      // }
      //
      // else {

        return _FilePlayer(
          superVideoController: superVideoController!,
          width: canvasWidth,
          height: canvasHeight,
          corners: corners,
          errorIcon: errorIcon,
          cover: cover,
        );
      // }

    }

  }
  // --------------------------------------------------------------------------
}
