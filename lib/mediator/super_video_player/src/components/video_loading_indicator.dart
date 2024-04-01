part of super_video_player;

class VideoLoadingIndicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoLoadingIndicator({
    required this.videoWidth,
    super.key
  });
  // --------------------
  final double videoWidth;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      height: videoWidth * 0.3,
      width: videoWidth * 0.3,
      icon: Iconz.reload,
      bubble: false,
      opacity: 0.5,
      loading: true,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
