part of filing;
/// => TAMAM
class XFiler {
  // -----------------------------------------------------------------------------

  const XFiler();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createEmptyFile({
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

      final String? _filePath = await FilePathing.createPathByName(
        fileName: fileName,
        directoryType: directoryType,
      );

      if (_filePath != null) {

        /// ONLY FOR WINDOWS,MAKE SURE DIRECTORY PATH EXISTS
        if (DeviceChecker.deviceIsWindows() == true) {
          final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
            text: _filePath,
            specialCharacter: FilePathing.slash,
          )!;
          await Directory(_pathWithoutDocName).create(recursive: true);
        }

        final Uint8List? _emptyData = Byter.fromInts([]);
        _output = await createFromBytes(
          bytes: _emptyData,
          fileName: fileName,
          directoryType: directoryType,
        );


      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromBytes({
    required Uint8List? bytes,
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _output;

    final String? _fileName = FileTyper.fixFileName(
      fileName: fileName,
      bytes: bytes,
    );

    if (_fileName != null && bytes != null){

      await tryAndCatch(
        invoker: 'XFiler.createByBytes',
        functions: () async {

          final String? _filePath = await FilePathing.createPathByName(
            fileName: _fileName,
            directoryType: directoryType,
          );

          if (_filePath != null){

            /// FILE REF
            _output = XFile(
              _filePath,
              bytes: bytes,
              name: _fileName,
            );

            /// DELETE EXISTING FILE IF EXISTED
            await deleteFile(_output);

            /// CREATE
            _output = XFile.fromData(
              bytes,
              path: _filePath,
              name: _fileName,
              // lastModified: ,
              // length: ,
              // mimeType: ,
              // overrides: ,
            );

            await _output!.saveTo(_filePath);

          }

        },
      );


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromLocalAsset({
    required String? localAsset,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    final Uint8List? _bytes = await Byter.fromLocalAsset(
      localAsset: localAsset,
      // width: width,
    );

    final String? _fileName = FilePathing.getNameFromFilePath(
      filePath: localAsset,
      withExtension: true,
    );

    return createFromBytes(
      fileName: _fileName,
      bytes: _bytes,
      directoryType: directoryType,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromURL({
    required String? url,
    required String? fileName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _output;

    if (fileName != null && url != null){

      final Uint8List? _bytes = await Byter.fromURL(url);

      _output = await createFromBytes(
        bytes: _bytes,
        fileName: fileName,
        directoryType: directoryType,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createFromAssetEntity({
    required AssetEntity? assetEntity,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _output;

    /// ASSET_ENTITY_JOB
    await Entities.blogAssetEntity(entity: assetEntity, invoker: 'readAssetEntity');

    if (assetEntity != null){

      final Uint8List? _originBytes = await assetEntity.originBytes;
      final String? _fileName = TextMod.removeTextAfterLastSpecialCharacter(
          text: assetEntity.title,
          specialCharacter: '.',
      );

      _output = await createFromBytes(
        bytes: _originBytes,
        fileName: _fileName,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> cloneFile({
    required XFile? file,
    required String? newName,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _output;

    if (file != null && newName != null && newName != file.fileName){

      await tryAndCatch(
        invoker: 'XFiler.cloneFile',
        functions: () async {

          final Uint8List? _originalBytes = await file.readAsBytes();

          if (_originalBytes != null){

            _output = await createFromBytes(
              bytes: _originalBytes,
              fileName: newName,
              directoryType: directoryType,
            );

          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<XFile>> readAllDirectoryFiles({
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
  static List<XFile> readFiles({
    required List<String> filesPaths,
  }){
    final List<XFile> _output = [];

    if (Lister.checkCanLoop(filesPaths) == true){

      for (final String path in filesPaths){
        final XFile _file = XFile(path);
        _output.add(_file);
      }

    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static XFile? readFile({
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
  static Future<XFile?> readByName({
    required String? name,
    DirectoryType directoryType = DirectoryType.app,
  }) async {
    XFile? _file;

    final String? _path = await Director.findFilePathByName(
      name: name,
    );

    if (_path != null){

      _file = XFile(_path);

    }

    return _file;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> replaceBytes({
    required XFile? file,
    required Uint8List? bytes,
  }) async {
    XFile? _output;

    if (bytes == null || file == null){
      /// DO NOTHING
    }

    else {

      final DirectoryType? _originalDirectory = await Director.concludeDirectoryFromFilePath(
          filePath: file.path,
      );

      if (_originalDirectory != null){

        final String? _fileName = file.fileName;

        _output = await createFromBytes(
          bytes: bytes,
          fileName: _fileName,
          directoryType: _originalDirectory,
        );

      }

      return _output;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> renameFile({
    required XFile? file,
    required String? newName,
  }) async {
    XFile? _output = file;

    if (file != null && newName != null && newName != file.fileName){

      final DirectoryType? _directoryType = await Director.concludeDirectoryFromFilePath(
        filePath: file.path,
      );

      if (_directoryType != null){

        await tryAndCatch(
          invoker: 'XFiler.renameFile',
          functions: () async {

            final Uint8List _originalBytes = await file.readAsBytes();

            await deleteFile(file);

            _output = await createFromBytes(
              bytes: _originalBytes,
              fileName: newName,
              directoryType: _directoryType,
            );

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
  static Future<void> deleteFile(XFile? file) async {

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
            invoker: 'XFiler.deleteFile',
            functions: () async {

              await Directory(file.path).delete(recursive: true);
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
        await deleteFile(XFile(_path));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFiledByNames({
    required List<String> names,
    DirectoryType directoryType = DirectoryType.app,
  }) async {

    if (Lister.checkCanLoop(names) == true){

      await Future.wait(<Future>[

        ...List.generate(names.length, (index){

          return deleteFileByName(
            name: names[index],
            directoryType: directoryType,
          );

        }),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFiles(List<XFile> files) async {

    if (Lister.checkCanLoop(files) == true){

      for (final XFile file in files){

        await deleteFile(file);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
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

      _exists = _path != null;

    }

    // final String? _path = await FilePathing.createPathByName(
    //   fileName: name,
    //   directoryType: directoryType,
    // );
    //
    // if (_path != null){
    //
    //   await tryAndCatch(
    //       invoker: 'XFiler.checkFileExistsByName',
    //       onError: (String error){
    //         // to ignore blogs
    //       },
    //       functions: () async {
    //
    //         final int? _length = await XFile(_path).length();
    //
    //         if (_length != null){
    //           _exists = true;
    //         }
    //
    //       },
    //   );
    //
    // }

    blog('checkFileExistsByName : _exists : $_exists aho ');

    return _exists;
  }
  // -----------------------------------------------------------------------------
}
