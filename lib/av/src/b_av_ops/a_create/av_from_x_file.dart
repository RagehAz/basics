part of av;

class _AvFromXFile {
  // -----------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  ///
  static Future<AvModel?> createSingle({
    required XFile? xFile,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromBytes.createSingle(
      bytes: await Byter.fromXFile(xFile, 'createSingle'),
      data: data.copyWith(
        originalXFilePath: data.originalXFilePath ?? xFile?.path,
        fileExt: data.fileExt ?? FileExtensioning.getTypeByExtension(xFile?.extension),

      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// MANY

  // --------------------
  ///
  static Future<List<AvModel>> createMany({
    required List<XFile>? files,
    required CreateMultiAVConstructor data,
  }) async {
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(files) == true){

      await Lister.loop(
        models: files,
        onLoop: (int i, XFile? file) async {

          if (file != null){

            final AvModel? _model = await createSingle(
              xFile: file,
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
