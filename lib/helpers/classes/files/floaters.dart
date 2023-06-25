// ignore_for_file: unnecessary_import
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/rest/rest.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as img;
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:flutter/services.dart';

class Floaters {
  // -----------------------------------------------------------------------------

  const Floaters();

  // -----------------------------------------------------------------------------

  /// ByteData

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData?> getByteDataFromUiImage(ui.Image? uiImage) async {
    ByteData? _byteData;

    if (uiImage != null){
      _byteData = await uiImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
    }

    return _byteData;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<ByteData?> getByteDataFromPath(String? assetPath) async {
    /// NOTE : Asset path can be local path or url
    ByteData? _byteData;

    if (TextCheck.isEmpty(assetPath) == false){
      _byteData = await rootBundle.load(assetPath!);
    }

    return _byteData;
  }
  // -----------------------------------------------------------------------------

  /// ui.Image

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ui.Image?> getUiImageFromUint8List(Uint8List? uInt) async {
    ui.Image? _decodedImage;

    if (uInt != null) {
      await tryAndCatch(
        invoker: 'getUiImageFromUint8List',
        functions: () async {
          _decodedImage = await decodeImageFromList(uInt);
          },
      );
    }

    return _decodedImage;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<ui.Image?> getUiImageFromInts(List<int>? ints) async {


    if (Mapper.checkCanLoopList(ints) == true){
      final Completer<ui.Image> completer = Completer<ui.Image>();
      final Uint8List _uint8List = Uint8List.fromList(ints!);
      ui.decodeImageFromList(_uint8List, completer.complete);
      return completer.future;
    }
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUiImagesAreIdentical(ui.Image? image1, ui.Image? image2){
    bool _identical = false;

    if (image1 == null && image2 == null){
      _identical = true;
    }
    else if (image1 != null && image2 != null){

      if (
              image1.width == image2.width &&
              image1.height == image2.height &&
              image1.isCloneOf(image2) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// img.Image

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image?> getImgImageFromFile(File? file) async {
    img.Image? _image;

    if (file != null){
      final Uint8List? uint = await Floaters.getUint8ListFromFile(file);
      _image = await Floaters.getImgImageFromUint8List(uint);
    }

    return _image;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image?> getImgImageFromUint8List(Uint8List? uInt) async {
    img.Image? imgImage;

    if (uInt != null){
      imgImage = img.decodeImage(uInt);
    }

    return imgImage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static img.Image? resizeImgImage({
    required img.Image? imgImage,
    required int width,
    required int height,
  }) {
    img.Image? _output;

    if (imgImage != null){
      _output = img.copyResize(imgImage,
        width: width,
        height: height,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  /*
static img.Image decodeToImgImage({
  required List<int> bytes,
  required PicFormat picFormat,
}){

    switch (picFormat){
      case PicFormat.image : return img.decodeImage(bytes); break;
      case PicFormat.jpg : return img.decodeJpg(bytes); break;
      case PicFormat.png : return img.decodePng(bytes); break;
      case PicFormat.tga : return img.decodeTga(bytes); break;
      case PicFormat.webP : return img.decodeWebP(bytes); break;
      case PicFormat.gif : return img.decodeGif(bytes); break;
      case PicFormat.tiff : return img.decodeTiff(bytes); break;
      case PicFormat.psd : return img.decodePsd(bytes); break;
      case PicFormat.exr : return img.decodeExr(bytes); break;
      case PicFormat.bmp : return img.decodeBmp(bytes); break;
      case PicFormat.ico : return img.decodeIco(bytes); break;
      // case PicFormat.animation : return img.decodeAnimation(bytes); break;
      // case PicFormat.pngAnimation : return img.decodePngAnimation(bytes); break;
      // case PicFormat.webPAnimation : return img.decodeWebPAnimation(bytes); break;
      // case PicFormat.gifAnimation : return img.decodeGifAnimation(bytes); break;
      default: return null;
    }

}
   */
  // --------------------
  /*
  enum PicFormat {
  image,

  jpg,
  png,
  tga,
  webP,
  gif,
  tiff,
  psd,
  bmp,
  ico,

  exr,

  animation,
  pngAnimation,
  webPAnimation,
  gifAnimation,

// svg,
}
*/
  // -----------------------------------------------------------------------------

  /// uInt8List

  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? getUint8ListFromByteData(ByteData? byteData) {

    if (byteData == null){
      return null;
    }

    else {

      /// METHOD 1 : WORKS PERFECT
      // final Uint8List _uInts = byteData.buffer.asUint8List(
      //   byteData.offsetInBytes,
      //   byteData.lengthInBytes,
      // );

      /// METHOD 2 : WORKS PERFECT
      // final Uint8List _uInts = Uint8List.view(byteData.buffer);

      return byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> getUint8ListFromFile(File? file) async {
    Uint8List? _uInt;

    if (file != null){
    _uInt = await file.readAsBytes();
    }

    return _uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> getUint8ListsFromFiles(List<File>? files) async {
    final List<Uint8List> _screenShots = <Uint8List>[];

    if (kIsWeb == false && Mapper.checkCanLoopList(files) == true) {
      for (final File file in files!) {
        final Uint8List? _uInt = await getUint8ListFromFile(file);
        if (_uInt != null){
          _screenShots.add(_uInt);
        }
      }
    }

    return _screenShots;
  }
  // --------------------
  static Future<Uint8List?> getUint8ListFromRasterURL({
    required int? width,
    required int? height,
    required String? urlAsset,
  }) async {

    Uint8List? _output;

    if (width != null && height != null && urlAsset != null){

      final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
      final Canvas _canvas = Canvas(_pictureRecorder);
      final Paint _paint = Paint()..color = Colors.transparent;
      const Radius _radius = Radius.circular(20);

      _canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
            topLeft: _radius,
            topRight: _radius,
            bottomLeft: _radius,
            bottomRight: _radius,
          ),
          _paint);

      final ByteData? _byteData = await getByteDataFromPath(urlAsset);

      if (_byteData != null){

        final ui.Image? _imaged = await getUiImageFromInts(Uint8List.view(_byteData.buffer));

        if (_imaged != null){
          _canvas.drawImage(_imaged, Offset.zero, Paint());
          final ui.Image _img = await _pictureRecorder.endRecording().toImage(width, height);
          final ByteData? _data = await _img.toByteData(format: ui.ImageByteFormat.png);
          _output = _data?.buffer.asUint8List();
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> getUint8ListFromUiImage(ui.Image? uiImage) async {
    Uint8List? uInt;

    if (uiImage != null){

      final ByteData? _byteData = await getByteDataFromUiImage(uiImage);

      if (_byteData != null){
        uInt = Floaters.getUint8ListFromByteData(_byteData);
      }

    }

    return uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? getUint8ListFromImgImage(img.Image? imgImage) {
    Uint8List? uInt;

    if (imgImage != null){
      uInt = img.encodeJpg(imgImage,
        // quality: 100, // default
      );
    }

    return uInt;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Uint8List?> getUint8ListFromImgImageAsync(img.Image? imgImage) async{
    Uint8List? uInt;
    if (imgImage != null){
      uInt = getUint8ListFromImgImage(imgImage);
    }
    return uInt;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Uint8List?> getUint8ListFromURL(String? url) async {
    Uint8List? _uints;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      _uints = await Rest.readBytes(
        rawLink: url!.trim(),
        invoker: 'getUint8ListFromURL',
      );

    }

    return _uints;
  }
  // -----------------------------------------------------------------------------

  /// Base64

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getBase64FromFileOrURL(dynamic image) async {

    /// IS URL
    if (ObjectCheck.isAbsoluteURL(image) == true) {
      final Uint8List? _uints = await getUint8ListFromURL(image);
      if (_uints == null) {
        return null;
      }
      else {
        return base64Encode(_uints);
      }
    }

    /// IS FILE + IS NOT WEB
    else if (kIsWeb == false && ObjectCheck.objectIsFile(image) == true) {
      final File? _file = image;

      if (_file == null) {
        return null;
      }
      else {
        final List<int> imageBytes = _file.readAsBytesSync();
        return base64Encode(imageBytes);
      }
    }

    /// IF FILE OR OTHER OR IS ON WEB AND NOT URL
    else {
      return null;
    }

  }
  // --------------------
  /// TASK : TEST ME
  static String? getBase64FromUint8List(Uint8List? bytes){
    String? _output;
    if (Mapper.checkCanLoopList(bytes) == true){
      _output = base64Encode(bytes!);
    }
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BitmapDescriptor

  // --------------------
  /// TASK : TEST ME
  /*
  static Future<BitmapDescriptor> getBitmapFromSVG({
    required BuildContext context,
    required String assetName,
  }) async {
    // Read SVG file as String
    final String svgString =
    await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    final MediaQueryData queryData = MediaQuery.of(context);
    final double devicePixelRatio = queryData.devicePixelRatio;
    final double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    final double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    final ui.Picture picture =
    svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
   */
  // --------------------
  /// TASK : TEST ME
  /*
  static Future<BitmapDescriptor> getBitmapFromPNG({
    String pngPic = Iconz.flyerPinPNG,
  }) async {
    final BitmapDescriptor _marker =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, pngPic);
    return _marker;
  }
   */
  // -----------------------------------------------------------------------------

  /// INTs : List<int>

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int>? getIntsFromUint8List(Uint8List? uInt){
    List<int>? _ints;

    if (uInt != null){
      _ints = uInt.toList();
    }

    return _ints;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? getBytesFromInts(List<dynamic>? ints){
    Uint8List? _bytes;

    if (ints != null){
      _bytes = Uint8List.fromList(ints.cast<int>());
    }

    return _bytes;
  }
  // --------------------
  /// TASK : TEST ME
  static List<int> getIntsFromDynamics(List<dynamic>? ints){
    final List<int> _ints = <int>[];

    if (ints != null){
      // _ints.addAll(_ints);

      for (int i = 0; i < ints.length; i++){
        _ints.add(ints[0]);
      }

    }



    return _ints;
  }
  // -----------------------------------------------------------------------------

  /// DOUBLEs : List<double>

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double> getDoublesFromDynamics(List<dynamic>? dynamics){

    final List<double> _output = <double>[];

    if (Mapper.checkCanLoopList(dynamics) == true){

      for (final dynamic dyn in dynamics!){

        if (dyn is double){
          final double _double = dyn;
          _output.add(_double);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// LOCAL ASSETS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLocalAssetName(String? assetPath){
    final String? _pathTrimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
      string: assetPath,
      numberOfCharacters: 7,
    );
    return TextMod.getFileNameFromAsset(_pathTrimmed);
  }
  // --------------------
  /// TESTED : WORKS PERFECT :
  static List<double> standardImageFilterMatrix = <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> getUint8ListFromLocalSVGAsset(String? asset) async {
    Uint8List? _output;

    if (TextCheck.isEmpty(asset) == false){

      // final String? _fileName = getLocalAssetName(asset);
      final ByteData? byteData = await Floaters.getByteDataFromPath(asset);
      final Uint8List? _raw = Floaters.getUint8ListFromByteData(byteData);

      if (_raw != null){

        final PictureInfo _info = await vg.loadPicture(
          SvgBytesLoader(
            _raw,
            // colorMapper: ,
            // theme: SvgTheme(
            //   currentColor: ,
            //   fontSize: ,
            //   xHeight: ,
            // ),
          ),
          null,
          // onError: ,
          // clipViewbox: ,
        );

        // final PictureInfo? _info = await svg.svgPictureDecoder(
      //   _raw, // Uint8List raw
      //   true, // allowDrawingOutsideOfViewBox
      //   ColorFilter.matrix(standardImageFilterMatrix), // colorFilter
      //   _fileName, // key
      //   // theme: const SvgTheme(),
      // );

        // Imagers.blogPictureInfo(_info);

        final double _width = _info.size.width;
        final double _height = _info.size.height;
        final ui.Image _image = await _info.picture.toImage(_width.toInt(), _height.toInt());

        _output = await Floaters.getUint8ListFromUiImage(_image);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> getUint8ListFromLocalRasterAsset({
    required String? asset,
    required int? width
  }) async {
    Uint8List? _output;

    if (asset != null && width != null) {

      final ByteData? _byteData = await getByteDataFromPath(asset);

      if (_byteData != null) {

        final ui.Codec _codec = await ui.instantiateImageCodec(
          _byteData.buffer.asUint8List(),
          targetWidth: width,
        );

        final ui.FrameInfo _fi = await _codec.getNextFrame();

        final ByteData? _bytes = await _fi.image.toByteData(format: ui.ImageByteFormat.png);

        if (_bytes != null) {
          _output = _bytes.buffer.asUint8List();
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GET BYTES

  // --------------------
  /// TASK : TEST ME
  static Future<List<Uint8List>?> getBytezzFromLocalRasterImages({
    required List<String>? localAssets,
    int width = 100,
  }) async {
    final List<Uint8List> _outputs = <Uint8List>[];

    if (Mapper.checkCanLoopList(localAssets) == true){

      await Future.wait(<Future>[

        ...List.generate(localAssets!.length, (index){

          return getBytesFromLocalRasterAsset(
            localAsset: localAssets[index],
            width: width,
          ).then((Uint8List? output){

            if (output != null){
              _outputs.add(output);
            }

          });

        }),

      ]);

    }

    return _outputs;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Uint8List?> getBytesFromLocalRasterAsset({
    required String? localAsset,
    int width = 100,
  }) async {
    Uint8List? _bytes;

    if (localAsset != null) {
      await tryAndCatch(
          invoker: 'getBytesFromLocalRasterAsset',
          functions: () async {
            /// IF SVG
            if (ObjectCheck.objectIsSVG(localAsset) == true) {
              _bytes = await Floaters.getUint8ListFromLocalSVGAsset(localAsset);
            }

            /// ANYTHING ELSE
            else {
              _bytes = await Floaters.getUint8ListFromLocalRasterAsset(
                asset: localAsset,
                width: width,
              );
            }

            // /// ASSIGN UINT TO FILE
            // if (Mapper.checkCanLoopList(_uInt) == true){
            //   _bytes = await getFileFromUint8List(
            //     uInt8List: _uInt,
            //     fileName: Floaters.getLocalAssetName(localAsset),
            //   );
            // }
          });
    }

    return _bytes;
  }
  // -----------------------------------------------------------------------------
}

void blogExif(img.ExifData? exif){

  if (exif == null){
    blog('exif is null');
  }

  else {

    exif.exifIfd.data.forEach((key, value){
      blog('$key : $value');
    });
    exif.gpsIfd.data.forEach((key, value){
      blog('$key : $value');
    });
    exif.imageIfd.data.forEach((key, value){
      blog('$key : $value');
    });
    exif.interopIfd.data.forEach((key, value){
      blog('$key : $value');
    });
    exif.thumbnailIfd.data.forEach((key, value){
      blog('$key : $value');
    });

    blog('exif.directories :  ${exif.directories.runtimeType} : ${exif.directories}');
    blog('exif.isEmpty :      ${exif.isEmpty.runtimeType}     : ${exif.isEmpty}');
    blog('exif.keys :         ${exif.keys.runtimeType}        : ${exif.keys}');
    blog('exif.values :       ${exif.values.runtimeType}      : ${exif.values}');

  }

}
