part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperVideoPlayer({
    required this.canvasWidth,
    required this.canvasHeight,
    this.video,
    this.canvasCorners,
    this.errorIcon,
    this.isMuted = false,
    this.autoPlay = true,
    this.loop = false,
    this.cover,
    super.key
  });
  // --------------------
  final double canvasWidth;
  final double canvasHeight;
  final dynamic canvasCorners;
  final String? errorIcon;
  final dynamic video;
  final bool isMuted;
  final bool autoPlay;
  final bool loop;
  final dynamic cover;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NO CONTROLLER GIVEN
    if (video == null){
      return _VideoCanvas(
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        canvasCorners: canvasCorners,
        child: SuperImage(
          width: canvasWidth,
          height: canvasHeight,
          pic: cover,
          loading: false,
          corners: canvasCorners,
          backgroundColor: Colorz.white20,
        ),
      );
    }
    // --------------------
    /// VIDEO DYNAMIC PLAYER
    else if (video is SuperVideoController){
      return _VideoCanvas(
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        canvasCorners: canvasCorners,
        child: _SuperVideoControllerPlayer(
          canvasWidth: canvasWidth,
          canvasHeight: canvasHeight,
          superVideoController: video,
          corners: canvasCorners,
          errorIcon: errorIcon,
          cover: cover,
        ),
      );
    }
    // --------------------
    /// VIDEO CONTROLLER PLAYER
    else {
      return _VideoCanvas(
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        canvasCorners: canvasCorners,
        child: _SuperVideoDynamicLoader(
          canvasWidth: canvasWidth,
          canvasHeight: canvasHeight,
          errorIcon: errorIcon,
          corners: canvasCorners,
          video: video,
          isMuted: isMuted,
          autoPlay: autoPlay,
          loop: loop,
          cover: cover,
          // controller: null,
        ),
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
