part of av;

/// => TAMAM
abstract class AvOps {
  // -----------------------------------------------------------------------------

  /// CREATE SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromBytes({
    required Uint8List? bytes,
    required CreateSingleAVConstructor data,
  }) async {
      return _AvFromBytes.createSingle(bytes: bytes, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromAssetEntity({
    required AssetEntity? entity,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromAssetEntity.createSingle(entity: entity, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromLocalAsset({
    required String? localAsset,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromLocalAsset.createSingle(localAsset: localAsset, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromXFile({
    required XFile? xFile,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromXFile.createSingle(xFile: xFile, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromFile({
    required File? file,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromFile.createSingle(file: file, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> createFromURL({
    required String? url,
    required CreateSingleAVConstructor data,
  }) async {
    return _AvFromUrl.createSingle(url: url, data: data);
  }
  // -----------------------------------------------------------------------------

  /// CREATE MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromBytesList({
    required List<Uint8List> bytesList,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromBytes.createMany(bytesList: bytesList, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromAssetsEntities({
    required List<AssetEntity>? entities,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromAssetEntity.createMany(entities: entities, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromLocalAssets({
    required List<String> localAssets,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromLocalAsset.createMany(localAssets: localAssets, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromXFiles({
    required List<XFile>? files,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromXFile.createMany(files: files, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromURLs({
    required List<String>? urls,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromUrl.createMany(urls: urls, data: data);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> createFromFiles({
    required List<File>? files,
    required CreateMultiAVConstructor data,
  }) async {
    return _AvFromFile.createMany(files: files, data: data);
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST_ME
  static Future<AvModel?> readSingle({
    required String docName,
    required String? uploadPath,
    required bool skipMeta,
  }) async {

    final AvModel? _output = await _AvRead.readSingle(
      uploadPath: uploadPath,
      skipMeta: skipMeta,
      docName: docName,
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ MULTIPLE

  // --------------------
  /// TASK : TEST_ME
  static Future<List<AvModel>> readMany({
    required String docName,
    required List<String> uploadPaths,
    required bool skipMeta,
    Function(AvModel avModel)? onRead,
  }) async {

    return _AvRead.readMany(
      skipMeta: skipMeta,
      uploadPaths: uploadPaths,
      docName: docName,
      onRead: onRead,
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  /// TASK : TEST_ME
  static Future<bool> deleteSingle({
    required String docName,
    required String? uploadPath
  }) async {
    return _AvDelete.deleteSingle(uploadPath: uploadPath, docName: docName);
  }
  // -----------------------------------------------------------------------------

  /// DELETE MULTIPLE

  // --------------------
  /// TASK : TEST_ME
  static Future<bool> deleteMany({
    required String docName,
    required List<String> uploadPaths,
  }) async {

    return _AvDelete.deleteMany(
        uploadPaths: uploadPaths,
        docName: docName
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE ALL

  // --------------------
  /// TASK : TEST_ME
  static Future<bool> deleteAll({
    required String docName,
  }) async {
    return _AvDelete.deleteAll(
        docName: docName
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TASK : TEST_ME
  static Future<bool> checkExists({
    required String docName,
    required String uploadPath,
  }) async {
    return _AvRead.checkExists(
      uploadPath: uploadPath,
    );
  }
  // -----------------------------------------------------------------------------
}
