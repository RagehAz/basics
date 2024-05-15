part of filing;
/// => TAMAM
class FileNaming {
  // -----------------------------------------------------------------------------

  const FileNaming();

  // -----------------------------------------------------------------------------

  /// GET FROM PATH

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
        specialCharacter: FilePathing.slash(assetPath),
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
      return getNameFromPath(
        path: file.path,
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
      return getNameFromPath(
        path: file.path,
        withExtension: withExtension,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNameFromPath({
    required String? path,
    required bool withExtension,
  }){

    if (kIsWeb == true || TextCheck.isEmpty(path) == true){
      return null;
    }

    else {
      String? _fileName;

      _fileName = TextMod.removeTextBeforeLastSpecialCharacter(
        text: path,
        specialCharacter: FilePathing.slash(path),
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
  // -----------------------------------------------------------------------------

  /// GET FROM PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>?> getNamesFromPaths({
    required List<String>? paths,
    required bool withExtension,
  }) async {

    if (kIsWeb == true || paths == null){
      return null;
    }

    else {
      final List<String> _names = <String>[];

      if (Lister.checkCanLoop(paths) == true){

        for (final String path in paths){

          final String? _name = getNameFromPath(
            path: path,
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
}
