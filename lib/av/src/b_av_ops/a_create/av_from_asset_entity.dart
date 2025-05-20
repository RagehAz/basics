part of av;
/// => GREAT
class _AvFromAssetEntity {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createSingle({
    required AssetEntity? entity,
    required CreateSingleAVConstructor data,
  }) async {
    AvModel? _output;

    if (entity != null){

      final File? _file = await entity.originFile;
      final Uint8List? _bytes = await Byter.fromFile(_file);

      if (_bytes != null){

        return _AvFromBytes.createSingle(
          bytes: _bytes,
          data: data.copyWith(
            fileExt: data.fileExt ?? FileMiming.getTypeByMime(entity.mimeType),
            width: data.width ?? entity.width.toDouble(),
            height: data.height ?? entity.height.toDouble(),
            durationMs: data.durationMs ?? _getDurationMsFromAssetEntity(entity),
            caption: data.caption ?? entity.title,
            originalXFilePath: data.originalXFilePath ?? entity.relativePath,
          ),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? _getDurationMsFromAssetEntity(AssetEntity entity){
    int? _output;

    if (entity.type == AssetType.video){
      _output = entity.videoDuration.inMilliseconds;
    }
    else if (entity.type == AssetType.audio){
      _output = entity.duration;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createMany({
    required List<AssetEntity>? entities,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(entities) == true){

      await Lister.loop(
        models: entities,
        onLoop: (int i, AssetEntity? entity) async {

          if (entity != null){

            final AvModel? _model = await createSingle(
              entity: entity,
              data: CreateSingleAVConstructor(
                origin: data.origin,
                uploadPath: data.uploadPathGenerator.call(i, entity.relativePath),
                ownersIDs: data.ownersIDs,
                skipMeta: data.skipMeta,
                bobDocName: data.bobDocName,
                caption: data.captionGenerator?.call(i, entity.relativePath),
                fileExt: FileMiming.getTypeByMime(entity.mimeType),
                // durationMs: ,
                // originalURL: ,
              ),

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
