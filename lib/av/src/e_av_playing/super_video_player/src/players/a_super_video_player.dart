part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperVideoPlayer({
    required this.width,
    required this.height,
    this.video,
    this.corners,
    this.controller,
    this.errorIcon,
    this.isMuted = false,
    this.autoPlay = true,
    this.loop = false,
    this.cover,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final dynamic corners;
  final SuperVideoController? controller;
  final String? errorIcon;
  final dynamic video;
  final bool isMuted;
  final bool autoPlay;
  final bool loop;
  final dynamic cover;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (controller == null){
      return _SuperVideoDynamicObjectLoader(
        width: width,
        height: height,
        errorIcon: errorIcon,
        corners: corners,
        video: video,
        isMuted: isMuted,
        autoPlay: autoPlay,
        loop: loop,
        cover: cover,
        // controller: null,
      );
    }
    // --------------------
    else {
      return _SuperVideoControllerPlayer(
        width: width,
        height: height,
        superVideoController: controller,
        corners: corners,
        errorIcon: errorIcon,
        cover: cover,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
