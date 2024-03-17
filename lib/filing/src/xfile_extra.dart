part of filing;

extension Extra on XFile {
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  String get stringifyXFile => 'XFile(path: $path, name: $name)';
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TASK : TEST_ME_NOW
  Future<double?> readSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {
    final Uint8List _bytes = await readAsBytes();
    return FileSizer.calculateSize(_bytes.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TASK : TEST_ME_NOW
  Future<Dimensions?> readDimensions() async {
    final Dimensions? _dims =  await DimensionsGetter.fromXFile(
      xfile: this,
    );
    return _dims;
  }
// -----------------------------------------------------------------------------
}
