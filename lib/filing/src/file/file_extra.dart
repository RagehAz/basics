part of filing;
/// TAMAM
extension FileExtention on File {
  // -----------------------------------------------------------------------------

  /// FILE NAME

  // --------------------
  String? get fileName {

    return FilePathing.getNameFromPath(
      path: path,
      withExtension: true,
    );

  }
  // --------------------
  String? get fileNameWithoutExtension {

    final String? _without = FilePathing.getNameFromPath(
      path: path,
      withExtension: false,
    );

    blog('fileNameWithoutExtension : aho : $fileName : and $_without');

    return _without;
  }
  // --------------------
  String? getFileName ({
    required bool withExtension,
  }){

    return FilePathing.getNameFromPath(
        path: path,
        withExtension: withExtension
    );

  }
  // -----------------------------------------------------------------------------

  /// EXTENSION

  // --------------------
  String? get extension {
    return FileTyper.getExtensionFromPath(path);
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  String get stringify => 'File(path: $path, name: $fileName)';
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<double?> readSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {
    final Uint8List? _bytes = await Byter.fromFile(this);
    return FileSizer.calculateSize(_bytes?.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> readDimensions() async {
    final Dimensions? _dims =  await DimensionsGetter.fromFile(
      file: this,
    );
    return _dims;
  }
// -----------------------------------------------------------------------------
}
