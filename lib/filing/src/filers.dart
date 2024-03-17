part of filing;

class Filer {
  // -----------------------------------------------------------------------------

  const Filer();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> _createNewEmptyFile({
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {
    File? _output;

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
        useTemporaryDirectory: useTemporaryDirectory,
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
        _output = File(_filePath);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> _writeBytesOnFile({
    required File? file,
    required Uint8List? bytes,
  }) async {

    if (kIsWeb == true || file == null || bytes == null) {
      return null;
    }

    else {
      await file.writeAsBytes(bytes);
      await file.create(recursive: true);
      return file;
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromBytes({
    required Uint8List? bytes,
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || bytes == null || fileName == null){
      return null;
    }

    else {
      final File? _file = await _createNewEmptyFile(
        fileName: fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

      return _writeBytesOnFile(
        bytes: bytes,
        file: _file,
      );
    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>?> createFromBytezz({
    required List<Uint8List>? bytezz,
    required List<String>? filesNames,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || bytezz == null || filesNames == null){
      return null;
    }

    else {
      final List<File> _output = <File>[];

      if (Lister.checkCanLoop(bytezz) == true){

        for (int i = 0; i < bytezz.length; i++){

          final File? _file = await createFromBytes(
            bytes: bytezz[i],
            fileName: filesNames[i],
            useTemporaryDirectory: useTemporaryDirectory,
          );

          if (_file != null){
            _output.add(_file);
          }

        }

      }

      return _output;
    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<File?> createFromLocalAsset({
    required String? localAsset,
    bool useTemporaryDirectory = false,
  }) async {
    File? _output;

    if (localAsset != null){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      final String? _fileName = FilePathing.getLocalAssetName(localAsset);

      _output = await createFromBytes(
        bytes: _bytes,
        fileName: _fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromImgImage({
    required img.Image? imgImage,
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || imgImage == null || fileName == null){
      return null;
    }

    else {

      final Uint8List? _uIntAgain = Byter.fromImgImage(imgImage);

      return Filer.createFromBytes(
        bytes: _uIntAgain,
        fileName: fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

    }

  }
  // ---------------------
  /// TASK : TEST ME
  static Future<File?> createFromURL({
    required String? url,
    String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || url == null){
      return null;
    }

    else {
      File? _file;

      if (ObjectCheck.isAbsoluteURL(url) == true){

        final Uint8List? _bytes = await Byter.fromURL(url);

        if (_bytes != null){

          final String _fileName = fileName
              ??
              TextMod.idifyString(url)
              ??
              Numeric.createUniqueID().toString();

          _file = await _createNewEmptyFile(
            fileName: _fileName,
            useTemporaryDirectory: useTemporaryDirectory,
          );

          _file = await _writeBytesOnFile(
            bytes: _bytes,
            file: _file,
          );

        }

      }

      return _file;
    }

  }
  // ---------------------
  /// TASK : TEST ME
  static Future<File?> createFromBase64({
    required String? base64,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || base64 == null){
      return null;
    }

    else {
      final Uint8List _fileAgainAsInt = base64Decode(base64);
      // await null;

      final File? _fileAgain = await createFromBytes(
        bytes: _fileAgainAsInt,
        fileName: '${Numeric.createUniqueID()}',
        useTemporaryDirectory: useTemporaryDirectory,
      );

      return _fileAgain;
    }
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------

  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------

  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------

  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFile({
    required File? file,
    String invoker = 'BLOG FILE',
  }){

    if (kIsWeb == true){
      blog('blogFile : ON WEB there are no Files');
    }

    else if (file == null){
      blog('blogFile : file is null');
    }

    else {

      blog('blogFile : $invoker : file.path : ${file.path}');
      blog('blogFile : $invoker : file.absolute : ${file.absolute}');
      blog('blogFile : $invoker : file.fileNameWithExtension : ${file.fileNameWithExtension}');
      blog('blogFile : $invoker : file.runtimeType : ${file.runtimeType}');
      blog('blogFile : $invoker : file.isAbsolute : ${file.isAbsolute}');
      blog('blogFile : $invoker : file.parent : ${file.parent}');
      // blog('blogFile : $invoker : file.resolveSymbolicLinksSync() : ${file.resolveSymbolicLinksSync()}');
      blog('blogFile : $invoker : file.lengthSync() : ${file.lengthSync()}');
      blog('blogFile : $invoker : file.toString() : $file');
      blog('blogFile : $invoker : file.lastAccessedSync() : ${file.lastAccessedSync()}');
      blog('blogFile : $invoker : file.lastModifiedSync() : ${file.lastModifiedSync()}');
      // blog('blogFile : $invoker : file.openSync() : ${file.openSync()}');
      // blog('blogFile : $invoker : file.openWrite() : ${file.openWrite()}');
      // blog('blogFile : $invoker : file.statSync() : ${file.statSync()}');
      blog('blogFile : $invoker : file.existsSync() : ${file.existsSync()}');
      // DynamicLinks.blogURI(
      //   uri: file.uri,
      //   invoker: invoker,
      // );
      blog('blogFile : $invoker : file.hashCode : ${file.hashCode}');

      // blog('blogFile : $invoker : file.readAsLinesSync() : ${file.readAsLinesSync()}'); /// Unhandled Exception: FileSystemException: Failed to decode data using encoding 'utf-8',
      // blog('blogFile : $invoker : file.readAsStringSync() : ${file.readAsStringSync()}'); /// ERROR WITH IMAGE FILES
      // blog('blogFile : $invoker : file.readAsBytesSync() : ${file.readAsBytesSync()}'); /// TOO LONG

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFilesDifferences({
    required File? file1,
    required File? file2,
  }){

    if (kIsWeb == true){
      blog('blogFilesDifferences : ON WEB there are no Files');
    }

    if (file1 == null){
      blog('blogFilesDifferences : file1 is null');
    }

    if (file2 == null){
      blog('blogFilesDifferences : file2 is null');
    }

    if (file1 != null && file2 != null){

      if (file1.path != file2.path){
        blog('blogFilesDifferences: files paths are not Identical');
      }
      if (file1.lengthSync() != file2.lengthSync()){
        blog('blogFilesDifferences: files lengthSync()s are not Identical');
      }
      if (file1.resolveSymbolicLinksSync() != file2.resolveSymbolicLinksSync()){
        blog('blogFilesDifferences: files resolveSymbolicLinksSync()s are not Identical');
      }
      final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
          accuracy: TimeAccuracy.microSecond,
          time1: file1.lastModifiedSync(),
          time2: file2.lastModifiedSync()
      );
      if (_lastModifiedAreIdentical == true){
        blog('blogFilesDifferences: files lastModifiedSync()s are not Identical');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFilesAreIdentical({
    required File? file1,
    required File? file2,
    String invoker = 'checkFilesAreIdentical',
  }) {

    if (kIsWeb == true){
      return true;
    }

    else {
      bool _identical = false;

      if (file1 == null && file2 == null){
        _identical = true;
      }

      else if (file1 != null && file2 != null){
        if (file1.path == file2.path){
          if (file1.lengthSync() == file2.lengthSync()){
            if (file1.resolveSymbolicLinksSync() == file2.resolveSymbolicLinksSync()){

              final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
                  accuracy: TimeAccuracy.microSecond,
                  time1: file1.lastModifiedSync(),
                  time2: file2.lastModifiedSync()
              );

              if (_lastModifiedAreIdentical == true){
                // if (Lister.checkListsAreIdentical(list1: file1.readAsBytesSync(), list2: file2.readAsBytesSync()) == true){
                _identical = true;
                // }
              }

            }
          }
        }
      }

      if (_identical == false){
        blogFilesDifferences(
          file1: file1,
          file2: file2,
        );
      }

      return _identical;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static Future<File?> getFileFromDynamics(dynamic pic) async {

    if (kIsWeb == true || pic == null){
      return null;
    }

    else {
      File? _file;

      if (pic != null) {

        /// FILE
        if (ObjectCheck.objectIsFile(pic) == true) {
          _file = pic;
        }

        /// ASSET
        // else if (ObjectChecker.objectIsAsset(pic) == true) {
        //   _file = await getFileFromPickerAsset(pic);
        // }

        /// URL
        else if (ObjectCheck.isAbsoluteURL(pic) == true) {
          _file = await createFromURL(
            url: pic,
          );
        }

        /// RASTER
        else if (ObjectCheck.objectIsJPGorPNG(pic) == true) {
          // _file = await getFile
        }

      }

      return _file;
    }

  }







  // --------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */

  // -----------------------------------------------------------------------------
}
