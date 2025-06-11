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
    final BorderRadius _corners = SuperVideoScale.getCorners(
      corners: corners,
      width: width,
    );
    // --------------------
    return Center(
      child: ClipRRect(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: _corners,
            // color: Colorz.bloodTest,
          ),
          child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              /// to clip the child corners to be circular forcefully
              shape: RoundedRectangleBorder(borderRadius: _corners),
              /// THIS FIXES THE WHITE INITIAL FLASH IN IOS
              color: Colorz.nothing,
              child: VideoPlayer(controller),
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
