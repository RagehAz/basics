part of av;
/// => GREAT
class _AvFromUrl {
  // --------------------------------------------------------------------------

  /// ONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createSingle({
    required String? url,
    required CreateSingleAVConstructor data,
  }) async {

    final Uint8List? _bytes = await Byter.fromURL(url);

    if (_bytes == null){
      return null;
    }
    else {

      return _AvFromBytes.createSingle(
        bytes: _bytes,
        data: data.copyWith(
          originalURL: url,
        ),
      );

    }

  }
  // --------------------------------------------------------------------------

  /// ONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createMany({
    required List<String>? urls,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(urls) == true){

      await Lister.loop(
          models: urls,
          onLoop: (int index, String? url) async {

            final String? _url = url;

            final AvModel? _model = await createSingle(
              url: _url,
              data: CreateSingleAVConstructor(
                origin: data.origin,
                uploadPath: data.uploadPathGenerator.call(index, null),
                ownersIDs: data.ownersIDs,
                caption: data.captionGenerator?.call(index, _url),
                skipMeta: data.skipMeta,
                bobDocName: data.bobDocName,
                originalURL: _url,
                // durationMs: ,
              ),
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
