part of bob;
// flutter pub run build_runner watch
// dart run build_runner build
class BobInit {
  // -----------------------------------------------------------------------------
  /// local data Base Object Box
  // -----------------------------------------------------------------------------

  /// CLASS SINGLETON

  // --------------------
  BobInit.singleton();
  static final BobInit _singleton = BobInit.singleton();
  static BobInit get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// SHARED STORE
  ///
  /// Every docName used to open its OWN physical ObjectBox store (own
  /// native file/directory), paying the native open/close cost ~10x over
  /// for nothing -- every @Entity() type (UserBob/FlyerBob/BzBob/AvBob/...)
  /// is already generated into ONE shared schema (see objectbox.g.dart), so
  /// a single Store can hold all of them as separate Box<T>s, which is the
  /// idiomatic ObjectBox pattern. The one entity shared across multiple
  /// logical docNames (AvBob -- flyersMedias/bzzMedias/fishMedias/
  /// usersMedias/fcMedias/stolenURLs/phidsPics) already carries its own
  /// `bobDocName` field to keep those apart within the shared Box<AvBob>;
  /// see the filtering added in av_bob.dart. UserBob/FlyerBob/BzBob don't
  /// need that -- each is only ever written under a single fixed docName,
  /// so their own dedicated Box<T> already keeps them naturally separate.

  // --------------------
  static const String _sharedStoreDirName = 'bob';
  // --------------------
  StoreModel? _storeModel;
  // --------------------
  /// concurrent callers await this SAME Completer instead of busy-polling
  /// every 100ms until the store shows up.
  Completer<Store?>? _creationCompleter;
  // -----------------------------------------------------------------------------

  /// GET STORE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Store?> getStoreRecursive({
    required String docName,
  }) async {
    /// docName is intentionally unused here now -- every caller shares the
    /// one store. Kept as a parameter so no call site needs to change.

    if (_storeModel != null){
      return _storeModel!.store;
    }

    /// ALREADY BEING OPENED BY ANOTHER CALLER -- WAIT ON THE SAME COMPLETER
    final Completer<Store?>? _inProgress = _creationCompleter;
    if (_inProgress != null){
      return _inProgress.future;
    }

    final Completer<Store?> _completer = Completer<Store?>();
    _creationCompleter = _completer;

    try {

      final StoreModel? _newStoreModel = await StoreModel.createNewModel(
          docName: _sharedStoreDirName
      );

      _storeModel = _newStoreModel;

      _completer.complete(_newStoreModel?.store);

    }
    catch (error, stackTrace){
      _completer.completeError(error, stackTrace);
    }
    finally {
      _creationCompleter = null;
    }

    return _completer.future;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Store?> getTheStore(String docName) async {
    Store? _store;

    await tryAndCatch(
      invoker: 'getTheStore',
      timeout: 5,
      functions: () async {
        _store = await BobInit.instance.getStoreRecursive(docName: docName);
        },
    );

    return _store;
  }
  // -----------------------------------------------------------------------------

  /// CLOSE STORE

  // --------------------
  ///
  Future<void> closeStore() async {

    if (_storeModel != null){

      await tryAndCatch(
        invoker: 'BobInit.closeStore',
        functions: () async {

          _storeModel!.store.close();
          _storeModel = null;

        },
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  /// [docName] is unused now (kept so any existing call site still
  /// compiles) -- there's only one shared store to close.
  static Future<void> closeTheStore([String? docName]) async {
    await BobInit.instance.closeStore();
    blog('closed BOB');
  }
  // -----------------------------------------------------------------------------
}
