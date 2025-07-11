part of filing;
/// => TAMAM
abstract class Filer {
  // -----------------------------------------------------------------------------

  /// CREATE TEMP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> getOrCreateTempFile({
    required String? fileName,
    required Uint8List? bytes,
    required Function(File xFile) ops,
  }) async {
    File? _file;

    final bool _fileExists = await checkFileExistsByName(name: fileName);

    if (_fileExists == true){
      _file = await readByName(name: fileName);
    }
    else {
      _file = await createFromBytes(
        bytes: bytes,
        fileName: fileName,
        includeFileExtension: FileExtensioning.checkNameHasExtension(fileName),
      );
    }

    if (_file != null){
      await ops(_file);
    }

    if (_fileExists == false){
      await deleteFile(_file);
    }

  }
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

      blog('=> _filePath($_filePath)');

      if (_filePath != null) {

        /// ONLY FOR WINDOWS,MAKE SURE PATH EXISTS
        if (DeviceChecker.deviceIsWindows() == true) {
          final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
            text: _filePath,
            specialCharacter: FilePathing.getSlash(_filePath),
          )!;
          await Directory(_pathWithoutDocName).create(recursive: true);
        }

        // blog('1. createEmptyFile. _filePath : $_filePath');

        /// FILE REF
        _output = File(_filePath);

        // blog('2. createEmptyFile. _output : $_output');

        /// DELETE EXISTING FILE IF EXISTS
        await deleteFile(_output);

        // blog('3. createEmptyFile. deleted');

        /// CREATE
        await _output.create(
          // recursive: ,
          // exclusive: ,
        );

        // blog('4. createEmptyFile. created');

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
    bool includeFileExtension = false,
  }) async {
    File? _output;

    final String? _fileName = await FormatDetector.fixFileNameByBytes(
      fileName: fileName,
      bytes: bytes,
      includeFileExtension: includeFileExtension,
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

            await DirectoryOperator.addPath(xFilePath: _filePath);

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

      final String? _fileName = FileNaming.getNameFromLocalAsset(localAsset);

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
  static Future<File?> createFromURL({
    required String? url,
    String? fileName,
    DirectoryType directoryType = DirectoryType.app,
    bool includeFileExtension = false,
  }) async {

    if (kIsWeb == true || url == null){
      return null;
    }

    else {
      File? _file;

      if (ObjectCheck.isAbsoluteURL(url) == true){

        final Uint8List? _bytes = await Byter.fromURL(url);

        if (_bytes != null){

          final String _fileName = fileName ?? Idifier.idifyString(url)!;

          // blog('---> 1 : createFromURL : $_fileName');
          _file = await createFromBytes(
            bytes: _bytes,
            fileName: _fileName,
            includeFileExtension: includeFileExtension,
          );

          // blog('---> 2 : _file : $_file');

          // _file = await Filer.renameFile(
          //   file: _file,
          //   newName: _fileName,
          //   includeFileExtension: includeFileExtension,
          // );

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
  // -----------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> cloneFile({
    required File? file,
    required String? newName,
    required bool includeFileExtension,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    File? _output;

    final String? _fileName = await FormatDetector.fixFileNameByFile(
      rename: newName,
      file: file,
      includeFileExtension: includeFileExtension,
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
          await DirectoryOperator.addPath(xFilePath: _filePath);

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

        final String _fileName = FileNaming.getNameFromFile(
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
    required bool includeFileExtension,
  }) async {
    File? _output = file;

    final String? _newName = await FormatDetector.fixFileNameByFile(
      file: file,
      rename: newName,
      includeFileExtension: includeFileExtension,
    );

    final String? _oldName = file?.getFileName(withExtension: includeFileExtension);

    if (_oldName != _newName){

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

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteFile(File? file) async {
    bool _deleted = false;

    if (file != null){

      await tryAndCatch(
        invoker: 'deleteFile',
        functions: () async {
          await Directory(file.path).delete(recursive: true);
          await DirectoryOperator.removePath(xFilePath: file.path);
          _deleted = true;
        },
        onError: (String? error){
          if (TextCheck.stringContainsSubString(string: error, subString: 'PathNotFoundException')){
            blog('deleteFile: NO FILE TO DELETE IN (${file.path})');
          }
          else {
            blog('deleteFile: $error');
          }
        },
      );

      // final DirectoryType? dir = await Director.concludeDirectoryFromFilePath(
      //   filePath: file.path,
      // );
      // if (dir != null){
      //   final bool _exists = await checkFileExistsByName(
      //     name: file.fileName,
      //     directoryType: dir,
      //   );
      //   if (_exists == true){
      //
      //     await tryAndCatch(
      //       invoker: 'Filer.deleteFile',
      //       functions: () async {
      //
      //         await file.delete(
      //           // recursive:
      //         );
      //         await ImageCacheOps.wipeCaches();
      //
      //       },
      //       onError: (String? error){
      //         // do not blog
      //       }
      //     );
      //
      //   }
      // }

    }

    return _deleted;
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

      final Map<String, dynamic>? _map = {
        'path': file.path,
        'absolute': file.absolute,
        'fileNameWithExtension': file.fileName,
        'runtimeType': file.runtimeType,
        'isAbsolute': file.isAbsolute,
        'parent': file.parent,
        'lengthSync()': getLengthSync(file),
        'file.readAsBytesSync().length': getReadAsBytesSync(file)?.length,
        'toString()': file.toString(),
        'lastAccessedSync()': getLastAccessedSync(file),
        'lastModifiedSync()': getLastModifiedSync(file),
        'existsSync()': file.existsSync(),
        'hashCode': file.hashCode,
      };

      Mapper.blogMap(_map, invoker: invoker,);


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
      if (getLengthSync(file1) != getLengthSync(file2)){
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
          if (getLengthSync(file1) == getLengthSync(file2)){
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

      FileSystemEntityType? _type;

      if (_path != null){
        final File _file = File(_path);
        _exists = await _file.exists();
        final FileStat _stat = await _file.stat();
        _type = _stat.type;
      }

      blog('checkFileExistsByName.type($_type).name($name).exists($_exists).path($_path)');

    }

    return _exists;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS OVERRIDES

  // --------------------
  /// TESTED : WORKS PERFECT
  static int getLengthSync(File? file){
    int _output = 0;

    tryAndCatch(
      invoker: 'getFileLength',
      functions: () async {
        _output = file?.lengthSync() ?? 0;
        },
      onError: (String? error){
        // DO NOT BLOG ERROR
      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List? getReadAsBytesSync(File? file){
    Uint8List? _output;

    tryAndCatch(
      invoker: 'getReadAsBytesSync',
      functions: () async {
        _output = file?.readAsBytesSync();
      },
      onError: (String? error){
        // DO NOT BLOG ERROR
      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? getLastAccessedSync(File? file){
    DateTime? _output;

    tryAndCatch(
      invoker: 'getLastAccessedSync',
      functions: () async {
        _output = file?.lastAccessedSync();
      },
      onError: (String? error){
        // DO NOT BLOG ERROR
      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? getLastModifiedSync(File? file){
    DateTime? _output;

    tryAndCatch(
      invoker: 'getLastModifiedSync',
      functions: () async {
        _output = file?.lastModifiedSync();
      },
      onError: (String? error){
        // DO NOT BLOG ERROR
      },
    );

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FILE INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readFileInfo({
    required File? file,
  }) async {
    Map<String, dynamic>? _output;

    if (file != null){
      final XFile? _xFile = XFiler.readFile(file: file);
      _output = await XFiler.readXFileInfo(
        xFile: _xFile,
      );
    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
