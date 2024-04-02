part of super_video_player;

class _VideoCard extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoCard({
    required this.width,
    required this.height,
    required this.corners,
    required this.controller,
  });
  // --------------------
  final double width;
  final double height;
  final dynamic corners;
  final VideoPlayerController controller;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = SuperVideoController.getCorners(
      corners: corners,
      width: width,
    );
    // --------------------
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: _corners,
        // color: Colorz.bloodTest,
      ),
      child: Card(
          clipBehavior: Clip.antiAlias,
          /// to clip the child corners to be circular forcefully
          shape: RoundedRectangleBorder(borderRadius: _corners),
          // color: Colorz.black255,
          child: VideoPlayer(controller),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
