import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
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

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  double? getAspectRatio(){
    double? _output;

    if (width != null && height != null){
      /// ASPECT RATIO IS WITH / HEIGHT
      _output = width! / height!;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<double?> getPicAspectRatio(Uint8List? bytes) async {
    double? _output;

    if (bytes != null){

      final Dimensions? _dimensions = await superDimensions(bytes);

      if (_dimensions != null){

        _output = _dimensions.getAspectRatio();

      }

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
  static Future<Dimensions?> superDimensions(dynamic image) async {
    Dimensions? _dimensions;

    if (image != null) {
      // -----------------------------------------------------------o
      final bool _isURL = ObjectCheck.isAbsoluteURL(image) == true;
      // blog('_isURL : $_isURL');
      // final bool _isAsset = ObjectChecker.objectIsAsset(image) == true;
      // blog('_isAsset : $_isAsset');
      final bool _isFile = ObjectCheck.objectIsFile(image) == true;
      // blog('_isFile : $_isFile');
      final bool _isUints = ObjectCheck.objectIsUint8List(image) == true;
      // blog('_isUints : $_isUints');
      // -----------------------------------------------------------o
      ui.Image? _decodedImage;
      Uint8List? _uInt8List;
      // -----------------------------------------------------------o
      if (_isURL == true) {
        // final File _file = await Filers.getFileFromURL(image);
        _uInt8List = await Floaters.getBytesFromURL(image);
        // _uInt8List = _file.readAsBytesSync();
        // await null;
        blog('superDimensions : image : $image');
        _decodedImage = await Floaters.getUiImageFromUint8List(_uInt8List);
      }
      // --------------------------o
      /*
      else if (_isAsset == true) {
        final Asset _asset = image;
        final ByteData _byteData = await _asset.getByteData();
        _uInt8List = Imagers.getUint8ListFromByteData(_byteData);
        // await null;
        _dimensions = ImageSize.getImageSizeFromAsset(image);
      }
       */
      // --------------------------o
      else if (_isFile == true) {
        // blog('_isFile staring aho : $_isFile');
        _uInt8List = await Floaters.getBytesFromFile(image);
        // blog('_uInt8List : $_uInt8List');
        _decodedImage = await Floaters.getUiImageFromUint8List(_uInt8List);
        // blog('_decodedImage : $_decodedImage');
      }
      // --------------------------o
      else if (_isUints == true) {
        final Uint8List _bytes = image;
        _decodedImage = await Floaters.getUiImageFromUint8List(_bytes);
      }
      // -----------------------------------------------------------o
      if (_decodedImage != null) {
        _dimensions = Dimensions(
          width: _decodedImage.width.toDouble(),
          height: _decodedImage.height.toDouble(),
        );
      }
      // -----------------------------------------------------------o
      _decodedImage?.dispose();
    }

    return _dimensions;
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
