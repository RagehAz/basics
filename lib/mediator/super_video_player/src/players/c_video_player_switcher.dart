part of super_video_player;

class _SuperVideoControllerPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _SuperVideoControllerPlayer({
    required this.superVideoController,
    required this.width,
    required this.height,
    this.errorIcon,
    this.corners = 10,
  });
  // --------------------
  final SuperVideoController? superVideoController;
  final double width;
  final double height;
  final String? errorIcon;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (superVideoController == null){
      return _VideoBox(
        width: width,
        aspectRatio: width / height,
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
          height: height,
          corners: corners,
          errorIcon: errorIcon,
        );
      }

    }

  }
  // --------------------------------------------------------------------------
}
