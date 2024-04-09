part of filing;
/// => TAMAM
class Filer {
  // -----------------------------------------------------------------------------

  const Filer();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createEmptyFile({
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
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

      final String? _filePath = await FilePathing.createPathByName(
        fileName: fileName,
        directoryType: directoryType,
      );

      if (_filePath != null) {

        /// ONLY FOR WINDOWS,MAKE SURE PATH EXISTS
        if (DeviceChecker.deviceIsWindows() == true) {
          final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
            text: _filePath,
            specialCharacter: FilePathing.slash,
          )!;
          await Directory(_pathWithoutDocName).create(recursive: true);
        }

        /// FILE REF
        _output = File(_filePath);

        /// DELETE EXISTING FILE IF EXISTS
        await deleteFile(_output);

        /// CREATE
        await _output.create(
          // recursive: ,
          // exclusive: ,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromBytes({
    required Uint8List? bytes,
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _output;

    final String? _fileName = FilePathing.fixFileName(
      fileName: fileName,
      bytes: bytes,
      includeFileExtension: false,
    );

    if (kIsWeb == true || bytes == null || _fileName == null){
      /// NOT IMPLEMENTED
    }

    else {



      await tryAndCatch(
        invoker: 'Filer.createByBytes',
        functions: () async {

          final String? _filePath = await FilePathing.createPathByName(
            fileName: _fileName,
            directoryType: directoryType,
          );

          if (_filePath != null){

            /// FILE REF
            _output = File(_filePath);

            /// DELETE EXISTING FILE IF EXISTED
            await deleteFile(_output);

            /// CREATE
            await _output!.writeAsBytes(bytes);
          }

          },
      );

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>?> createFromBytezz({
    required List<Uint8List>? bytezz,
    required List<String>? filesNames,
    DirectoryType directoryType = DirectoryType.app,
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
            directoryType: directoryType,
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
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromLocalAsset({
    required String? localAsset,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _output;

    if (localAsset != null){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
        localAsset: localAsset,
      );

      final String? _fileName = FilePathing.getNameFromLocalAsset(localAsset);

      _output = await createFromBytes(
        bytes: _bytes,
        fileName: _fileName,
        directoryType: directoryType,
      );

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromMediaModel({
    required MediaModel? mediaModel,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _output;

    if (mediaModel != null){

      _output = await Filer.createFromBytes(
        bytes: mediaModel.bytes,
        fileName: mediaModel.getName(withExtension: false),
        directoryType: directoryType,
      );

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromURL({
    required String? url,
    String? fileName,
    DirectoryType directoryType = DirectoryType.app,
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

          _file = await createFromBytes(
            bytes: _bytes,
            fileName: _fileName,
          );

        }

      }

      return _file;
    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromImgImage({
    required img.Image? imgImage,
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    if (kIsWeb == true || imgImage == null || fileName == null){
      return null;
    }

    else {

      final Uint8List? _uIntAgain = Byter.fromImgImage(imgImage);

      return Filer.createFromBytes(
        bytes: _uIntAgain,
        fileName: fileName,
        directoryType: directoryType,
      );

    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromBase64({
    required String? base64,
    required String fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    if (kIsWeb == true || base64 == null){
      return null;
    }

    else {
      final Uint8List _fileAgainAsInt = base64Decode(base64);
      // await null;

      final File? _fileAgain = await createFromBytes(
        bytes: _fileAgainAsInt,
        fileName: fileName,
        directoryType: directoryType,
      );

      return _fileAgain;
    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createFromSuperFile({
    required SuperFile? file,
    String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    if (kIsWeb == true || file == null){
      return null;
    }

    else {

      final Uint8List? _fileAgainAsInt = await Byter.fromSuperFile(file);
      // await null;

      final File? _fileAgain = await createFromBytes(
        bytes: _fileAgainAsInt,
        fileName: fileName ?? file.getFileName(withExtension: true),
        directoryType: directoryType,
      );

      return _fileAgain;
    }

  }
  // -----------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> cloneFile({
    required File? file,
    required String? newName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _output;

    final String? _fileName = FilePathing.fixFileName(
      fileName: newName,
      bytes: await Byter.fromFile(file),
      includeFileExtension: false,
    );

    if (file != null && _fileName != null && _fileName != file.fileName){

      final String? _filePath = await FilePathing.createPathByName(
        fileName: _fileName,
        directoryType: directoryType,
      );

      await tryAndCatch(
        invoker: 'Filer.cloneFile',
        functions: () async {

          _output = await file.copy(_filePath!);

          },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>> readAllDirectoryFiles({
    required DirectoryType type,
  }) async {

    final List<String> _filesPaths = await Director.readDirectoryFilesPaths(
      type: type,
    );

    return readFiles(
      filesPaths: _filesPaths,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<File> readFiles({
    required List<String> filesPaths,
  }){
    final List<File> _output = [];

    if (Lister.checkCanLoop(filesPaths) == true){

      for (final String path in filesPaths){
        final File _file = File(path);
        _output.add(_file);
      }

    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static File? readXFile({
    required XFile? xFile,
  }){

    if (xFile?.path != null){
      return File(xFile!.path);
    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> readByName({
    required String? name,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _file;

    final String? _path = await Director.findFilePathByName(
      name: name,
    );

    if (_path != null){

      _file = File(_path);

    }

    return _file;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> replaceBytes({
    required File? file,
    required Uint8List? bytes,
  }) async {
    File? _output;

    if (kIsWeb == true || file == null || bytes == null) {
      /// NOT IMPLEMENTED
    }

    else {

      final DirectoryType? _directoryType = await Director.concludeDirectoryFromFilePath(
        filePath: file.path,
      );

      if (_directoryType != null){

        final String _fileName = FilePathing.getNameFromFile(
            file: file,
            withExtension: true,
        )!;

        await Filer.deleteFile(file);

        _output = await Filer.createFromBytes(
          bytes: bytes,
          fileName: _fileName,
          directoryType: _directoryType,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> renameFile({
    required File? file,
    required String? newName,
  }) async {
    File? _output = file;

    final String? _newName = FilePathing.fixFileName(
      fileName: newName,
      bytes: await Byter.fromFile(file),
      includeFileExtension: false,
    );

    final String? _newPath = FilePathing.replaceFileNameInPath(
      fileName: _newName,
      oldPath: file?.path,
    );

    if (_newPath != null){

      await tryAndCatch(
        invoker: 'Filer.renameFile',
        functions: () async {

          _output = await file?.rename(_newPath);

          },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFile(File? file) async {

    if (file != null){

      final DirectoryType? dir = await Director.concludeDirectoryFromFilePath(
        filePath: file.path,
      );

      if (dir != null){

        final bool _exists = await checkFileExistsByName(
          name: file.fileName,
          directoryType: dir,
        );

        if (_exists == true){

          await tryAndCatch(
            invoker: 'Filer.deleteFile',
            functions: () async {

              await file.delete(
                // recursive:
              );
              await ImageCacheOps.wipeCaches();

            },
          );

        }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFileByName({
    required String? name,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    if (name != null){

      final String? _path = await FilePathing.createPathByName(
        fileName: name,
        directoryType: directoryType,
      );

      if (_path != null){
        await deleteFile(File(_path));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFiles(List<File> files) async {

    if (Lister.checkCanLoop(files) == true){

      for (final File file in files){

        await deleteFile(file);

      }

    }

  }
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

      final Map<String, dynamic> _map = {
        'path': file.path,
        'absolute': file.absolute,
        'fileNameWithExtension': file.fileName,
        'runtimeType': file.runtimeType,
        'isAbsolute': file.isAbsolute,
        'parent': file.parent,
        'lengthSync()': file.lengthSync(),
        'file.readAsBytesSync().length': file.readAsBytesSync().length,
        'toString()': file.toString(),
        'lastAccessedSync()': file.lastAccessedSync(),
        'lastModifiedSync()': file.lastModifiedSync(),
        'existsSync()': file.existsSync(),
        'hashCode': file.hashCode,
      };
      // blog('blogFile : $invoker : file.resolveSymbolicLinksSync() : ${file.resolveSymbolicLinksSync()}');
      // blog('blogFile : $invoker : file.openSync() : ${file.openSync()}');
      // blog('blogFile : $invoker : file.openWrite() : ${file.openWrite()}');
      // blog('blogFile : $invoker : file.statSync() : ${file.statSync()}');
      // DynamicLinks.blogURI(
      //   uri: file.uri,
      //   invoker: invoker,
      // );
      // blog('blogFile : $invoker : file.readAsLinesSync() : ${file.readAsLinesSync()}'); /// Unhandled Exception: FileSystemException: Failed to decode data using encoding 'utf-8',
      // blog('blogFile : $invoker : file.readAsStringSync() : ${file.readAsStringSync()}'); /// ERROR WITH IMAGE FILES
      // blog('blogFile : $invoker : file.readAsBytesSync() : ${file.readAsBytesSync()}'); /// TOO LONG

      Mapper.blogMap(_map, invoker: invoker,);

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

      // if (_identical == false){
      //   blogFilesDifferences(
      //     file1: file1,
      //     file2: file2,
      //   );
      // }

      return _identical;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkFileExistsByName({
    required String? name,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    bool _exists = false;

    if (name != null){

      final String? _path = await Director.findFilePathByName(
        name: name,
      );

      if (_path != null){
        _exists = await File(_path).exists();
      }

    }

    return _exists;
  }
  // -----------------------------------------------------------------------------
}
