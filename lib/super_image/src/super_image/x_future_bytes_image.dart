part of super_image;

class FutureImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FutureImage({
    required this.snapshot,
    required this.width,
    required this.height,
    required this.boxFit,
    required this.errorBuilder,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final AsyncSnapshot<Uint8List> snapshot;
  final double width;
  final double height;
  final BoxFit boxFit;
  final Function(BuildContext, Object, StackTrace?) errorBuilder;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool _connectionIsLoading(AsyncSnapshot<dynamic> snapshot){

    if (snapshot.connectionState == ConnectionState.waiting){
      return true;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (_connectionIsLoading(snapshot) == true){
      return InfiniteLoadingBox(
        width: width,
        height: height,
      );
    }

    /// UI.IMAGE
    else {

      return CachelessImage(
        bytes: snapshot.data,
        boxFit: boxFit,
        width: width,
        height: height,
        // errorBuilder: errorBuilder,
        // scale: 1,
      );

    }

  }
  /// --------------------------------------------------------------------------
}
