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
  Store? _store;
  Future<Store?> get store async =>  _store ??= await _createDatabase();
  static Future<Store?> getTheStore() => BobInit.instance.store;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Store?> _createDatabase() async {
    Store? _output = _store;

    if (_store == null){

      if (kIsWeb){
        _output = await _createWebDatabase();
      }
      else {
        _output = await _createSmartPhoneDatabase();
      }

      if (_output != null){
        _store = _output;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Store?> _createWebDatabase() async {
    return null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Store?> _createSmartPhoneDatabase() async {

    // blog('_openSmartPhoneDatabase start');

    final Directory? _appDocDir = await getApplicationDocumentsDirectory();

    // blog('1--> BOB : _appDocDir : $_appDocDir');

    if (_appDocDir != null){

      // _store = Store(getObjectBoxModel(),
      //   directory: '${_appDocDir.path}/objectbox', // join(_appDocDir.path, 'objectbox')
      //   // maxDataSizeInKB: ,
      //   // maxDBSizeInKB: ,
      //   // maxReaders: ,
      //   // debugFlags: ,
      //   // fileMode: ,
      //   // macosApplicationGroup: ,
      // );

      _store = await openStore(
        directory: join(_appDocDir.path, 'bobStore'),
        // queriesCaseSensitiveDefault: ,
        // macosApplicationGroup: ,
        // fileMode: ,
        // maxReaders: ,
        // maxDBSizeInKB: ,
        // maxDataSizeInKB: ,
      );

    }

    // SembastInfo.report(
    //   invoker: '_createSmartPhoneDatabase',
    //   success: _db != null,
    //   docName: '...',
    //   key: '...',
    // );

    blog('4--> BOB : done : _store($_store)');
    return _store;
  }
  // -----------------------------------------------------------------------------

  /// CLOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> close() async {
    if (_store != null){
      await tryAndCatch(
        invoker: 'BobInit.close',
        functions: () async {
          _store!.close();
          blog('closeDatabase: closed');
          _store = null;
        },
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeDatabase() => BobInit.instance.close();
  // -----------------------------------------------------------------------------
}
