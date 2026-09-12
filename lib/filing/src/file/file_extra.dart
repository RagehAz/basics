// ignore_for_file: avoid_catches_without_on_clauses
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
    /// File.length() is a lightweight filesystem stat call -- this used to
    /// read the entire file into memory via Byter.fromFile() just to check
    /// its byte count, which for a large photo/video allocates a full
    /// in-memory copy for no reason.
    int? _length;

    try {
      _length = await length();
    } catch (error) {
      // file may not exist -- leave _length null, matching the old
      // behavior where a failed read left _bytes null too.
      blog('File.readSize : tryAndCatch ERROR : $error');
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
    final Dimensions? _dims =  await DimensionsGetter.fromFile(
      file: this,
      isVideo: isVideo,
      bytesIfThere: bytesIfThere,
    );
    return _dims;
  }
  // -----------------------------------------------------------------------------
}
