part of filing;

class Byter {
  // -----------------------------------------------------------------------------

  const Byter();

  // -----------------------------------------------------------------------------

  /// Uint8List

  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromMediaModel(MediaModel? media){
    return media?.bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Uint8List> fromMediaModels(List<MediaModel> medias){
    final List<Uint8List> _output = [];

    if (Lister.checkCanLoop(medias) == true){
      for (final MediaModel pic in medias){
        if (pic.bytes != null){
          _output.add(pic.bytes!);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromByteData(ByteData? byteData) async {
    Uint8List? _output;

    if (byteData != null){

      await tryAndCatch(
        invoker: 'Byter.fromByteData',
         functions: () async {

           /// METHOD 1 : WORKS PERFECT
           // final Uint8List _uInts = byteData.buffer.asUint8List(
           //   byteData.offsetInBytes,
           //   byteData.lengthInBytes,
           // );

           /// METHOD 2 : WORKS PERFECT
           // final Uint8List _uInts = Uint8List.view(byteData.buffer);

           _output = byteData.buffer.asUint8List(
             byteData.offsetInBytes,
             byteData.lengthInBytes,
           );

         },
      );



    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromXFile(XFile? file, String invoker) async {
    Uint8List? _uInt;

    if (file != null){
      await tryAndCatch(
        invoker:  'Byter.fromXFile.$invoker',
        functions: () async {

          _uInt = await file.readAsBytes();

        },
      );
    }

    return _uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromFile(File? file) async {
    Uint8List? _uInt;

    if (file != null){
      await tryAndCatch(
        invoker:  'Byter.fromFile',
        functions: () async {

          _uInt = await file.readAsBytes();

          },
      );
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
  static Future<Uint8List?> fromSuperFile(SuperFile? file) async {
    Uint8List? _uInt;

    if (file != null){
      await tryAndCatch(
        invoker:  'Byter.fromSuperFile',
        functions: () async {

          _uInt = await file.readBytes();

        },
      );
    }

    return _uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromUiImage(ui.Image? uiImage) async {
    Uint8List? uInt;

    if (uiImage != null){

      final ByteData? _byteData = await byteDataFromUiImage(uiImage);

      if (_byteData != null){
        uInt = await fromByteData(_byteData);
      }

    }

    return uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromImgImage(img.Image? imgImage) {
    Uint8List? uInt;

    if (imgImage != null){

      tryAndCatch(
          invoker: 'Byter.fromImgImage',
          functions: () async {

            uInt = img.encodeJpg(imgImage,
              // quality: 100, // default
            );

          }
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
  /// DEPRECATED
  /*
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

      final ByteData? _byteData = await byteDataFromLocalAsset(
        pathOrURL: urlAsset,
      );

      if (_byteData != null){

        final Uint8List? _bytes = await fromByteData(_byteData);
        final ui.Image? _imaged = await Imager.getUiImageFromUint8List(_bytes);


        if (_imaged != null){
          _canvas.drawImage(_imaged, Offset.zero, Paint());
          final ui.Image _img = await _pictureRecorder.endRecording().toImage(width, height);
          _output = await fromUiImage(_img);

        }

      }

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> fromURL(String? url) async {
    Uint8List? _uints;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      _uints = await Rest.readBytes(
        rawLink: url!.trim(),
        invoker: 'Byter.fromURL',
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

      final ByteData? byteData = await Byter.byteDataFromLocalAsset(pathOrURL: asset);
      final Uint8List? _raw = await Byter.fromByteData(byteData);

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

      final ByteData? _byteData = await byteDataFromLocalAsset(
        pathOrURL: asset,
      );

      _output = await fromByteData(_byteData);

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
      await tryAndCatch(
        invoker: 'Byter.byteDataFromUiImage',
        functions: () async {

          _byteData = await uiImage.toByteData(
            format: ui.ImageByteFormat.png,
          );

        },
      );
    }

    return _byteData;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData?> byteDataFromLocalAsset({
    required String? pathOrURL,
  }) async {
    /// NOTE : Asset path can be local path or url
    ByteData? _byteData;

    if (TextCheck.isEmpty(pathOrURL) == false){
      await tryAndCatch(
        invoker: 'Byter.byteDataFromLocalAsset',
        functions: () async {

          _byteData = await rootBundle.load(pathOrURL!);

        },
      );
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
    Dimensions? fileDims,
  }) async {
    Uint8List? _output = bytes;

    if (bytes != null && resizeToWidth != null){

      final Dimensions? _dims = fileDims ?? await DimensionsGetter.fromBytes(
        invoker: 'resize',
        bytes: bytes,
        fileName: fileName,
      );

      final bool _canResize = Numeric.isLesserThan(
          number: resizeToWidth,
          isLesserThan: _dims?.width,
      );

      // blog('resize[$fileName] : from(${_dims?.width}) to($resizeToWidth) : canResize($_canResize)');

      if (_canResize == true){

        final double? _aspectRatio = _dims?.getAspectRatio();
        final double? _resizeToHeight = Dimensions.getHeightByAspectRatio(
          aspectRatio: _aspectRatio,
          width: resizeToWidth,
        );

        _output = await Isolate.run(() async {

          Uint8List? _bytes;

          await tryAndCatch(
            invoker: 'Byter.resize',
            functions: () async {

              final img.Image? _img = img.decodeImage(bytes);

              if (_img != null && _resizeToHeight != null){

                final img.Image resizedImage = img.copyResize(
                  _img,
                  width: resizeToWidth.toInt(),
                  height: _resizeToHeight.toInt(),
                );

                _bytes = img.encodeJpg(resizedImage);

              }

            },
          );

          return _bytes;
        });

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
        final Uint8List? _bytes = Filer.getReadAsBytesSync(_file);
        final List<int>? _ints = Byter.intsFromBytes(_bytes);
        return _ints == null ? null : base64Encode(_ints);
      }
    }

    /// IF FILE OR OTHER OR IS ON WEB AND NOT URL
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? base64FromBytes(Uint8List? bytes){
    String? _output;
    if (Lister.checkCanLoop(bytes) == true){
      tryAndCatch(
          invoker: 'base64FromBytes',
          functions: () async {
            _output = base64Encode(bytes!);
          },
      );

    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? fromBase64(String? base64){
    Uint8List? _output;
    if (base64 != null){
      tryAndCatch(
          invoker: 'bytesFromBase64',
          functions: () async {
            _output = base64Decode(base64);
          },
      );
    }
    return _output;
  }
  // -----------------------------------------------------------------------------
}
