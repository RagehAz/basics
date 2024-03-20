part of filing;

/// TAMAM
extension Extra on XFile {
  // -----------------------------------------------------------------------------

  /// FILE NAME

  // --------------------
  String get fileName {
    return path.split('/').last;
  }
  // -----------------------------------------------------------------------------

  /// EXTENSION

  // --------------------
  String? get extension {
    return FileTyper.getExtension(
      object: path,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  String get stringify => 'XFile(path: $path, name: $name)';
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<double?> readSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {
    final Uint8List? _bytes = await Byter.fromXFile(this);
    return FileSizer.calculateSize(_bytes?.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> readDimensions() async {
    final Dimensions? _dims =  await DimensionsGetter.fromXFile(
      file: this,
    );
    return _dims;
  }
// -----------------------------------------------------------------------------
}
