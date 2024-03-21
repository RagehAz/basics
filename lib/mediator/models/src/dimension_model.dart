// ignore_for_file: join_return_with_assignment
part of media_models;

/// => TAMAM
@immutable
class Dimensions {
  /// --------------------------------------------------------------------------
  const Dimensions({
    required this.width,
    required this.height,
  });
  /// --------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDimensions({String invoker = ''}) {
    blog('blogDimensions : $invoker : Dimensions: W [ $width ] x H [ $height ]');
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

  /// CHECKERS

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
  // -----------------------------------------------------------------------------

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
        dim1: this,
        dim2: other,
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

abstract class DimensionsGetter {
  // -----------------------------------------------------------------------------

  const DimensionsGetter();

  // -----------------------------------------------------------------------------

  /// SUPER

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromDynamic({
    required dynamic object,
    required String fileName,
  }) async {

    if (object is MediaModel){
      return fromMediaModel(mediaModel: object);
    }

    /// X FILE
    else if (ObjectCheck.objectIsXFile(object) == true){
      return fromXFile(file: object);
    }

    /// FILE
    else if (ObjectCheck.objectIsFile(object) == true){
      return fromFile(file: object);
    }

    /// BYTES
    else if (ObjectCheck.objectIsUint8List(object) == true){
      return fromBytes(bytes: object, fileName: fileName);
    }

    /// URL
    else if (ObjectCheck.isAbsoluteURL(object) == true){
      return fromURL(url: object, fileName: fileName);
    }

    /// LOCAL ASSET
    else if (ObjectCheck.objectIsJPGorPNG(object) == true || ObjectCheck.objectIsSVG(object) == true){
      return fromLocalAsset(localAsset: object);
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromLocalAsset({
    required String? localAsset,
  }) async {

    final XFile? _xFile = await XFiler.createFromLocalAsset(
        localAsset: localAsset,
    );

    return fromXFile(file: _xFile);
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromMediaModel({
    required MediaModel? mediaModel,
  }) async {
    return fromXFile(file: mediaModel?.file);
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromURL({
    required String? url,
    required String? fileName,
  }) async {

    final XFile? _xFile = await XFiler.createFromURL(
        url: url,
        fileName: fileName,
    );

    return fromXFile(file: _xFile);
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromBytes({
    required Uint8List? bytes,
    required String? fileName,
  }) async {

    final XFile? _xFile = await XFiler.createFromBytes(
        bytes: bytes,
        fileName: fileName
    );

    return fromXFile(file: _xFile);
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromFile({
    required File? file,
  }) async {
    XFile? _xFile;

    if (file != null){
      _xFile = XFile(file.path);
    }

    return fromXFile(file: _xFile);
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> fromXFile({
    required XFile? file,
  }) async {

    Dimensions? _output = await _getImageDimensions(
      xFile: file,
    );

    _output ??= await _getVideoDimensions(
        xFile: file,
      );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions?> _getImageDimensions({
    required XFile? xFile,
  }) async {
    Dimensions? _output;

    if (xFile != null){

      await tryAndCatch(
        invoker: 'getImageDimensions',
        functions: () async {

          final Uint8List bytes = await xFile.readAsBytes();

          final img.Decoder? _decoder = FileTyper.getImageDecoderFromBytes(
            bytes: bytes,
          );
          
          blog('decoder.runtimeType : ${_decoder?.runtimeType}');
          
          if (_decoder != null){
            
            final img.Image? _image = await Imager.getImgImageFromUint8List(bytes);
            final int? width = _image?.width;
            final int? height = _image?.height;

            if (width != null && height != null){
              _output = Dimensions(
                width: width.toDouble(),
                height: height.toDouble(),
              );
            }

          }
          
        },
      );
      
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// VIDEO

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<Dimensions?> _getVideoDimensions({
    required XFile? xFile,
  }) async {
    Dimensions? _output;

    if (xFile != null){

      /// '<file path or url>'
      final MediaInformationSession session = await FFprobeKit.getMediaInformation(xFile.path);
      final MediaInformation? information = session.getMediaInformation();

      // await VideoOps.blogMediaInformationSession(session: session);

      if (information == null) {
        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        // final state = FFmpegKitConfig.sessionStateToString(await session.getState());
        // final returnCode = await session.getReturnCode();
        // final failStackTrace = await session.getFailStackTrace();
        // final duration = await session.getDuration();
        // final output = await session.getOutput();
      }

      else {
        final Map<dynamic, dynamic>? _maw = information.getAllProperties();
        final Map<String, dynamic> _map = Mapper.convertDynamicMap(_maw);
        final List<Object?> _objects = _map['streams'];
        final List<Map<String, dynamic>> _maps = Mapper.getMapsFromDynamics(dynamics: _objects);

        if( Lister.checkCanLoop(_maps) == true){
          final Map<String, dynamic>? _data = _maps.first;
          final int? height = _data?['height'];
          final int? _width = _data?['width'];
          _output = Dimensions(width: _width?.toDouble(), height: height?.toDouble());
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
