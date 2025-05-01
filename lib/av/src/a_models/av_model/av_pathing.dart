part of av;

abstract class AvPathing {
  // --------------------------------------------------------------------------

  /// PATHING RULES

  // --------------------
  /// AT ALL TIMES, IN ANY INSTANCE, THESE RULES SHOULD APPLY
  /// * ID is an Idified uploadPath
  /// * file name should have no extension
  /// * upload path should have file name as last node
  /// * ID is non nullable
  /// - EXAMPLE :-
  /// uploadPath  = 'folder/subFolder/file_name_without_extension';
  /// fileName    = 'file_name_without_extension';
  /// id          = 'folder_subFolder_file_name_without_extension';
  // --------------------------------------------------------------------------

  /// INITIALIZATION

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

  /// FILE NAME ADJUSTMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, String?>> adjustPathAndName({
    required String uploadPath,
    required bool includeFileExtension,
    required Uint8List? bytes,
  }) async {
    String? _uploadPathOutput;
    String? _fileNameOutput;
    String? _fileExtension = FileExtensioning.getExtensionFromPath(uploadPath);

    // blog('1. _adjustPathAndName : start');

    /// WITH FILE EXTENSION : WILL NEED DETECTION
    if (includeFileExtension == true){

      // blog('2. _adjustPathAndName : includeFileExtension : $includeFileExtension');

      final String? _fileNameWithoutExtension = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: true,
      );

      // blog('3. _adjustPathAndName : _fileNameWithoutExtension : $_fileNameWithoutExtension');

      _fileNameOutput = await FormatDetector.fixFileNameByBytes(
        fileName: _fileNameWithoutExtension,
        bytes: bytes,
        includeFileExtension: true,
      );

      // blog('4. _adjustPathAndName : _fileNameOutput : $_fileNameOutput');

      /// REPLACE IT IN PATH ANYWAYS : NAME MIGHT ORIGINALLY WAS WITH EXTENSION IN THE PATH
      _uploadPathOutput = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileNameOutput,
      );

      // blog('5. _adjustPathAndName : _uploadPathOutput : $_uploadPathOutput');

      _fileExtension = FileExtensioning.getExtensionFromPath(_uploadPathOutput);

      // blog('6. _adjustPathAndName : _fileExtension : $_fileExtension');

    }

    /// WITHOUT FILE EXTENSION : NO DETECTION NEEDED
    else {

      /// GET NAME WITHOUT EXTENSION
      _fileNameOutput = FileNaming.getNameFromPath(
        path: uploadPath,
        withExtension: false,
      );

      /// REPLACE IT IN PATH ANYWAYS : NAME MIGHT ORIGINALLY WAS WITH EXTENSION IN THE PATH
      _uploadPathOutput = FilePathing.replaceFileNameInPath(
        oldPath: uploadPath,
        fileName: _fileNameOutput,
      );

    }

    return {
      'id': createID(uploadPath: _uploadPathOutput),
      'uploadPath': _uploadPathOutput,
      'fileName': _fileNameOutput,
      'fileExtension': _fileExtension,
    };
  }
  // --------------------
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
  void x(){}
}
