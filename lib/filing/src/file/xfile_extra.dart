part of filing;
/// TAMAM
extension Extra on XFile {
  // -----------------------------------------------------------------------------

  /// FILE NAME

  // --------------------
  String? get fileName {

    return FileNaming.getNameFromPath(
      path: path,
      withExtension: true,
    );

  }
  // --------------------
  String? get fileNameWithoutExtension {

    return FileNaming.getNameFromPath(
      path: path,
        withExtension: false,
    );

  }
  // -----------------------------------------------------------------------------

  /// EXTENSION

  // --------------------
  String? get extension {
    return FileExtensioning.getExtensionFromPath(path);
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
    final Uint8List? _bytes = await Byter.fromXFile(this, 'readSize');
    return FileSizer.calculateSize(_bytes?.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> readDimensions({
    required bool? isVideo,
    Uint8List? bytesIfThere,
  }) async {
    final Dimensions? _dims =  await DimensionsGetter.fromXFile(
      xFile: this,
      invoker: 'readDimensions',
      bytesIfThere: bytesIfThere,
      isVideo: isVideo,
    );
    return _dims;
  }
// -----------------------------------------------------------------------------
}
