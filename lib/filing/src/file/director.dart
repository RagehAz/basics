part of filing;

enum DirectoryType {
  app,
  temp,
  external,
  download,
}
/// => TAMAM
class Director {
  // -----------------------------------------------------------------------------

  const Director();

  // -----------------------------------------------------------------------------

  /// ALL DIRECTORIES

  // --------------------
  static List<DirectoryType> allDirectoryTypes = [
    DirectoryType.app,
    DirectoryType.temp,
    DirectoryType.external,
    DirectoryType.download,
  ];
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
  // --------------------
  ///
  static String dirSystemTempPath(){
    return Directory.systemTemp.path;
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY GETTER

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getAllDirectoriesPaths() async {
    final List<String> _output = [];

    for (final DirectoryType type in allDirectoryTypes){

      final Directory? _directory = await getDirectory(
        type: type,
      );

      if (_directory != null){
        _output.add(_directory.path);
      }

    }

    final String _flutterAssetsDirectoryPath = await _getFlutterAssetsDirPath();
    _output.add(_flutterAssetsDirectoryPath);

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILES PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> readDirectoryFilesPaths({
    required DirectoryType type,
  }) async {
    List<String> _output = [];

    final Directory? _x = await Director.getDirectory(
      type: type,
    );
    final String? _path = _x?.path;

    if (_path != null){

      List<FileSystemEntity> _fileSystemEntities = [];

      await tryAndCatch(
        invoker: 'readAllDirectoryFiles',
        functions: () async {

          _fileSystemEntities = Directory(_path).listSync(
            // followLinks: ,
            // recursive: false,
          );

          _output = await _getOnlyFilesPaths(
            fileSystemEntities: _fileSystemEntities,
          );

        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getOnlyFilesPaths({
    required List<FileSystemEntity>? fileSystemEntities,
  }) async {
    final List<String> _output = [];

    if (Lister.checkCanLoop(fileSystemEntities) == true){

      final List<String> _directoriesPaths = await getAllDirectoriesPaths();

      for (final FileSystemEntity fileSystemEntity in fileSystemEntities!){

        // final FileStat _stat = await fileSystemEntity.stat();
        // _stat.

        final String _path = fileSystemEntity.path;

        final bool _isDirectory = Stringer.checkStringsContainString(
            strings: _directoriesPaths,
            string: _path
        );

        if (_isDirectory == false){
          _output.add(fileSystemEntity.path);
        }

      }

    }

    return _output;
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _getFlutterAssetsDirPath() async {
    final Directory? _directory = await getDirectory(
      type: DirectoryType.app,
    );
    return '${_directory?.path}/flutter_assets';
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY PATHING

  // --------------------
  ///
  static Future<DirectoryType?> concludeDirectoryFromFilePath({
    required String? filePath,
  }) async {
    DirectoryType? _type;

    final String? _fileDirectoryPath = FilePathing.getFileDirectoryPath(
      filePath: filePath,
    );

    if (_fileDirectoryPath != null){

      for (final DirectoryType type in allDirectoryTypes){

        final Directory? _directory = await getDirectory(
          type: type,
        );

        if (_directory?.path == _fileDirectoryPath){
          _type = type;
          break;
        }


      }

    }

    return _type;
  }
  // -----------------------------------------------------------------------------
}
