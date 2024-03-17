part of filing;

class FilePathing {
  // -----------------------------------------------------------------------------

  const FilePathing();

  // -----------------------------------------------------------------------------

  /// DIRECTORIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> downloadDirectory() async {
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

  /// CREATE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createNewFilePath({
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || fileName == null){
      return null;
    }

    else {
      final Directory _appDocDir = useTemporaryDirectory ?
      await getTemporaryDirectory()
          :
      await getApplicationDocumentsDirectory();

      return fixFilePath('${_appDocDir.path}$slash$fileName');
    }

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

  /// DIRECTORY - LOCAL ASSET PATH

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
  // -----------------------------------------------------------------------------
}
