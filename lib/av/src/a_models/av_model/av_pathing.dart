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
  /// directory/ldbDoc/fileNameWithOUTExtension
  /// file extension TO BE NEGLECTED to be able to check if file exists
  ///
  /// * ID is non nullable
  /// - EXAMPLE :-
  /// uploadPath   = 'folder/subFolder/file_name_without_extension';
  /// fileName     = 'file_name_without_extension';
  /// id           = 'folder_subFolder_file_name_without_extension';
  /// avsDirectory = 'avs';
  /// xFilePath    = 'avsDirectory/uploadPath';
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

  /// FILE NAME WITHOUT EXTENSION

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
  // --------------------------------------------------------------------------

  /// FILE NAME WITH EXTENSION

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
  }) async {

    final String? _fileNameWithoutExtension = AvPathing.createFileNameWithoutExtension(
      uploadPath: uploadPath,
    );

    return FilePathing.createPathByName(
      fileName: _fileNameWithoutExtension,
      directoryType: AvBobOps.avDirectory,
    );

  }
  // --------------------------------------------------------------------------

  /// FILE NAME ADJUSTMENT

  // --------------------
  /// RETURN_THE_FILE_WITH_EXTENSION_ISSUE
  static File? getFileWithExtension({
    required AvModel avModel,
  }){

    /// IN SUPER_VIDEO_CONTROLLER FILE MUST HAVE EXTENSION IN FILE NAME INSIDE THE FILE PATH

    // final XFile _xFile = avModel.xFile;
    //
    // final File _file = AvPathing.getFileWithExtension(
    //   avModel: avModel,
    // );
    //
    // final File? _file = await Filer.createFrom(
    //   mediaModel: object,
    //   includeFileExtension: true, /// breaks on ios if file has no extension
    // );

    /// RETURN_THE_FILE_WITH_EXTENSION_ISSUE
    return null;
  }
  // --------------------------------------------------------------------------
}
