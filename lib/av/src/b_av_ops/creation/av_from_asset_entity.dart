part of av;

class AvFromAssetEntity {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  ///
  static Future<AvModel?> createSingle({
    required AssetEntity? entity,
    required String uploadPath,
    required bool skipMeta,
    required String bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    AvModel? _output;

    if (entity != null){

      final File? _file = await entity.originFile;
      Uint8List? _bytes = await Byter.fromFile(_file);

      if (_bytes != null){

        _bytes = await _fixFileIfHeic(
          bytes: _bytes,
          entity: entity,
        );

        return AvFromBytes.create(
          bytes: _bytes,
          origin: origin ?? AvOrigin.downloaded,
          uploadPath: uploadPath,
          ownersIDs: ownersIDs,
          caption: caption,
          includeFileExtension: includeFileExtension,
          skipMeta: skipMeta,
          originalURL: await Entities.getAssetEntityURL(entity),
          bobDocName: bobDocName,
          // durationMs: durationMs,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _fixFileIfHeic({
    required Uint8List? bytes,
    required AssetEntity entity,
  }) async {
    Uint8List? _output = bytes;

    if (_output != null){

      /// IF_PIC_IS_HEIC_TRANSFORM_INTO_JPEG
      final FileExtType? _type = FileMiming.getTypeByMime(entity.mimeType);

      /// HEIC OR HEIF
      if (_type == FileExtType.heic || _type == FileExtType.heif){

        // blog('_fixFileIfHeic : the file is heic or heif');

        await tryAndCatch(
          invoker: '_fixFileIfHeic',
          functions: () async {

            _output = await FlutterImageCompress.compressWithList(
              _output!,
              minWidth: entity.width,
              minHeight: entity.height,
              quality: 100,
              // format: CompressFormat.jpeg,
              // rotate: 0,
              // autoCorrectionAngle: false,
              // inSampleSize: ,
              // keepExif: true,
            );

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
    required List<AssetEntity>? entities,
    required String Function(int index, String? title) uploadPathGenerator,
    required bool skipMeta,
    required String bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(entities) == true){

      await Lister.loop(
        models: entities,
        onLoop: (int i, AssetEntity? entity) async {

          if (entity != null){

            final AvModel? _model = await createSingle(
              entity: entity,
              origin: origin,
              uploadPath: uploadPathGenerator.call(i, entity.title),
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
