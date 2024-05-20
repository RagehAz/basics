part of filing;
/// => TAMAM
class FilePathing {
  // -----------------------------------------------------------------------------

  const FilePathing();

  // -----------------------------------------------------------------------------

  /// CREATE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createPathByName({
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
        final String _slash = getSlash(_directory.path);
        _output = fixFilePath('${_directory.path}$_slash$fileName');
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PATH FIXING

  // --------------------
  static String getSlash(String? path){

    if (path == null){
      return kIsWeb ? '/' : Platform.pathSeparator;
    }

    else {
      return TextCheck.stringContainsSubString(string: path, subString: '/') ? '/': r'\';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixFilePath(String? path) {
    String? _output = path;
    if (path != null) {
      _output = path.replaceAll(r'\', getSlash(path));
      _output = path.replaceAll(r'/', getSlash(path));
    }
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getDirectoryPathFromFile({
    required String? filePath,
  }){

    return TextMod.removeTextAfterLastSpecialCharacter(
        text: filePath,
        specialCharacter: getSlash(filePath),
    );

  }
  // -----------------------------------------------------------------------------

  /// ALL ASSET PATHS

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
  // -----------------------------------------------------------------------------

  /// PATH MODIFICATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? replaceFileNameInPath({
    required String? oldPath,
    required String? fileName,
    // required Uint8List? bytes,
    // required bool includeFileExtension,
  }){
    String? _output = oldPath;

    if (TextCheck.isEmpty(fileName) == false && TextCheck.isEmpty(oldPath) == false){

      final String? _pathWithoutFileName = TextMod.removeTextAfterLastSpecialCharacter(
        text: oldPath,
        specialCharacter: '/',
      );

      if (TextCheck.isEmpty(_pathWithoutFileName) == false){

        // final String? _newFileName = fixFileName(
        //   includeFileExtension: includeFileExtension,
        //   fileName: fileName,
        //   bytes: bytes,
        // );

        _output = '$_pathWithoutFileName/$fileName';

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

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
