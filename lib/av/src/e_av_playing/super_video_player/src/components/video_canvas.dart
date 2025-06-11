part of super_video_player;

class _VideoCanvas extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoCanvas({
    required this.canvasWidth,
    required this.canvasHeight,
    required this.canvasCorners,
    required this.child,
    // super.key
  });
  // --------------------
  final double canvasWidth;
  final double canvasHeight;
  final dynamic canvasCorners;
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Center(
      child: Container(
        width: canvasWidth,
        height: canvasHeight,
        decoration: BoxDecoration(
          color: Colorz.black255,
          borderRadius: Borderers.superCorners(corners: canvasCorners),
        ),
        child: child,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
