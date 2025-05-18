part of av;
/// => GREAT
class _AvFromFile {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createSingle({
    required File? file,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromBytes.createSingle(
      bytes: await Byter.fromFile(file),
      data: data.copyWith(
        originalXFilePath: data.originalXFilePath ?? file?.path,
        fileExt: data.fileExt ?? FileExtensioning.getTypeByExtension(file?.extension),
      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createMany({
    required List<File>? files,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(files) == true){

      await Lister.loop(
        models: files,
        onLoop: (int i, File? file) async {

          if (file != null){

            final AvModel? _model = await createSingle(
              file: file,
              data: CreateSingleAVConstructor(
                origin: data.origin,
                uploadPath: data.uploadPathGenerator.call(i, file.path),
                ownersIDs: data.ownersIDs,
                skipMeta: data.skipMeta,
                bobDocName: data.bobDocName,
                caption: data.captionGenerator?.call(i, file.path),
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
