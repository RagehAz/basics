part of super_image;

class InfiniteLoadingBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    required this.width,
    required this.height,
    this.color,
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? 40;
    final double _height = height ?? _width;

    return WidgetFader(
      fadeType: FadeType.repeatForwards,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 1000),
      builder: (double value, Widget? child){

        return Container(
          width: _width,
          height: _height,
          color: Colorz.white50,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: _width,
            height: _height * value / 1, // the ( value / 1 ) part is the percentage
            color: color ?? Colorz.white20,
          ),
        );

      },
    );

  }
/// --------------------------------------------------------------------------
}
