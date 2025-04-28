part of bob;
@immutable
class StoreModel {
  // -----------------------------------------------------------------------------
  const StoreModel({
    required this.docName,
    required this.store,
  });
  // --------------------
  final String docName;
  final Store store;
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<StoreModel?> createNewModel({
    required String docName,
  }) async {
    StoreModel? _output;

    /// WEB
    if (kIsWeb == true){
      _output = null;
    }

    /// SMART PHONE
    else {

      final Directory? _appDocDir = await getApplicationDocumentsDirectory();

      if (_appDocDir != null){

        final Store _store = await openStore(
          directory: join(_appDocDir.path, docName),
          // queriesCaseSensitiveDefault: ,
          // macosApplicationGroup: ,
          // fileMode: ,
          // maxReaders: ,
          // maxDBSizeInKB: ,
          // maxDataSizeInKB: ,
        );

        _output = StoreModel(
          docName: docName,
          store: _store,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTER

  // --------------------
  ///
  static StoreModel? getStoreByDocName({
    required List<StoreModel> stores,
    required String docName,
  }){
    StoreModel? _output;

    if (Lister.checkCanLoop(stores) == true){

      for (final StoreModel store in stores){

        if (store.docName == docName){
          _output = store;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => 'StoreModel(docName: $docName, store: $store)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is StoreModel){
      _areIdentical = docName == other.docName;
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      docName.hashCode^
      store.hashCode;
  // -----------------------------------------------------------------------------
}
