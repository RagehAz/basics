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

  /// DATABASE SINGLETON

  // --------------------
  final List<StoreModel> _stores = [];
  // --------------------
  /// one Completer per docName currently being opened -- concurrent callers
  /// await the SAME Completer instead of busy-polling every 100ms until it
  /// shows up in _stores.
  final Map<String, Completer<Store?>> _storeCreationCompleters = {};
  // -----------------------------------------------------------------------------

  /// GET STORE

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Store?> getStoreRecursive({
    required String docName,
  }) async {

    final StoreModel? _cachedStoreModel = StoreModel.getStoreByDocName(
      stores: _stores,
      docName: docName,
    );

    if (_cachedStoreModel != null){
      return _cachedStoreModel.store;
    }

    /// ALREADY BEING OPENED BY ANOTHER CALLER -- WAIT ON THE SAME COMPLETER
    final Completer<Store?>? _inProgress = _storeCreationCompleters[docName];
    if (_inProgress != null){
      return _inProgress.future;
    }

    final Completer<Store?> _completer = Completer<Store?>();
    _storeCreationCompleters[docName] = _completer;

    try {

      final StoreModel? _storeModel = await StoreModel.createNewModel(
          docName: docName
      );

      if (_storeModel != null){
        _stores.add(_storeModel);
      }

      _completer.complete(_storeModel?.store);

    }
    catch (error, stackTrace){
      _completer.completeError(error, stackTrace);
    }
    finally {
      _storeCreationCompleters.remove(docName);
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
  Future<void> closeStore({
    required String docName,
  }) async {

    final StoreModel? _storeModel = StoreModel.getStoreByDocName(
      stores: _stores,
      docName: docName,
    );

    if (_storeModel != null){

      await tryAndCatch(
        invoker: 'BobInit.closeStore',
        functions: () async {

          _storeModel.store.close();

          _stores.removeWhere((StoreModel model){
            return model.docName == docName;
          });

        },
      );

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeTheStore(String docName) async {
    await BobInit.instance.closeStore(docName: docName);
    blog('closed BOB ($docName)');
  }
  // -----------------------------------------------------------------------------
}
