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

  static bool canHaveDirectory(){
    return kIsWeb == false && DeviceChecker.deviceIsWindows() == false;
  }
  // -----------------------------------------------------------------------------

  /// ALL DIRECTORIES

  // --------------------
  static List<DirectoryType> allDirectoryTypes(){

    /// WEB
    if (kIsWeb){
      return [];
    }

    /// WINDOWS
    else if (DeviceChecker.deviceIsWindows() == true){
      return [
        DirectoryType.app,
        DirectoryType.temp,
        // DirectoryType.external, // NOT AVAILABLE FOR WINDOWS
        DirectoryType.download,
      ];
    }

    /// ANDROID + IOS
    else {
      return [
          DirectoryType.app,
          DirectoryType.temp,
          DirectoryType.external,
          DirectoryType.download,
      ];
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> dirDownloadDirPath() async {
    String? _output;

    if (canHaveDirectory()){
      /// NOT IMPLEMENTED
    }
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
  /// TESTED : WORKS PERFECT
  static String? dirSystemTempPath(){
    if (kIsWeb){
      /// NOT IMPLEMENTED
      return null;
    }
    else {
      return Directory.systemTemp.path;
    }
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
      case DirectoryType.app: _output = kIsWeb ? null : await getApplicationDocumentsDirectory();
      case DirectoryType.temp: _output = kIsWeb ? null : await getTemporaryDirectory();
      case DirectoryType.external: _output = kIsWeb ? null : await getExternalStorageDirectory();
      case DirectoryType.download: _output = kIsWeb ? null : await getDownloadsDirectory();
      default: _output = null;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getAllDirectoriesPaths() async {
    final List<String> _output = [];

    for (final DirectoryType type in allDirectoryTypes()){

      final Directory? _directory = await getDirectory(
        type: type,
      );

      if (_directory != null){
        _output.add(_directory.path);
      }

    }

    final String? _flutterAssetsDirectoryPath = await _getFlutterAssetsDirPath();
    if (_flutterAssetsDirectoryPath != null){
      _output.add(_flutterAssetsDirectoryPath);
    }

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

    if (kIsWeb == false){

      final Directory? _x = await Director.getDirectory(
        type: type,
      );
      final String? _path = _x?.path;

      if (_path != null){

        List<FileSystemEntity> _fileSystemEntities = [];

        await tryAndCatch(
          invoker: 'readDirectoryFilesPaths',
          functions: () async {

            _fileSystemEntities = Directory(_path).listSync(
              // followLinks: ,
              // recursive: false,
            );

            if (kIsWeb){
              await Filer.createEmptyFile(fileName: 'empty_file');
            }

            _output = await _getOnlyFilesPaths(
              fileSystemEntities: _fileSystemEntities,
            );

          },
          onError: (String? error){
            blog('readDirectoryFilesPaths : ERROR : $error : PATH : $_path');
          }
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _getOnlyFilesPaths({
    required List<FileSystemEntity>? fileSystemEntities,
  }) async {
    final List<String> _output = [];

    if (kIsWeb == false && Lister.checkCanLoop(fileSystemEntities) == true){

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
  static Future<String?> _getFlutterAssetsDirPath() async {
    String? _output;

    if (kIsWeb == false){

      final Directory? _directory = await getDirectory(
        type: DirectoryType.app,
      );
      _output = '${_directory?.path}/flutter_assets';

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY PATHING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DirectoryType?> concludeDirectoryFromFilePath({
    required String? filePath,
  }) async {
    DirectoryType? _type;

    final String? _fileDirectoryPath = FilePathing.getDirectoryPathFromFile(
      filePath: filePath,
    );

    if (_fileDirectoryPath != null){

      for (final DirectoryType type in allDirectoryTypes()){

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

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> findFilePathByName({
    required String? name,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    String? _output;

    if (kIsWeb == false && name != null){

      // blog('findFilePathByName: searching for : $name');

      final List<String> _allPaths = await Director.readDirectoryFilesPaths(
        type: directoryType,
      );

      // blog('findFilePathByName: found : $_allPaths');

      final String? _nameWithoutExtension = TextMod.removeTextAfterLastSpecialCharacter(
          text: name,
          specialCharacter: '.',
      );

      final List<String> _matches = Pathing.findPathsContainingSubstring(
        paths: _allPaths,
        subString: _nameWithoutExtension,
      );

      // blog('findFilePathByName: _matches : $_matches');

      _output = _matches.firstOrNull;

      // blog('findFilePathByName: _output : $_output');

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// WIPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllDirectoryFiles({
    required DirectoryType? directoryType,
  }) async {

    if (kIsWeb == false && directoryType != null){

      final Directory? _dir = await Director.getDirectory(
        type: directoryType,
      );

      await tryAndCatch(
        invoker: 'Filer.deleteAllDirectoryFiles',
        functions: () async {

          await _dir?.delete(
            recursive: true,
          );

        },
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeAllDirectoriesAndCaches() async {

    if (kIsWeb == false){

      await Future.wait(<Future>[

        /// IMAGE CACHES
        ImageCacheOps.wipeCaches(),

        /// BREAKS LDB
        // /// DIRECTORIES
        // ...List.generate(allDirectoryTypes.length, (index){
        //
        //   return deleteAllDirectoryFiles(
        //     directoryType: allDirectoryTypes[index],
        //   );
        //
        // }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
