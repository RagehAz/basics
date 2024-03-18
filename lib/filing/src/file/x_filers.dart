part of filing;

class XFiler {
  // -----------------------------------------------------------------------------

  const XFiler();

  // -----------------------------------------------------------------------------

  /// BASICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> _createNewEmptyXFile({
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _output;

    if (kIsWeb == true || fileName == null){
      return null;
    }

    else {

      /// --------------------
      /// ANDROID APP DIRECTORY
      /// /data/user/0/com.bldrs.net/app_flutter/{fileName}
      /// ANDROID TEMPORARY DIRECTORY
      /// /data/user/0/com.bldrs.net/cache/{fileName}
      /// --------------------
      /// WINDOWS APP DIRECTORY
      /// C:\Users\rageh\Documents
      /// WINDOWS TEMPORARY DIRECTORY
      /// C:\Users\rageh\AppData\Local\Temp
      /// --------------------

      final String? _filePath = await FilePathing.createNewFilePath(
        fileName: fileName,
        directoryType: directoryType,
      );

      /// ONLY FOR WINDOWS,MAKE SURE PATH EXISTS
      if (DeviceChecker.deviceIsWindows() == true) {
        final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
          text: _filePath,
          specialCharacter: FilePathing.slash,
        )!;
        await Directory(_pathWithoutDocName).create(recursive: true);
      }

      if (_filePath != null) {
        _output = XFile(_filePath);
      }

    }

    return _output;
  }
  // --------------------
  /// ...
  static Future<XFile?> _writeBytesOnFile({
    required XFile? file,
    required Uint8List? bytes,
  }) async {

    if (kIsWeb == true || file == null || bytes == null) {
      return null;
    }

    else {
      return XFile.fromData(
        bytes,
        path: file.path,
        name: file.name,
        lastModified: DateTime.now(),
        length: bytes.length,
        mimeType: file.mimeType,
        // overrides:
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : TEST_ME_NOW
  static XFile? createFromFile({
    required File? file,
  }) {
    XFile? _output;

    if (file != null){

      _output = XFile(file.path);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromBytes({
    required Uint8List? bytes,
    required String? fileName
  }) async {
    XFile? _output;

    if (fileName != null && bytes != null){

      final XFile? _file = await _createNewEmptyXFile(
        fileName: fileName,
      );

      _output = await _writeBytesOnFile(
        bytes: bytes,
        file: _file,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromLocalAsset({
    required String? asset,
  }) async {

    final Uint8List? _bytes = await Byter.fromLocalAsset(
      localAsset: asset,
      // width: width,
    );

    final String? _fileName = FilePathing.getFileNameFromFilePath(
      filePath: asset,
      withExtension: true,
    );

    return createFromBytes(
      fileName: _fileName,
      bytes: _bytes,
    );

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> createFromURL({
    required String? url,
    required String? fileName
  }) async {
    XFile? _output;

    if (fileName != null && url != null){

      final Uint8List? _bytes = await Byter.fromURL(url);

      _output = await createFromBytes(
        bytes: _bytes,
        fileName: fileName,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> createFromAssetEntity({
    required AssetEntity? assetEntity,
  }) async {
    XFile? _output;

    if (assetEntity?.relativePath != null){

      _output = XFile(assetEntity!.relativePath!);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> replaceBytes({
    required XFile? file,
    required Uint8List? newBytes,
  }) async {

    if (newBytes == null){
      return file;
    }
    else {
      return _writeBytesOnFile(file: file, bytes: newBytes);
    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> deleteFile(String? path) async {

    if (TextCheck.isEmpty(path) == false){

      if (kIsWeb == true){

      }
      else {

        await File(path!).delete();

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<bool> checkXFilesAreIdentical({
    required XFile? file1,
    required XFile? file2,
    String invoker = 'checkFilesAreIdentical',
  }) async {
      bool _identical = false;

      if (file1 == null && file2 == null){
        _identical = true;
      }

      else if (file1 != null && file2 != null){
        if (file1.path == file2.path){

            final bool _bytesAreIdentical = Byter.checkBytesAreIdentical(
              bytes1: await file1.readAsBytes(),
              bytes2: await file2.readAsBytes(),
            );

            if (_bytesAreIdentical == true){
              _identical = true;
            }

        }
      }

      return _identical;

  }
  // -----------------------------------------------------------------------------
}
