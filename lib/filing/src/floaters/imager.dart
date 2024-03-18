part of filing;

class Imager{
  // -----------------------------------------------------------------------------

  const Imager();

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
          onError: (String error){
            // final Uint8List? _bytes = uInt;
            // final int? _length = _bytes?.length;
            // final String? _type = _bytes?.runtimeType.toString();
            // blog('getUiImageFromUint8List : ERROR : type : $_type : $_length');
          }
      );
    }

    return _decodedImage;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<ui.Image?> getUiImageFromXFile(XFile? file) async {
    ui.Image? _output;

    if (file != null) {
      final Uint8List? _bytes = await Byter.fromXFile(file);
      _output = await getUiImageFromUint8List(_bytes);
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<ui.Image?> getUiImageFromInts(List<int>? ints) async {
    ui.Image? _output;

    if (Lister.checkCanLoop(ints) == true){

      await tryAndCatch(
        invoker: 'Imager.getUiImageFromInts',
        functions: () async {
          final Completer<ui.Image> completer = Completer<ui.Image>();
          final Uint8List _uint8List = Uint8List.fromList(ints!);
          ui.decodeImageFromList(_uint8List, completer.complete);
          _output = await completer.future;

          },
      );


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ui.Image CHECKER

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

      final Uint8List? uint = await Byter.fromFile(file);

      _image = await getImgImageFromUint8List(uint);

    }

    return _image;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image?> getImgImageFromUint8List(Uint8List? uInt) async {
    img.Image? imgImage;

    if (uInt != null){
      await tryAndCatch(
          invoker: 'Imager.getImgImageFromUint8List',
          functions: () async {
            imgImage = img.decodeImage(uInt);
          }
          );
    }

    return imgImage;
  }
  // -----------------------------------------------------------------------------

  /// img.Image RESIZING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image?> resizeImgImage({
    required img.Image? imgImage,
    required int width,
    required int height,
  }) async {
    img.Image? _output;

    if (imgImage != null){

      await tryAndCatch(
        invoker: 'Imager.resizeImgImage',
        functions: () async {

          _output = img.copyResize(imgImage,
            width: width,
            height: height,
            // interpolation: Interpolation.cubic,
          );

          },
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  static void blogExif(img.ExifData? exif){

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
  // -----------------------------------------------------------------------------

  /// BitmapDescriptor

  // --------------------
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
}
