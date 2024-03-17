part of filing;

class Byter {
  // -----------------------------------------------------------------------------

  const Byter();

  // -----------------------------------------------------------------------------

  /// Uint8List

  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromByteData(ByteData? byteData) {

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
  static Future<Uint8List?> fromFile(File? file) async {
    Uint8List? _uInt;

    if (file != null){
      _uInt = await file.readAsBytes();
    }

    return _uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> fromFiles(List<File>? files) async {
    final List<Uint8List> _screenShots = <Uint8List>[];

    if (kIsWeb == false && Lister.checkCanLoop(files) == true) {
      for (final File file in files!) {
        final Uint8List? _uInt = await fromFile(file);
        if (_uInt != null){
          _screenShots.add(_uInt);
        }
      }
    }

    return _screenShots;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromUiImage(ui.Image? uiImage) async {
    Uint8List? uInt;

    if (uiImage != null){

      final ByteData? _byteData = await byteDataFromUiImage(uiImage);

      if (_byteData != null){
        uInt = fromByteData(_byteData);
      }

    }

    return uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromImgImage(img.Image? imgImage) {
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
  static Future<Uint8List?> fromImgImageAsync(img.Image? imgImage) async {
    Uint8List? uInt;
    if (imgImage != null){
      uInt = fromImgImage(imgImage);
    }
    return uInt;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Uint8List?> fromRasterURL({
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

      final ByteData? _byteData = await byteDataFromPath(urlAsset);

      if (_byteData != null){

        final ui.Image? _imaged = await Imager.getUiImageFromInts(Uint8List.view(_byteData.buffer));

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
  static Future<Uint8List?> fromURL(String? url) async {
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

  /// GET BYTES FROM LOCAL ASSETS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>?> fromLocalAssets({
    required List<String>? localAssets,
  }) async {
    final List<Uint8List> _outputs = <Uint8List>[];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets!){

        final Uint8List? _bytes = await fromLocalAsset(
          localAsset: asset,
        );

        if (_bytes != null){
          _outputs.add(_bytes);
        }

      }

    }

    return _outputs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromLocalAsset({
    required String? localAsset,
  }) async {
    Uint8List? _bytes;

    if (localAsset != null) {
      await tryAndCatch(
          invoker: 'getBytesFromLocalRasterAsset',
          functions: () async {

            /// IF SVG
            if (ObjectCheck.objectIsSVG(localAsset) == true) {
              _bytes = await Byter._fromLocalSVGAsset(localAsset);
            }

            /// ANYTHING ELSE
            else {
              _bytes = await Byter._fromLocalRasterAsset(
                asset: localAsset,
              );
            }

            // /// ASSIGN UINT TO FILE
            // if (Lister.checkCanLoopList(_uInt) == true){
            //   _bytes = await getFileFromUint8List(
            //     uInt8List: _uInt,
            //     fileName: Floaters.getLocalAssetName(localAsset),
            //   );
            // }
          });
    }

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _fromLocalSVGAsset(String? asset) async {
    Uint8List? _output;

    if (TextCheck.isEmpty(asset) == false){

      // final String? _fileName = getLocalAssetName(asset);
      final ByteData? byteData = await Byter.byteDataFromPath(asset);
      final Uint8List? _raw = Byter.fromByteData(byteData);

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

        _output = await Byter.fromUiImage(_image);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _fromLocalRasterAsset({
    required String? asset,
    // required int? width
  }) async {
    Uint8List? _output;

    if (asset != null) {

      final ByteData? _byteData = await byteDataFromPath(asset);

      _output = _byteData?.buffer.asUint8List();

      // if (_byteData != null) {
      //
      //   final ui.Codec _codec = await ui.instantiateImageCodec(
      //     _byteData.buffer.asUint8List(),
      //     targetWidth: width,
      //   );
      //
      //   final ui.FrameInfo _fi = await _codec.getNextFrame();
      //
      //   final ByteData? _bytes = await _fi.image.toByteData(format: ui.ImageByteFormat.png);
      //
      //   if (_bytes != null) {
      //     _output = _bytes.buffer.asUint8List();
      //   }
      //
      // }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ByteData

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData?> byteDataFromUiImage(ui.Image? uiImage) async {
    ByteData? _byteData;

    if (uiImage != null){
      _byteData = await uiImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
    }

    return _byteData;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData?> byteDataFromPath(String? localAsset) async {
    /// NOTE : Asset path can be local path or url
    ByteData? _byteData;

    if (TextCheck.isEmpty(localAsset) == false){
      _byteData = await rootBundle.load(localAsset!);
    }

    return _byteData;
  }
  // -----------------------------------------------------------------------------

  /// INTs : List<int>

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int>? intsFromBytes(Uint8List? uInt){
    List<int>? _ints;

    if (uInt != null){
      _ints = uInt.toList();
    }

    return _ints;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromInts(List<dynamic>? ints){
    Uint8List? _bytes;

    if (ints != null){
      _bytes = Uint8List.fromList(ints.cast<int>());
    }

    return _bytes;
  }
  // -----------------------------------------------------------------------------

  /// MODIFY BYTES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> resize({
    required Uint8List? bytes,
    required String? fileName,
    required double? resizeToWidth,
  }) async {
    Uint8List? _output = bytes;

    if (bytes != null && resizeToWidth != null){

      final Dimensions? _dims = await DimensionsGetter.fromBytes(
        bytes: bytes,
        fileName: fileName,
      );

      if (Numeric.isLesserThan(number: resizeToWidth, isLesserThan: _dims?.width) == true){

        final double? _aspectRatio = _dims?.getAspectRatio();
        final double? _resizeToHeight = Dimensions.getHeightByAspectRatio(
          aspectRatio: _aspectRatio,
          width: resizeToWidth,
        );

        final img.Image? _img = img.decodeImage(bytes);

        if (_img != null && _resizeToHeight != null){

          final img.Image resizedImage = img.copyResize(
            _img,
            width: resizeToWidth.toInt(),
            height: _resizeToHeight.toInt(),
          );

          _output = img.encodeJpg(resizedImage);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST_ME_NOW
  static bool checkBytesAreIdentical({
    required Uint8List? bytes1,
    required Uint8List? bytes2,
  }){
    bool _identical = false;

    if (bytes1 == null && bytes2 == null){
      _identical = true;
    }
    else if (bytes1 != null && bytes2 != null){

      _identical = Lister.checkListsAreIdentical(
        list1: bytes1,
        list2: bytes2,
      );

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// BASE 64

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> base64FromFileOrURL(dynamic image) async {

    /// IS URL
    if (ObjectCheck.isAbsoluteURL(image) == true) {
      final Uint8List? _uints = await fromURL(image);
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
  static String? base64FromBytes(Uint8List? bytes){
    String? _output;
    if (Lister.checkCanLoop(bytes) == true){
      _output = base64Encode(bytes!);
    }
    return _output;
  }
  // -----------------------------------------------------------------------------
}
