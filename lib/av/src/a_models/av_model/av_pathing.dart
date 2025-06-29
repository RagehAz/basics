part of av;

abstract class AvPathing {
  // --------------------------------------------------------------------------

  /// PATHING RULES

  // --------------------
  /// AT ALL TIMES, IN ANY INSTANCE, THESE RULES SHOULD APPLY
  ///
  /// ID
  /// ID is an Idified uploadPath
  /// ID IS NECESSARY FOR LOCAL LDBS
  ///
  /// UPLOAD PATH
  /// upload path should have file name without extension as last node
  /// extension is removed to be able to generate the path without predicting file type
  ///
  /// XFilePath
  /// directory/ldbDoc/fileNameWithExtension
  /// file extension IS MANDATORY
  ///
  /// * ID is non nullable
  /// - EXAMPLE :-
  /// uploadPath   = 'folder/subFolder/file_name_without_extension';
  /// fileName     = 'file_name_without_extension';
  /// id           = 'folder_subFolder_file_name_without_extension';
  /// avsDirectory = 'avs';
  /// xFilePath    = 'avsDirectory/uploadPath.ext';
  ///
  /// we only use the uploadPath outside the package as the AV main identifier
  // --------------------------------------------------------------------------

  /// ID

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createID({
    required String? uploadPath,
  }){

    if (TextCheck.isEmpty(uploadPath) == true){
      return null;
    }
    else {

      final String? _output = TextMod.replaceAllCharacters(
        characterToReplace: '/',
        replacement: '_',
        input: uploadPath,
      );

      return TextMod.removeTextAfterLastSpecialCharacter(
        specialCharacter: '.',
        text: _output,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> createIDs({
    required List<String> uploadPaths,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(uploadPaths) == true){

      for (final String path in uploadPaths){

        final String? _id = createID(
          uploadPath: path,
        );

        if (_id != null){
          _output.add(_id);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FILE NAME

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createFileNameWithoutExtension({
    required String? uploadPath,
  }){
    String? _output;

    if (uploadPath != null){
      _output = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: false,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createFileNameWithExtension({
    required String? uploadPath,
    required FileExtType? type,
  }){
    String? _output;

    if (uploadPath != null){

      final String? _name = FileNaming.getNameFromPath(path: uploadPath, withExtension: true);

      final bool _hasExtension = FileExtensioning.checkNameHasExtension(_name);

      if (_hasExtension == true){
        _output = _name;
      }
      else {

        final String? _ext = FileExtensioning.getExtensionByType(type);
        if (_ext != null){
          _output = '$_name.$_ext';
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FILE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createXFilePath({
    required String? uploadPath,
    required FileExtType? type,
  }) async {
    String? _output;

    final String? _fileNameWithoutExt = createID(uploadPath: uploadPath);
    final String? _ext = FileExtensioning.getExtensionByType(type);

    if (_fileNameWithoutExt != null && _ext != null){

      _output = await FilePathing.createPathByName(
        fileName: '$_fileNameWithoutExt.$_ext',
        directoryType: AvBobOps.avDirectory,
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// AMAZON PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createAmazonPath({
    required String? path,
  }) {
    String? _output;

    if (TextCheck.isEmpty(path) == false) {

      if (checkIsUploadPath(path) == true) {
        _output = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: path,
          specialCharacter: '/',
        )!;
      }

      else if (Pathing.checkIsPath(path) == true) {
        _output = path;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> createAmazonPaths({
    required List<String>? paths,
  }){
    List<String> _output = [];
    if (Lister.checkCanLoop(paths) == true){
      for (final String path in paths!){
        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: createAmazonPath(path: path),
        );
      }
    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getUploadPathFromAmazonPath({
    required String? amazonPath,
  }){
    String? _output = amazonPath;

    if (amazonPath != null){
      if (checkIsAmazonPath(path: amazonPath) == true){
        _output = TextMod.removeTextAfterNumberOfCharacters(
          string: amazonPath,
          numberOfCharacters: 'storage/'.length,
        );
      }
      else if (checkIsUploadPath(amazonPath) == true){
        _output = amazonPath;
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsAmazonPath({
    required String? path,
  }){
    bool _isAmazon = false;

    if (Pathing.checkIsPath(path) == true){

      _isAmazon = TextCheck.stringStartsExactlyWith(text: path, startsWith: 'storage/') == false;

    }

    return _isAmazon;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsUploadPath(dynamic object){
    bool _isPicPath = false;

    if (object != null && object is String){

      final String _path = object;

      _isPicPath = TextCheck.stringStartsExactlyWith(text: _path, startsWith: 'storage/');

    }

    return _isPicPath;
  }
  // -----------------------------------------------------------------------------

  /// ROOTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getRootFolderName({
    required String? path,
  }){
    String? _output;

    final String? _amazonPath = AvPathing.createAmazonPath(
      path: path,
    );

    if (_amazonPath != null){

      _output = TextMod.removeTextAfterFirstSpecialCharacter(
        text: _amazonPath,
        specialCharacter: '/',
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getParentFolderAmazonPath({
    required List<AvModel> avModels,
  }){
    String? _output;

    final List<String> _parentsPaths = AvModel.getAvsParentUploadPaths(
      avModels: avModels,
    );

    if (Lister.checkCanLoop(_parentsPaths) == true){

      for (final String _parentPath in _parentsPaths){

        if (_output == null){
          _output = _parentPath;
        }
        else if (_output != _parentPath){
          _output = null;
        }
        else {
          _output = _parentPath;
        }

      }

    }

    return AvPathing.createAmazonPath(path: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAvsAreInSameFolder(List<AvModel> avModels){
    return getParentFolderAmazonPath(avModels: avModels) != null;
  }
  // --------------------------------------------------------------------------
}
