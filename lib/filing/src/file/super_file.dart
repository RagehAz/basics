part of filing;
/// => TAMAM
@immutable
class SuperFile {
  // -----------------------------------------------------------------------------
  const SuperFile(this.path);
  // --------------------
  /// EXAMPLE : 'LDBDocName/fileName.ext'
  final String path;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String primaryKey = 'fileName';
  static const String folderName = 'superFiles';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///  TESTED : WORKS PERFECT
  SuperFile _copyWith({
    String? path,
  }){
    return SuperFile(path ?? this.path);
  }
  // -----------------------------------------------------------------------------

  /// PATHING

  // --------------------
  ///  TESTED : WORKS PERFECT
  String? getFileName({
    required bool withExtension,
  }){

    return FileNaming.getNameFromPath(
        path: path,
        withExtension: withExtension
    );

  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  String? getFolderName(){
    return TextMod.removeTextAfterFirstSpecialCharacter(
        text: path,
        specialCharacter: '/',
    );
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static String? _createPath({
    required String? folderName,
    required String? fileName,
  }){

    if (folderName == null || fileName == null){
      return null;
    }
    else {
      return '$folderName/$fileName';
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<SuperFile?> _create({
    required Uint8List? bytes,
  }) async {
    bool _success = false;

    if (bytes != null){

      _success = await LDBOps.insertMap(
        docName: getFolderName(),
        primaryKey: primaryKey,
        input: {
          primaryKey: getFileName(withExtension: false),
          'bytes': Byter.intsFromBytes(bytes),
        },
        // allowDuplicateIDs: false,
      );

      // blog('_create : _success : $_success');

    }

    return _success == true ? this : null;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<SuperFile?> createFromBytes({
    required String? name,
    required Uint8List? bytes,
    String folder = folderName,
  }) async {
    SuperFile? _output;

    if (name != null && bytes != null){

      final String? _path = _createPath(
        fileName: name,
        folderName: folder,
      );

      // blog('createFromBytes : _path : $_path');

      if (_path != null){
        _output = await SuperFile(_path)._create(
          bytes: bytes,
        );
      }

    }


    return _output;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<SuperFile?> createFromLocalAsset({
    required String? localAsset,
    String folder = folderName,
    String? renameFile,
  }) async {
    SuperFile? _output;

    if (localAsset != null){

      final Uint8List? _bytes = await Byter.fromLocalAsset(
          localAsset: localAsset,
      );
      final String? _fileName = renameFile ?? FileNaming.getNameFromLocalAsset(localAsset);

      if (_bytes != null && _fileName != null){

        _output = await createFromBytes(
          folder: folder,
          name: _fileName,
          bytes: _bytes,
        );

      }

    }

    return _output;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Future<SuperFile?> createFromURL({
    required String? url,
    String? fileName,
    String folder = folderName,
  }) async {
    SuperFile? _output;

    if (url != null){

      final Uint8List? _bytes = await Byter.fromURL(url);
      final String? _fileName = fileName ?? Idifier.idifyString(url);

      if (_bytes != null && _fileName != null){

        _output = await createFromBytes(
          folder: folder,
          name: _fileName,
          bytes: _bytes,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<SuperFile?> createFromAssetEntity({
    required AssetEntity? assetEntity,
    String folder = folderName,
  }) async {
    SuperFile? _output;

    if (assetEntity != null){

      final Uint8List? _originBytes = await assetEntity.originBytes;
      final String? _fileName = TextMod.removeTextAfterLastSpecialCharacter(
        text: assetEntity.title,
        specialCharacter: '.',
      );

      _output = await createFromBytes(
        bytes: _originBytes,
        name: _fileName,
        folder: folder,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<Uint8List?> readBytes() async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: getFolderName(),
        id: getFileName(withExtension: false),
        primaryKey: primaryKey,
    );

    return Byter.fromInts(_map?['bytes']);
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<int> length() async {

    final Uint8List? _bytes = await readBytes();

    return _bytes?.length ?? 0;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<double?> readSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {
    final Uint8List? _bytes = await readBytes();
    return FileSizer.calculateSize(_bytes?.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Dimensions?> readDimensions() async {
    final Dimensions? _dims =  await DimensionsGetter.fromSuperFile(
      file: this,
    );
    return _dims;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<SuperFile?> rename({
    required String? newName,
  }) async {
    SuperFile? _output;

    final String? _oldName = getFileName(withExtension: false);

    if (newName != null && newName != _oldName){

      final String? _newName = TextMod.removeTextAfterLastSpecialCharacter(
        text: newName,
        specialCharacter: '.',
      );

      if (TextCheck.isEmpty(_newName) == false && _newName != _oldName){

        final String? _newPath = _createPath(
          folderName: getFolderName(),
          fileName: _newName,
        );

        if (_newPath != null){

          final Map<String, dynamic>? _map = await LDBOps.readMap(
            docName: getFolderName(),
            id: _oldName,
            primaryKey: primaryKey,
          );

          if (_map != null){

            final bool _success = await LDBOps.insertMap(
              docName: getFolderName(),
              primaryKey: primaryKey,
              input: {
                primaryKey: FileNaming.getNameFromPath(
                  path: _newPath,
                  withExtension: false,
                ),
                'bytes': _map['bytes'],
              },
              // allowDuplicateIDs: false,
            );

            if (_success == true){

              await delete();

              _output = _copyWith(
                path: _newPath,
              );

            }

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<SuperFile?> replaceBytes({
    required Uint8List? bytes,
  }) async {
    return _create(bytes: bytes);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<void> delete() async {

    await LDBOps.deleteMap(
        docName: getFolderName(),
        primaryKey: primaryKey,
        objectID: getFileName(withExtension: false),
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///  TESTED : WORKS PERFECT
  static bool checkFilesAreIdentical({
    required SuperFile? file1,
    required SuperFile? file2,
  }){
    return file1?.path == file2?.path;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  Future<bool> exists() async {
    return LDBOps.checkMapExists(
        docName: getFolderName(),
        primaryKey: primaryKey,
        id: getFileName(withExtension: false),
    );
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString(){
    return 'SuperFile($path)';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is SuperFile){
      _areIdentical = checkFilesAreIdentical(
        file1: this,
        file2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode => path.hashCode;
  // -----------------------------------------------------------------------------
}
