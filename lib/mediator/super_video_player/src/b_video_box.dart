part of super_video_player;

class VideoBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoBox({
    required this.width,
    this.child,
    this.boxColor = Colorz.black255,
    this.aspectRatio,
    this.corners,
    super.key
  });
  // --------------------------------------------------------------------------
  final double width;
  final Widget? child;
  final Color boxColor;
  final double? aspectRatio;
  final double? corners;
  // --------------------------------------------------------------------------
    /// TESTED : WORKS PERFECT
  static double getHeightByAspectRatio({
    required double? aspectRatio,
    required double width,
    required bool force169,
  }){
    double _output = width / (16 / 9);

    if (aspectRatio != null && force169 == false) {
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so heightB = widthB / aspectRatio
      _output = width / aspectRatio;
    }

    return _output;
  }
  // --------------------------------------------------------------------------
    /// TESTED : WORKS PERFECT
  static BorderRadius getCorners({
    required double width,
    double? cornersOverride,
  }) {
    final double _value = cornersOverride ?? width * 0.03;
    return BorderRadius.circular(_value);
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = getHeightByAspectRatio(
      aspectRatio: aspectRatio,
      width: width,
      force169: false,
    );

    final BorderRadius _borders = getCorners(
      width: width,
      cornersOverride: corners,
    );

    return Container(
      width: width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: _borders,
        color: boxColor,
      ),
      child: ClipRRect(
        borderRadius: _borders,
        child: child,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
