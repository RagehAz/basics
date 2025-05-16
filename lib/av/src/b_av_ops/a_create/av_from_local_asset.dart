part of av;
/// => GREAT
class _AvFromLocalAsset {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createSingle({
    required String? localAsset,
    required CreateSingleAVConstructor data,
  }) async {
    AvModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      _output = await _AvFromBytes.createSingle(
        bytes: _bytes,
        data: data.copyWith(
          origin: data.origin ?? AvOrigin.generated,
          originalXFilePath: data.originalXFilePath ?? localAsset,
        ),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createMany({
    required List<String> localAssets,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      await Lister.loop(
        models: localAssets,
        onLoop: (int i, String? asset) async {

          if (asset != null){

            final AvModel? _pic = await createSingle(
              localAsset: asset,
              data: CreateSingleAVConstructor(
                uploadPath: FileNaming.getNameFromLocalAsset(asset)!,
                skipMeta: data.skipMeta,
                bobDocName: data.bobDocName,
                ownersIDs: data.ownersIDs,
                origin: data.origin,
                caption: data.captionGenerator?.call(i, asset),
                // originalURL: ,
                // durationMs: ,
              ),

            );

            if (_pic != null){
              _output.add(_pic);
            }
          }

        },
      );


    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
