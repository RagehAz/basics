part of filing;
/// TAMAM
extension FileExtention on File {
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

    final String? _without = FileNaming.getNameFromPath(
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

    return FileNaming.getNameFromPath(
        path: path,
        withExtension: withExtension
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
  Future<Dimensions?> readDimensions({
    required bool? isVideo,
    Uint8List? bytesIfThere,
  }) async {
    final Dimensions? _dims =  await DimensionsGetter.fromFile(
      file: this,
      isVideo: isVideo,
      bytesIfThere: bytesIfThere,
    );
    return _dims;
  }
  // -----------------------------------------------------------------------------
}
