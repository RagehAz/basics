part of super_stop_watch;

class StopWatchButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StopWatchButton({
    required this.icon,
    required this.onTap,
    this.width = 50,
    this.height = 50,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? icon;
  final Function? onTap;
  final double width;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperBox(
      height: height,
      width: width,
      icon: icon,
      iconSizeFactor: 0.5,
      // textShadow: false,
      onTap: onTap,
    );

  }
  /// --------------------------------------------------------------------------
}
