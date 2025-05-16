// ignore_for_file: join_return_with_assignment
part of av;
/// => TAMAM
@immutable
class Dimensions {
  // --------------------------------------------------------------------------
  const Dimensions({
    required this.width,
    required this.height,
  });
  // --------------------
  final double? width;
  final double? height;
  // -----------------------------------------------------------------------------

  /// ZERO

  // --------------------
  static Dimensions zero = const Dimensions(width: 0, height: 0,);
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions? decipherDimensions(Map<String, dynamic>? map) {
    Dimensions? _imageSize;
    if (map != null) {

      final dynamic _widthInInt = map['width'];
      final dynamic _heightInInt = map['height'];

      _imageSize = Dimensions(
        width: _widthInInt.toDouble(),
        height: _heightInInt.toDouble(),
      );
    }
    return _imageSize;
  }
  // -----------------------------------------------------------------------------

  /// toSize

  // --------------------
  /// TESTED : WORKS PERFECT
  Size toSize(){
    return Size(width ?? 0, height ?? 0);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions fromSize(Size? size){
    return Dimensions(width: size?.width ?? 0, height: size?.height ?? 0);
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  double getAspectRatio(){

      double _output = 1;

      final double _width = width ?? 0;
      final double _height = height ?? 0;

      if (_width == 0 || _height == 0){
        _output = 1;
      }
      else {
        /// ASPECT RATIO IS WITH / HEIGHT
        _output = _width / _height;
      }

      return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getHeightByAspectRatio({
    required double? aspectRatio,
    required double? width,
  }){
    double? _output;

    if (aspectRatio != null && width != null){
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so heightB = widthB / aspectRatio
      _output = width / aspectRatio;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getWidthByAspectRatio({
    required double? aspectRatio,
    required double? height,
  }){
    double? _output;

    if (aspectRatio != null && height != null){
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so widthB = aspectRatio * heightB
      _output = aspectRatio * height;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getHeightForWidth({
    required double? width,
  }){
    final double? _aspectRatio = getAspectRatio();
    return getHeightByAspectRatio(aspectRatio: _aspectRatio, width: width);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double? getWidthForHeight({
    required double? height,
  }){
    final double? _aspectRatio = getAspectRatio();
    return getWidthByAspectRatio(aspectRatio: _aspectRatio, height: height);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? resizeToWidth({
    required double? width,
  }){

    if (width == null){
      return null;
    }

    else {
      final double _height = getHeightForWidth(width: width)!;
      return Dimensions(width: width, height: _height);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Dimensions? resizeToHeight({
    required double? height,
  }){

    if (height == null){
      return null;
    }

    else {
      final double _width = getWidthForHeight(height: height)!;
      return Dimensions(width: _width, height: height);
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDimensions({String invoker = ''}) {
    blog('blogDimensions.($invoker).Dimensions.W($width).H($height)');
  }
  // -----------------------------------------------------------------------------

  /// BOX FIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static int cipherBoxFit(BoxFit? boxFit) {
    switch (boxFit) {
      case BoxFit.fitHeight:return 1;
      case BoxFit.fitWidth:return 2;
      case BoxFit.cover:return 3;
      case BoxFit.none:return 4;
      case BoxFit.fill:return 5;
      case BoxFit.scaleDown:return 6;
      case BoxFit.contain:return 7;
      default:return 3;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BoxFit? decipherBoxFit(int? boxFit) {
    switch (boxFit) {
      case 1:   return BoxFit.fitHeight;
      case 2:   return BoxFit.fitWidth;
      case 3:   return BoxFit.cover;
      case 4:   return BoxFit.none;
      case 5:   return BoxFit.fill;
      case 6:   return BoxFit.scaleDown;
      case 7:   return BoxFit.contain;
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double concludeHeightByDimensions({
    required double width,
    required double graphicWidth,
    required double graphicHeight,
  }) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicHeight * width) / graphicWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double concludeWidthByDimensions({
    required double height,
    required double graphicWidth,
    required double graphicHeight,
  }) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicWidth * height) / graphicHeight;
  }
  // -----------------------------------------------------------------------------

  /// ORIENTATION CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsPortrait(){

    if (Numeric.isGreaterThan(number: height, isGreaterThan: width) == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsLandscape(){

    if (Numeric.isGreaterThan(number: width, isGreaterThan: height) == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsSquared(){

    if (width == height){
      return true;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDimensionsAreIdentical({
    required Dimensions? dim1,
    required Dimensions? dim2,
  }){

    bool _identical = false;

    if (dim1 == null && dim2 == null){
      _identical = true;
    }
    else if (
    dim1 != null &&
        dim2 != null &&
        dim1.width == dim2.width &&
        dim1.height == dim2.height
    ){
      _identical = true;
    }

    return _identical;
  }
// -----------------------------------------------------------------

  /// BOX FIT

  // --------------------
  /*
  static BoxFit concludeBoxFitOld(Asset asset) {
    final BoxFit _fit = asset.isPortrait ? BoxFit.fitHeight : BoxFit.fitWidth;
    return _fit;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static BoxFit concludeBoxFit({
    required double picWidth,
    required double picHeight,
    required double viewWidth,
    required double viewHeight,
  }) {
    BoxFit _boxFit;

    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    // double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

    // double _fittedImageWidth = flyerBoxWidth; // for info only
    final double _fittedImageHeight = (viewWidth * picHeight) / picWidth;

    final double _heightAllowingFitHeight = (Ratioz.slideFitWidthLimit / 100) * viewHeight;

    /// if fitted height is less than the limit
    if (_fittedImageHeight < _heightAllowingFitHeight) {
      _boxFit = BoxFit.fitWidth;
    }

    /// if fitted height is higher that the limit
    else {
      _boxFit = BoxFit.fitHeight;
    }

    return _boxFit;
  }
  // --------------------
  /*
  BoxFit concludeBoxFitForAsset({
    required Asset asset,
    required double flyerBoxWidth,
  }) {
    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    final double _originalImageWidth = asset.originalWidth.toDouble();
    final double _originalImageHeight = asset.originalHeight.toDouble();
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    /// slide aspect ratio : 1 / 1.74 ~= 0.575
    final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;

    return concludeBoxFit(
      picWidth: _originalImageWidth,
      picHeight: _originalImageHeight,
      viewWidth: flyerBoxWidth,
      viewHeight: _flyerZoneHeight,
    );
  }
   */
  // --------------------
  /*
  List<BoxFit> concludeBoxesFitsForAssets({
    required List<Asset> assets,
    required double flyerBoxWidth,
  }) {
    final List<BoxFit> _fits = <BoxFit>[];

    for (final Asset asset in assets) {
      /// straigh forward solution,, bas ezzay,, I'm Rage7 and I can't just let it go keda,,
      // if(asset.isPortrait){
      //   _fits.add(BoxFit.fitHeight);
      // } else {
      //   _fits.add(BoxFit.fitWidth);
      // }

      /// boss ba2a
      final BoxFit _fit = concludeBoxFitForAsset(
        asset: asset,
        flyerBoxWidth: flyerBoxWidth,
      );

      _fits.add(_fit);
    }

    return _fits;
  }
   */
  // --------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'Dimensions(width: $width, height: $height)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Dimensions){
      _areIdentical = checkDimensionsAreIdentical(
        dim1: this,        dim2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      width.hashCode^
      height.hashCode;
  // -----------------------------------------------------------------------------
}
