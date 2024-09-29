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
  // -----------------------------------------------------------------------------

  /// GET STORE

  // --------------------
  ///
  Future<Store?> getStore({
    required String docName,
  }) async {
    Store? _output;

    StoreModel? _storeModel = StoreModel.getStoreByDocName(
      stores: _stores,
      docName: docName,
    );

    if (_storeModel == null){

      _storeModel = await StoreModel.createNewModel(
          docName: docName
      );

      if (_storeModel != null){
        _stores.add(_storeModel);
      }

    }
    else {
      _output = _storeModel.store;
    }

    return _output;
  }
  // --------------------
  ///
  static Future<Store?> getTheStore(String docName) => BobInit.instance.getStore(docName: docName);
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
  ///
  static Future<void> closeTheStore(String docName) => BobInit.instance.closeStore(docName: docName);
  // -----------------------------------------------------------------------------
}
