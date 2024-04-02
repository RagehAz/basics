part of super_video_player;

class _SuperVideoControllerPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _SuperVideoControllerPlayer({
    required this.superVideoController,
    required this.width,
    this.errorIcon,
    this.corners = 10,
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
      return _VideoBox(
        width: width,
        aspectRatio: 19/6,
        corners: corners,
        boxColor: Colorz.black255,
        child: null,
      );
    }

    else {

      if (superVideoController!.isYoutubeURL == true){
        return _TheYoutubePlayer(
          superVideoController: superVideoController!,
          width: width,
          corners: corners,
        );
      }

      else {
        return _FilePlayer(
          superVideoController: superVideoController!,
          width: width,
          corners: corners,
          errorIcon: errorIcon,
        );
      }

    }

  }
  // --------------------------------------------------------------------------
}
