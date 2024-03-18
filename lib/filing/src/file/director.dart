part of filing;

enum DirectoryType {
  app,
  temp,
  external,
  download,
}

class Director {
  // -----------------------------------------------------------------------------

  const Director();

  // -----------------------------------------------------------------------------

  /// DIRECTORIES

  // --------------------
  static Future<Directory?> getDirectory({
    required DirectoryType type,
  }) async {

    Directory? _output;

    switch (type){
      case DirectoryType.app: _output = await getApplicationDocumentsDirectory();
      case DirectoryType.temp: _output = await getTemporaryDirectory();
      case DirectoryType.external: _output = await getExternalStorageDirectory();
      case DirectoryType.download: _output = await getDownloadsDirectory();
      default: _output = null;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> dirDownloadDirPath() async {
    String? _output;

    if (DeviceChecker.deviceIsAndroid() == true){
      _output = await AndroidPathProvider.downloadsPath;
    }
    else {
      final Directory? downloadsDirectory = await getDownloadsDirectory();
      _output = downloadsDirectory?.path;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
