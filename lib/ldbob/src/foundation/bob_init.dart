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
  /// TESTED : WORKS PERFECT
  Future<Store?> getStoreRecursive({
    required String docName,
  }) async {

    StoreModel? _storeModel = StoreModel.getStoreByDocName(
      stores: _stores,
      docName: docName,
    );

    if (_storeModel == null){

      /// IS CREATING
      if (_checkIsCreatingStore(docName) == true){

        await Future.delayed(const Duration(milliseconds: 100));

        return getStoreRecursive(docName: docName);

      }

      /// IS NOT CREATING IT
      else {

        _markStoreInCreation(docName);

        _storeModel = await StoreModel.createNewModel(
            docName: docName
        );

        if (_storeModel != null){
          _stores.add(_storeModel);
        }

        _removeStoreFromInCreation(docName);

      }

    }

    return  _storeModel?.store;
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

  /// STORES IN CREATION

  // --------------------
  List<String> _storesInCreation = [];
  // --------------------
  /// TESTED : WORKS PERFECT
  void _markStoreInCreation(String docName){
    _storesInCreation = Stringer.addStringToListIfDoesNotContainIt(
      strings: _storesInCreation,
      stringToAdd: docName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _removeStoreFromInCreation(String docName){
    _storesInCreation = Stringer.removeStringFromStrings(
      removeFrom: _storesInCreation,
      removeThis: docName,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _checkIsCreatingStore(String docName){
    return Stringer.checkStringsContainString(strings: _storesInCreation, string: docName);
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
  static Future<void> closeTheStore(String docName) => BobInit.instance.closeStore(docName: docName);
  // -----------------------------------------------------------------------------
}
