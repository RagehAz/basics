part of super_video_player;

class _VideoLoadingIndicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoLoadingIndicator({
    required this.videoWidth,
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
      loadingIsPulse: true,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
