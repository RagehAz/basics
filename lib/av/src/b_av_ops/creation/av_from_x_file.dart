part of av;

class AvFromXFile {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  ///
  static Future<AvModel?> createSingle({
    required XFile? xFile,
    required String uploadPath,
    required bool skipMeta,
    required String bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    AvModel? _output;

    if (xFile != null){

      Uint8List? _bytes = await Byter.fromXFile(xFile, 'createSingle');

      if (_bytes != null){

        _bytes = await _fixFileIfHeic(
          bytes: _bytes,
          xFile: xFile,
        );

        return AvFromBytes.create(
          bytes: _bytes,
          origin: origin ?? AvOrigin.downloaded,
          uploadPath: uploadPath,
          ownersIDs: ownersIDs,
          caption: caption,
          includeFileExtension: includeFileExtension,
          skipMeta: skipMeta,
          // originalURL: null,
          bobDocName: bobDocName,
          // durationMs: durationMs,
        );

      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<Uint8List?> _fixFileIfHeic({
    required Uint8List? bytes,
    required XFile? xFile,
  }) async {
    Uint8List? _output = bytes;

    if (_output != null){

      /// IF_PIC_IS_HEIC_TRANSFORM_INTO_JPEG
      final FileExtType? _type = FileMiming.getTypeByMime(xFile?.mimeType);

      /// HEIC OR HEIF
      if (_type == FileExtType.heic || _type == FileExtType.heif){

        // blog('_fixFileIfHeic : the file is heic or heif');

        await tryAndCatch(
          invoker: '_fixFileIfHeic',
          functions: () async {

            final Dimensions? _dims = await DimensionsGetter.fromXFile(xFile: xFile, invoker: '_fixFileIfHeic');

            if (_dims != null && _dims.width != null && _dims.height != null){
              _output = await FlutterImageCompress.compressWithList(
                _output!,
                minWidth: _dims.width!.toInt(),
                minHeight: _dims.height!.toInt(),
                quality: 100,
                // format: CompressFormat.jpeg,
                // rotate: 0,
                // autoCorrectionAngle: false,
                // inSampleSize: ,
                // keepExif: true,
              );
            }

          },
          onError: (String error) async {
            blog(error);
            // _output = await FlutterImageCompress.compressWithList(
            //   bytes,
            //   minWidth: compressToWidth.toInt(),
            //   minHeight: _compressToHeight.toInt(),
            //   quality: quality,
            //   // autoCorrectionAngle: ,
            //   // format: ,
            //   // inSampleSize: ,
            //   // keepExif: ,
            //   // rotate: ,
            // );
          },
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  ///
  static Future<List<AvModel>> createMany({
    required List<XFile>? files,
    required String Function(int index, String? path) uploadPathGenerator,
    required bool skipMeta,
    required String bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(files) == true){

      await Lister.loop(
        models: files,
        onLoop: (int i, XFile? file) async {

          if (file != null){

            final AvModel? _model = await createSingle(
              xFile: file,
              origin: origin,
              uploadPath: uploadPathGenerator.call(i, file.path),
              ownersIDs: ownersIDs,
              includeFileExtension: includeFileExtension,
              skipMeta: skipMeta,
              bobDocName: bobDocName,
              // caption: null,
            );

            if (_model != null){
              _output.add(_model);
            }

          }

        },
      );

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
