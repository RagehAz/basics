part of super_video_player;

class VideoCard extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoCard({
    required this.width,
    required this.height,
    required this.corners,
    required this.controller,
    super.key
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
    final BorderRadius _corners = Borderers.superCorners(
      corners: corners ?? BorderRadius.circular(width * 0.02),
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
