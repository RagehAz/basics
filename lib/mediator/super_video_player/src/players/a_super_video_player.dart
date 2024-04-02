part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperVideoPlayer({
    required this.width,
    this.media,
    this.corners,
    this.controller,
    this.errorIcon,
    super.key
  });
  // --------------------
  final double width;
  final dynamic corners;
  final SuperVideoController? controller;
  final String? errorIcon;
  final dynamic media;
  // --------------------
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (controller == null){
      return _SuperVideoDynamicObjectLoader(
        width: width,
        errorIcon: errorIcon,
        corners: corners,
        media: media,
        // controller: null,
      );
    }
    // --------------------
    else {
      return SuperVideoControllerPlayer(
        width: width,
        superVideoController: controller,
        corners: corners,
        errorIcon: errorIcon,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
