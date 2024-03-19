part of filing;

class FilePathing {
  // -----------------------------------------------------------------------------

  const FilePathing();

  // -----------------------------------------------------------------------------

  /// CREATE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createNewFilePath({
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    String? _output;

    if (kIsWeb == true || fileName == null){
      /// NOT IMPLEMENTED
    }

    else {

      final Directory? _directory = await Director.getDirectory(
          type: directoryType,
      );

      if (_directory != null){
        _output = fixFilePath('${_directory.path}$slash$fileName');
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PATH FIXING

  // --------------------
  static final String slash = kIsWeb ? '/' : Platform.pathSeparator;
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixFilePath(String? path) {
    String? _output = path;
    if (path != null) {
      _output = path.replaceAll(r'\', slash);
      _output = path.replaceAll(r'/', slash);
    }
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILE NAME GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFileNameFromFile({
    required File? file,
    required bool withExtension,
  }){

    if (kIsWeb == true || file == null){
      return null;
    }

    else {
      return getFileNameFromFilePath(
        filePath: file.path,
        withExtension: withExtension,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFileNameFromFilePath({
    required String? filePath,
    required bool withExtension,
  }){

    if (kIsWeb == true || TextCheck.isEmpty(filePath) == true){
      return null;
    }

    else {
      String? _fileName;

      _fileName = TextMod.removeTextBeforeLastSpecialCharacter(
        text: filePath,
        specialCharacter: slash,
      );

      if (withExtension == false) {
        _fileName = TextMod.removeTextAfterLastSpecialCharacter(
          text: _fileName,
          specialCharacter: '.',
        );
      }

      return _fileName;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>?> getFilesNamesFromFiles({
    required List<File>? files,
    required bool withExtension,
  }) async {

    if (kIsWeb == true || files == null){
      return null;
    }

    else {
      final List<String> _names = <String>[];

      if (Lister.checkCanLoop(files) == true){

        for (final File _file in files){

          final String? _name = getFileNameFromFile(
            file: _file,
            withExtension: withExtension,
          );

          if (_name != null){
            _names.add(_name);
          }

        }

      }

      return _names;
    }

  }
  // -----------------------------------------------------------------------------

  /// FILE EXTENSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFileExtensionFromFile(String? path){

    if (kIsWeb == true || path == null){
      return null;
    }

    ///  NOTE 'jpg' - 'png' - 'pdf' ... etc => which does not include the '.'
    else {

      final String _dotExtension = extension(path);

      return TextMod.removeTextBeforeLastSpecialCharacter(
        text: _dotExtension,
        specialCharacter: '.',
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// FILE EXTENSION

  // --------------------
  ///
  static String? getFileDirectoryPath({
    required String? filePath,
  }){

    return TextMod.removeTextAfterLastSpecialCharacter(
        text: filePath,
        specialCharacter: slash,
    );

  }
  // -----------------------------------------------------------------------------

  /// LOCAL ASSET PATH

  // --------------------
  /*
  ///
  static String imageDir({
    required String prefix,
    required String fileName,
    required double pixelRatio,
    required bool isIOS,
  }) {

    /// MediaQueryData data = MediaQuery.of(context);
    /// double ratio = data.devicePixelRatio;
    ///
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    ///
    /// If the platform is not iOS, you would implement the buckets in your code. Combining the logic into one method:
    ///
    /// double markerScale;
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    /// if (isIOS){markerScale = 0.7;}else{markerScale = 1;}

    String directory = '/';

    if (!isIOS) {
      if (pixelRatio >= 1.5) {
        directory = '/2.0x/';
      }

      else if (pixelRatio >= 2.5) {
        directory = '/3.0x/';
      }

      else if (pixelRatio >= 3.5) {
        directory = '/4.0x/';
      }

    }

    return '$prefix$directory$fileName';
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLocalAssetName(String? assetPath){
    final String? _pathTrimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
      string: assetPath,
      numberOfCharacters: 7,
    );
    return TextMod.getFileNameFromAsset(_pathTrimmed);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getLocalAssetsPaths() async {
    final List<String> _allAssetsPaths = <String>[];

    final Map<String, dynamic>? _json = await LocalJSON.read(
      path: 'AssetManifest.json',
    );

    if (_json != null){

      final List<String> _keys = _json.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){
        for (final String key in _keys){
          _allAssetsPaths.add(_json[key].first);
        }
      }

    }

    return _allAssetsPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLocalAssetPathFromLocalPaths({
    required List<String> allAssetsPaths,
    required String? assetName,
  }){

    final List<String> _assetPath = Pathing.findPathsContainingSubstring(
      paths: allAssetsPaths,
      subString: assetName,
    );

    return _assetPath.isNotEmpty ? _assetPath.first : null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkLocalAssetExists(dynamic asset) async {
    bool _isFound = false;

    if (asset is String){
      if (TextCheck.isEmpty(asset) == false){

        final ByteData? _bytes = await Byter.byteDataFromLocalAsset(
          pathOrURL: asset,
        ).catchError(
              (Object? error) {
            // blog('LocalAssetChecker : _checkAsset : error : ${error.toString()}');

            if (error == null) {
              _isFound = true;
            }
            else {
              _isFound = false;
            }

            return null;
          },
        );

        _isFound = _bytes != null;
      }
    }

    return _isFound;
  }
  // -----------------------------------------------------------------------------
}
