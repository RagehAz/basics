part of filing;

/// TAMAM
extension FileExtention on FileSystemEntity {
  // -----------------------------------------------------------------------------

  /// FILE NAME

  // --------------------
  String get fileNameWithExtension {
    return path.split('/').last;
  }
  // -----------------------------------------------------------------------------

  /// FILE EXTENSION

  // --------------------
  String get fileExtension {
    return path.split('.').last;
  }
  // -----------------------------------------------------------------------------
}
