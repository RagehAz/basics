part of av;

class AvFromUrl {
  // --------------------------------------------------------------------------

  /// ONE

  // --------------------
  ///
  static Future<AvModel?> createOne({
    required String? url,
    required String uploadPath,
    required bool skipMeta,
    required String bobDocName,
    List<String>? ownersIDs,
    AvOrigin? origin,
    String? caption,
    bool includeFileExtension = false,
  }) async {

    final Uint8List? _bytes = await Byter.fromURL(url);

    if (_bytes == null){
      return null;
    }
    else {

      return AvFromBytes.create(
        bytes: _bytes,
        origin: origin ?? AvOrigin.downloaded,
        uploadPath: uploadPath,
        ownersIDs: ownersIDs,
        caption: caption,
        includeFileExtension: includeFileExtension,
        skipMeta: skipMeta,
        originalURL: url,
        bobDocName: bobDocName,
        // durationMs: durationMs,
      );

    }

  }
  // --------------------------------------------------------------------------

  /// ONE

  // --------------------
  ///
  static Future<List<AvModel>> fromURLs({
    required List<String>? urls,
    required String Function(int index) uploadPathGenerator,
    required bool skipMeta,
    required String bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    bool includeFileExtension = false,
    List<String>? captions,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(urls) == true){

      await Lister.loop(
          models: urls,
          onLoop: (int index, String? url) async {

            final String? _url = url;

            final AvModel? _model = await createOne(
              url: _url,
              origin: origin,
              uploadPath: uploadPathGenerator.call(index),
              ownersIDs: ownersIDs,
              includeFileExtension: includeFileExtension,
              caption: captions?[index],
              skipMeta: skipMeta,
              bobDocName: bobDocName,
            );

            if (_model != null){
              _output.add(_model);
            }

          },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
