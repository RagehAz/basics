// ignore_for_file: avoid_redundant_argument_values, comment_references
part of bob;

@Entity()
class UserBob {
  // --------------------------------------------------------------------------
  UserBob({
    required this.bobID,
    required this.id,
    required this.signInMethod,
    required this.isSignedUp,
    required this.createdAt,
    required this.need,
    required this.name,
    required this.trigram,
    required this.picPath,
    required this.title,
    required this.company,
    required this.gender,
    required this.zone,
    required this.language,
    required this.location,
    required this.contacts,
    required this.contactsArePublic,
    required this.myBzzIDs,
    required this.isAuthor,
    required this.emailIsVerified,
    required this.isAdmin,
    required this.device,
    required this.fcmTopics,
    required this.savedFlyers,
    required this.followedBzz,
    required this.lastSeen,
    required this.appState,
    required this.tendersIDs,
  });
  // --------------------------------------------------------------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String? id;

  final String? signInMethod;
  final bool? isSignedUp;
  final int? createdAt;
  final String? need;
  final String? name;
  final List<String>? trigram;
  final String? picPath;
  final String? title;
  final String? company;
  final String? gender;
  final String? zone;
  final String? language;
  final String? location;
  final String? contacts;
  final bool? contactsArePublic;
  final List<String>? myBzzIDs;
  final bool? isAuthor;
  final bool? emailIsVerified;
  final bool? isAdmin;
  final String? device;
  final List<String>? fcmTopics;
  final String? savedFlyers;
  final String? followedBzz;
  final String? appState;
  final int? lastSeen;
  final List<String>? tendersIDs;
  // -----------------------------------------------------------------------------
}

/// Model[UserModel] - Bob[UserBob] - Foundation[_UserBobFoundation] - Cipher[UserBobCipher] - Ops[UserBobOps]
abstract class UserBobFoundation {
  // --------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Box<UserBob>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<UserBob>();
  }
  // --------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserBob> cleanNullModels(List<UserBob?>? bobs){
    final List<UserBob> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final UserBob? bob in bobs!){

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
  static List<int> getBobsIDs(List<UserBob?>? bobs){
    final List<int> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final UserBob? _bob in bobs!){

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
    required UserBob? bob,
    required String docName,
  }) async {
    bool _success = false;

    if (bob != null){

      await tryAndCatch(
        invoker: r'_UserBobFoundation.insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<UserBob>? _box = await _getStoreBox(docName);

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
    required List<UserBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true){

      await tryAndCatch(
        invoker: r'_UserBobFoundation.insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<UserBob>? _box = await _getStoreBox(docName);

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
    required List<UserBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true) {
      await tryAndCatch(
        invoker: r'_UserBobFoundation.insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<UserBob>? _box = store.box<UserBob>();
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
  static Future<UserBob?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    UserBob? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: r'_UserBobFoundationreadByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<UserBob>? _box = await _getStoreBox(docName);
          _output = _box?.get(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<UserBob>> readByBobIDs({
    required List<int> bobsIDs,
    required String docName,
  }) async {
    List<UserBob> _output = [];

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'_UserBobFoundation.readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<UserBob>? _box = await _getStoreBox(docName);
          _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserBob>> readAll({
    required String docName,
  }) async {
    List<UserBob>? _output = [];

    await tryAndCatch(
      invoker: r'_UserBobFoundation.readAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<UserBob>? _box = await _getStoreBox(docName);
        _output = cleanNullModels(_box?.getAll());
      },
    );

    return _output ?? [];
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserBob?> findBobByModelID({
    required String? modelID,
    required String docName,
  }) async {
    UserBob? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'_UserBobFoundation.findBobByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<UserBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<UserBob> _condition = UserBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<UserBob> _query = (_box.query(_condition)..order(UserBob_.id)).build();
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
  static Future<List<UserBob>> findBobsByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    List<UserBob> _output = [];

    if (Lister.checkCanLoop(modelsIDs) == true){

      await tryAndCatch(
        invoker: r'_UserBobFoundation.findBobsByModelsIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<UserBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<UserBob> _condition = UserBob_.id.oneOf(modelsIDs!,
              /// if it's a string use a case-sensitive condition, to speed up lookups.
              caseSensitive: true,
              // alias:  , // future version thing
            );
            final Query<UserBob> _query = (_box.query(_condition)..order(UserBob_.id)).build();
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
        invoker: r'_UserBobFoundation.deleteByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<UserBob>? _box = await _getStoreBox(docName);
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

      final UserBob? _bob = await findBobByModelID(
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
        invoker: r'_UserBobFoundation.deleteByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<UserBob>? _box = await _getStoreBox(docName);
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

    final List<UserBob> _bobs = await findBobsByModelsIDs(
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
      invoker: r'_UserBobFoundation.deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<UserBob>? _box = await _getStoreBox(docName);

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
    final Box<UserBob>? _box = await _getStoreBox(docName);
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
        invoker: r'_UserBobFoundation.checkExistsByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<UserBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<UserBob> _condition = UserBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<UserBob> _query = (_box.query(_condition)..order(UserBob_.id)).build();
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
