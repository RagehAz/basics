part of av;

class AvFromLocalAsset {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  ///
  static Future<AvModel?> createSingle({
    required String localAsset,
    required String uploadPath,
    required bool skipMeta,
    required String bobDocName,
    List<String>? ownersIDs,
    String? caption,
    bool includeFileExtension = false,
  }) async {
    AvModel? _output;

    if (TextCheck.isEmpty(localAsset) == false){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      _output = await AvFromBytes.create(
        origin: AvOrigin.generated,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        bytes: _bytes,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMeta: skipMeta,
        bobDocName: bobDocName,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  ///
  static Future<List<AvModel>> createMany({
    required List<String> localAssets,
    required bool skipMeta,
    required String bobDocName,
    bool includeFileExtension = false,
    AvOrigin? origin,
    List<String>? ownersIDs,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(localAssets) == true){

      for (final String asset in localAssets){

        final AvModel? _pic = await createSingle(
          localAsset: asset,
          uploadPath: FileNaming.getNameFromLocalAsset(asset)!,
          includeFileExtension: includeFileExtension,
          skipMeta: skipMeta,
          bobDocName: bobDocName,
          ownersIDs: ownersIDs,
          // caption: null,
        );

        if (_pic != null){
          _output.add(_pic);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
