// ignore_for_file: avoid_catches_without_on_clauses
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
    /// XFile.length() is a lightweight stat call (or an already-cached
    /// value) -- this used to read the entire file into memory via
    /// Byter.fromXFile() just to check its byte count, same anti-pattern
    /// already fixed on File.readSize.
    int? _length;

    try {
      _length = await length();
    } catch (error) {
      blog('XFile.readSize : tryAndCatch ERROR : $error');
    }

    return FileSizer.calculateSize(_length, fileSizeUnit);
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
