part of super_video_player;

class _VideoErrorIcon extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoErrorIcon({
    required this.videoWidth,
    required this.icon,
  });
  // --------------------
  final double videoWidth;
  final String? icon;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      height: videoWidth * 0.3,
      width: videoWidth * 0.3,
      icon: icon ?? Iconz.yellowAlert,
      bubble: false,
      opacity: 0.1,
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
