part of super_video_player;

class _VideoPlayIcon extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoPlayIcon({
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
      icon: Iconz.play,
      bubble: false,
      opacity: 0.5,
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
