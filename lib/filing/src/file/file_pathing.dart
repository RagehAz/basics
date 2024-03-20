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

  /// GET FILE NAME

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNameFromLocalAsset(String? assetPath){

    if (TextCheck.isEmpty(assetPath) == true) {
      return null;
    }
    else {
      /// this trims paths like 'assets/xx/pp_sodic/builds_1.jpg' to 'builds_1.jpg'
      return TextMod.removeTextBeforeLastSpecialCharacter(
        text: assetPath,
        specialCharacter: slash,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNameFromFile({
    required File? file,
    required bool withExtension,
  }){

    if (kIsWeb == true || file == null){
      return null;
    }

    else {
      return getNameFromFilePath(
        filePath: file.path,
        withExtension: withExtension,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNameFromXFile({
    required XFile? file,
    required bool withExtension,
  }){

    if (kIsWeb == true || file == null){
      return null;
    }

    else {
      return getNameFromFilePath(
        filePath: file.path,
        withExtension: withExtension,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNameFromFilePath({
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
  static Future<List<String>?> getNamesFromFiles({
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

          final String? _name = getNameFromFile(
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

  /// DIRECTORY PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getDirectoryPathFromFile({
    required String? filePath,
  }){

    return TextMod.removeTextAfterLastSpecialCharacter(
        text: filePath,
        specialCharacter: slash,
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