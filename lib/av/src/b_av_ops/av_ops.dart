part of av;
/// => GREAT
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
    Map<String, String>? headers,
  }) async {
    return _AvFromUrl.createSingle(url: url, headers: headers, data: data);
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

  /// CLONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> cloneAv({
    required AvModel? avModel,
    required String uploadPath,
    String? bobDocName,
    List<String>? ownersIDs,
  }) async {
    return _AvClone.cloneAv(
      avModel: avModel,
      uploadPath: uploadPath,
      bobDocName: bobDocName,
      ownersIDs: ownersIDs,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> cloneAvWithNewName({
    required AvModel? avModel,
    required String? newName,
    String? bobDocName,
  }) async {
    return _AvClone.cloneAvWithNewName(
      avModel: avModel,
      newName: newName,
      bobDocName: bobDocName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> cloneFileToHaveExtension({
    required AvModel avModel,
  }) async {
    return _AvClone.cloneFileToHaveExtension(
        avModel: avModel,
    );
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> overrideBytes({
    required Uint8List? bytes,
    required Dimensions? newDims,
    required AvModel? avModel,
  }) async {
    return _AvUpdate.overrideBytes(
      bytes: bytes,
      newDims: newDims,
      avModel: avModel,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> renameFile({
    required AvModel? avModel,
    required String? newName,
  }) async {
    return _AvUpdate.renameFile(
      newName: newName,
      avModel: avModel,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> overrideUploadPath({
    required AvModel? avModel,
    required String? newUploadPath,
  }) async {
    return _AvUpdate.overrideUploadPath(
      newUploadPath: newUploadPath,
      avModel: avModel,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> completeAv({
    required AvModel? avModel,
    required Uint8List? bytesIfExisted,
  }) async {
    return _AvUpdate.completeAv(
      bytesIfExisted: bytesIfExisted,
      avModel: avModel,
    );
  }
  // -----------------------------------------------------------------------------

  /// MOVE TO BOB

  // --------------------
  ///
  static Future<AvModel?> moveToBob({
    required AvModel? avModel,
    required String? bobDocName,
  }) async {
    return _AvUpdate.moveToBob(
      bobDocName: bobDocName,
      avModel: avModel,
    );
  }
  // -----------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteSingle({
    required String docName,
    required String? uploadPath
  }) async {
    return _AvDelete.deleteSingle(uploadPath: uploadPath, docName: docName);
  }
  // -----------------------------------------------------------------------------

  /// DELETE MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists({
    required String docName,
    required String? uploadPath,
  }) async {
    return _AvRead.checkExists(
      uploadPath: uploadPath,
    );
  }
  // -----------------------------------------------------------------------------
}
