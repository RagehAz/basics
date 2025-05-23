// ignore_for_file: avoid_redundant_argument_values, unused_element
part of bob;
/// GREAT
@Entity()
class AvBob {
  // -----------------------------------------------------------------------------
  AvBob({
    required this.bobID,
    required this.id,
    required this.xFilePath,
    required this.ownersIDs,
    required this.width,
    required this.height,
    required this.nameWithExtension,
    required this.nameWithoutExtension,
    required this.sizeMB,
    required this.sizeB,
    required this.mime,
    required this.data,
    required this.uploadPath,
    required this.origin,
    required this.originalURL,
    required this.caption,
    required this.durationMs,
    required this.bobDocName,
    required this.originalXFilePath,
    required this.lastEdit,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String id;
  final String uploadPath;

  // @Property(type: PropertyType.float, signed: false)
  final double? width;

  // @Property(type: PropertyType.float, signed: false)
  final double? height;

  // @Property(type: PropertyType.float, signed: false)
  final double? sizeMB;

  // @Property(type: PropertyType.int, signed: false)
  final int? sizeB;

  // @Index(type: IndexType.hash)
  final String? originalURL;

  final String? nameWithExtension;
  final String? nameWithoutExtension;
  final String? xFilePath;
  final List<String>? ownersIDs;
  final String? mime;
  final String? origin;
  final String? caption;
  final String? data;
  final int? durationMs;
  final String bobDocName;
  final String? originalXFilePath;

  final int? lastEdit;
  // --------------------------------------------------------------------------
}

/// Model[AvModel] - Bob[AvBob] - Foundation[_AvFoundation] - Cipher[_AvCipher] - Ops[AvBobOps]
abstract class _AvFoundation {
  // --------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Box<AvBob>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<AvBob>();
  }
  // --------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AvBob> cleanNullModels(List<AvBob?>? bobs){
    final List<AvBob> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final AvBob? bob in bobs!){

        if (bob != null){
          _output.add(bob);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int> getBobsIDs(List<AvBob?>? bobs){
    final List<int> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final AvBob? _bob in bobs!){

        if (_bob?.bobID != null && _bob!.bobID > 0){
          _output.add(_bob.bobID);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insert({
    required AvBob? bob,
    required String docName,
  }) async {
    bool _success = false;

    if (bob != null){

      await tryAndCatch(
        invoker: r'AvFoundation.insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<AvBob>? _box = await _getStoreBox(docName);

          if (_box != null){

            final int? _newBobID = _box.put(bob);

            if (_newBobID != null && _newBobID > 0){
              _success = true;
            }

          }

        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMany({
    required List<AvBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true){

      await tryAndCatch(
        invoker: r'AvFoundation.insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<AvBob>? _box = await _getStoreBox(docName);

          if (_box != null){

            final List<int>? _ids = _box.putMany(
              bobs,
              mode: PutMode.insert,
            );

            _success = Lister.superLength(_ids) == bobs.length;

          }

        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertManyTransaction({
    required List<AvBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true) {
      await tryAndCatch(
        invoker: r'AvFoundation.insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<AvBob>? _box = store.box<AvBob>();
              final List<int>? ids = _box?.putMany(bobs, mode: PutMode.insert);
              return ids;
            }

            final List<int>? _ids = await _store.runInTransactionAsync<List<int>?, int>(TxMode.write, _function, 0);

            _success = _ids != null && _ids.length == bobs.length;
          }

        },
      );
    }

    return _success;
  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvBob?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    AvBob? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: r'AvFoundationreadByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<AvBob>? _box = await _getStoreBox(docName);
          _output = _box?.get(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<AvBob>> readByBobIDs({
    required List<int> bobsIDs,
    required String docName,
  }) async {
    List<AvBob> _output = [];

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'AvFoundation.readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<AvBob>? _box = await _getStoreBox(docName);
          _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvBob>> readAll({
    required String docName,
  }) async {
    List<AvBob>? _output = [];

    await tryAndCatch(
      invoker: r'AvFoundation.readAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<AvBob>? _box = await _getStoreBox(docName);
        _output = cleanNullModels(_box?.getAll());
      },
    );

    return _output ?? [];
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvBob?> findBobByModelID({
    required String? modelID,
    required String docName,
  }) async {
    AvBob? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'AvFoundation.findBobByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<AvBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<AvBob> _condition = AvBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<AvBob> _query = (_box.query(_condition)..order(AvBob_.id)).build();
            _output =  _query.findUnique();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FIND MANY

  // --------------------
  ///
  static Future<List<AvBob>> findBobsByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    List<AvBob> _output = [];

    if (Lister.checkCanLoop(modelsIDs) == true){

      await tryAndCatch(
        invoker: r'AvFoundation.findBobsByModelsIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<AvBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<AvBob> _condition = AvBob_.id.oneOf(modelsIDs!,
              /// if it's a string use a case-sensitive condition, to speed up lookups.
              caseSensitive: true,
              // alias:  , // future version thing
            );
            final Query<AvBob> _query = (_box.query(_condition)..order(AvBob_.id)).build();
            _output = _query.find();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByBobID({
    required int? bobID,
    required String docName,
  }) async {
    bool? _success = false;

    if (bobID != null){
      await tryAndCatch(
        invoker: r'AvFoundation.deleteByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<AvBob>? _box = await _getStoreBox(docName);
          _success = _box?.remove(bobID);
        },
      );
    }

    return _success ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByModeID({
    required String? modelID,
    required String docName,
  }) async {
    bool _success = false;

    if (modelID != null) {

      final AvBob? _bob = await findBobByModelID(
        modelID: modelID,
        docName: docName,
      );

      if (_bob == null){
        _success = true;
      }
      else {
        _success = await deleteByBobID(
          bobID: _bob.bobID,
          docName: docName,
        );
      }

    }

    return _success;
  }
  // --------------------------------------------------------------------------

  /// DELETE MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByBobIDs({
    required List<int>? bobsIDs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'AvFoundation.deleteByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<AvBob>? _box = await _getStoreBox(docName);
          final int? _countRemoved = _box?.removeMany(bobsIDs!);
          _success = bobsIDs!.length == _countRemoved;
        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {

    final List<AvBob> _bobs = await findBobsByModelsIDs(
      modelsIDs: modelsIDs,
      docName: docName,
    );

    return deleteByBobIDs(
      bobsIDs: getBobsIDs(_bobs),
      docName: docName,
    );

  }
  // --------------------------------------------------------------------------

  /// DELETE ALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAll({
    required String docName,
  }) async {
    bool _success = false;

    await tryAndCatch(
      invoker: r'AvFoundation.deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<AvBob>? _box = await _getStoreBox(docName);

        if (_box != null){
          final int _count = _box.removeAll();
          _success = _count >= 0;
        }

      },
    );

    return _success;
  }
  // --------------------------------------------------------------------------

  /// COUNT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int?> countItemsInBob({
    required String docName,
  }) async {
    final Box<AvBob>? _box = await _getStoreBox(docName);
    return _box?.count();
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExistsByModelID({
    required String? modelID,
    required String docName,
  }) async {
    bool _output = false;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'AvFoundation.checkExistsByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<AvBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<AvBob> _condition = AvBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<AvBob> _query = (_box.query(_condition)..order(AvBob_.id)).build();
            final int _count = _query.count();
            _output = _count > 0;
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}

/// GREAT
abstract class _AvCipher {
  // --------------------------------------------------------------------------

  /// SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static AvBob? toBob({
    required AvModel? model,
  }){
    AvBob? _output;

    if (model != null){

      _output = AvBob(
        bobID: 0,
        id: model.id,
        xFilePath: model.xFilePath,
        ownersIDs: model.ownersIDs,
        width: model.width,
        height: model.height,
        nameWithExtension: model.nameWithExtension,
        nameWithoutExtension: model.nameWithoutExtension,
        sizeMB: model.sizeMB,
        sizeB: model.sizeB,
        mime: FileMiming.getMimeByType(model.fileExt),
        data: jsonEncode(model.data),
        uploadPath: model.uploadPath,
        origin: AvCipher.cipherAvOrigin(model.origin),
        originalURL: model.originalURL,
        caption: model.caption,
        durationMs: model.durationMs,
        bobDocName: model.bobDocName,
        originalXFilePath: model.originalXFilePath,
        lastEdit: Timers.cipherDateTimeToInt(time: model.lastEdit),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AvModel? toModel({
    required AvBob? bob,
  }){
    AvModel? _output;

    if (bob != null){

      _output = AvModel(
        id: bob.id,
        xFilePath: bob.xFilePath,
        ownersIDs: bob.ownersIDs,
        width: bob.width,
        height: bob.height,
        nameWithoutExtension: bob.nameWithoutExtension,
        nameWithExtension: bob.nameWithExtension,
        sizeMB: bob.sizeMB,
        sizeB: bob.sizeB,
        fileExt: FileMiming.getTypeByMime(bob.mime),
        data: MapperSS.createStringStringMap(hashMap: jsonDecode(bob.data ?? ''), stringifyNonStrings: true),
        uploadPath: bob.uploadPath,
        origin: AvCipher.decipherAvOrigin(bob.origin),
        originalURL: bob.originalURL,
        caption: bob.caption,
        durationMs: bob.durationMs,
        bobDocName: bob.bobDocName,
        originalXFilePath: bob.originalXFilePath,
        lastEdit: Timers.decipherIntToDateTime(integer: bob.lastEdit),
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AvBob> toBobs({
    required List<AvModel> models,
  }){
    final List<AvBob> _output = [];

    if (Lister.checkCanLoop(models) == true){

      for (final AvModel avModel in models){

        final AvBob? _bob = toBob(model: avModel);

        if (_bob != null){
          _output.add(_bob);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AvModel> toModels({
    required List<AvBob> bobs,
  }){
    final List<AvModel> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final AvBob bob in bobs){

        final AvModel? _model = toModel(bob: bob);

        if (_model != null){
          _output.add(_model);
        }

      }

    }

    return _output;
  }
// --------------------------------------------------------------------------
}

/// GREAT
abstract class AvBobOps {
  // --------------------------------------------------------------------------
  static DirectoryType avDirectory = DirectoryType.app;
  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insert({
    required AvModel? model,
    required String docName,
  }) async {
    return _AvFoundation.insert(
      bob: _AvCipher.toBob(model: model),
      docName: docName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMany({
    required List<AvModel> models,
    required String docName,
  }) async {
    return _AvFoundation.insertMany(
      bobs: _AvCipher.toBobs(models: models),
      docName: docName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertManyTransaction({
    required List<AvModel> models,
    required String docName,
  }) async {
    return _AvFoundation.insertManyTransaction(
      bobs: _AvCipher.toBobs(models: models),
      docName: docName,
    );
  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> readAll({
    required String docName,
  }) async {
    final List<AvBob> _bobs = await _AvFoundation.readAll(
      docName: docName,
    );
    return _AvCipher.toModels(bobs: _bobs);
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> findByModelID({
    required String? modelID,
    required String docName,
  }) async {
    final AvBob? _bob = await _AvFoundation.findBobByModelID(
      docName: docName,
      modelID: modelID,
    );
    return _AvCipher.toModel(bob: _bob);
  }
  // --------------------------------------------------------------------------

  /// FIND MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AvModel>> findByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    final List<AvBob> _bobs = await _AvFoundation.findBobsByModelsIDs(
      docName: docName,
      modelsIDs: modelsIDs,
    );
    return _AvCipher.toModels(bobs: _bobs);
  }
  // --------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> delete({
    required String? modelID,
    required String docName,
  }) async {
    return _AvFoundation.deleteByModeID(
      docName: docName,
      modelID: modelID,
    );
  }
  // --------------------------------------------------------------------------

  /// DELETE MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMany({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    return _AvFoundation.deleteByModelsIDs(
      docName: docName,
      modelsIDs: modelsIDs,
    );
  }
  // --------------------------------------------------------------------------

  /// DELETE ALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAll({
    required String docName,
  }) async {
    return _AvFoundation.deleteAll(
      docName: docName,
    );
  }
  // --------------------------------------------------------------------------

  /// COUNT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> count({
    required String docName,
  }) async {
    final int? _count = await _AvFoundation.countItemsInBob(
      docName: docName,
    );
    return _count ?? 0;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists({
    required String? modelID,
    required String docName,
  }) async {
    return _AvFoundation.checkExistsByModelID(
      docName: docName,
      modelID: modelID,
    );
  }
  // --------------------------------------------------------------------------
}
