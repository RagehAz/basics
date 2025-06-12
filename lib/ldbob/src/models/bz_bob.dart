// ignore_for_file: avoid_redundant_argument_values, comment_references
part of bob;

@Entity()
class BzBob {
  // --------------------------------------------------------------------------
  BzBob({
    required this.bobID,
    required this.id,
    required this.bzTypes,
    required this.bzForm,
    required this.createdAt,
    required this.power,
    required this.name,
    required this.trigram,
    required this.logoPath,
    required this.scopes,
    required this.zone,
    required this.about,
    required this.position,
    required this.contacts,
    required this.authors,
    required this.pendings,
    required this.showsTeam,
    required this.isVerified,
    required this.bzState,
    required this.publication,
    required this.lastStateChanged,
    required this.lastPicChanged,
    required this.assetsIDs,
    required this.tendersIDs,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String? id;

  final String? bzTypes;
  final String? bzForm;
  final int? createdAt;
  final String? power;
  final String? name;
  final List<String>? trigram;
  final String? logoPath;
  final String? scopes;
  final String? zone;
  final String? about;
  final String? position;
  final String? contacts;
  final String? authors;
  final String? pendings;
  final bool? showsTeam;
  final bool? isVerified;
  final String? bzState;
  final String? publication;
  final int? lastStateChanged;
  final int? lastPicChanged;
  final List<String>? assetsIDs;
  final List<String>? tendersIDs;
  // --------------------------------------------------------------------------
}

/// Model[BzModel] - Bob[BzBob] - Foundation[BzBobFoundation] - Cipher[BzBobCipher] - Ops[BzBobOps]
abstract class BzBobFoundation {
  // --------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Box<BzBob>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<BzBob>();
  }
  // --------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzBob> cleanNullModels(List<BzBob?>? bobs){
    final List<BzBob> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final BzBob? bob in bobs!){

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
  static List<int> getBobsIDs(List<BzBob?>? bobs){
    final List<int> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final BzBob? _bob in bobs!){

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
    required BzBob? bob,
    required String docName,
  }) async {
    bool _success = false;

    if (bob != null){

      await tryAndCatch(
        invoker: r'BzBobFoundation.insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BzBob>? _box = await _getStoreBox(docName);

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
    required List<BzBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true){

      await tryAndCatch(
        invoker: r'BzBobFoundation.insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BzBob>? _box = await _getStoreBox(docName);

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
    required List<BzBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true) {
      await tryAndCatch(
        invoker: r'BzBobFoundation.insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<BzBob>? _box = store.box<BzBob>();
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
  static Future<BzBob?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    BzBob? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: r'BzBobFoundationreadByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BzBob>? _box = await _getStoreBox(docName);
          _output = _box?.get(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<BzBob>> readByBobIDs({
    required List<int> bobsIDs,
    required String docName,
  }) async {
    List<BzBob> _output = [];

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'BzBobFoundation.readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BzBob>? _box = await _getStoreBox(docName);
          _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<BzBob>> readAll({
    required String docName,
  }) async {
    List<BzBob>? _output = [];

    await tryAndCatch(
      invoker: r'BzBobFoundation.readAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<BzBob>? _box = await _getStoreBox(docName);
        _output = cleanNullModels(_box?.getAll());
      },
    );

    return _output ?? [];
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzBob?> findBobByModelID({
    required String? modelID,
    required String docName,
  }) async {
    BzBob? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'BzBobFoundation.findBobByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BzBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<BzBob> _condition = BzBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<BzBob> _query = (_box.query(_condition)..order(BzBob_.id)).build();
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
  static Future<List<BzBob>> findBobsByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    List<BzBob> _output = [];

    if (Lister.checkCanLoop(modelsIDs) == true){

      await tryAndCatch(
        invoker: r'BzBobFoundation.findBobsByModelsIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BzBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<BzBob> _condition = BzBob_.id.oneOf(modelsIDs!,
              /// if it's a string use a case-sensitive condition, to speed up lookups.
              caseSensitive: true,
              // alias:  , // future version thing
            );
            final Query<BzBob> _query = (_box.query(_condition)..order(BzBob_.id)).build();
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
        invoker: r'BzBobFoundation.deleteByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BzBob>? _box = await _getStoreBox(docName);
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

      final BzBob? _bob = await findBobByModelID(
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
        invoker: r'BzBobFoundation.deleteByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BzBob>? _box = await _getStoreBox(docName);
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

    final List<BzBob> _bobs = await findBobsByModelsIDs(
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
      invoker: r'BzBobFoundation.deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<BzBob>? _box = await _getStoreBox(docName);

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
    final Box<BzBob>? _box = await _getStoreBox(docName);
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
        invoker: r'BzBobFoundation.checkExistsByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BzBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<BzBob> _condition = BzBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<BzBob> _query = (_box.query(_condition)..order(BzBob_.id)).build();
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
