part of ldb;
/// => TAMAM
class SembastInit {
  // -----------------------------------------------------------------------------
  /// Simple Embedded Application Store database
  // -----------------------------------------------------------------------------

  /// CLASS SINGLETON

  // --------------------
  SembastInit.singleton();
  static final SembastInit _singleton = SembastInit.singleton();
  static SembastInit get instance => _singleton;
  // --------------------
  static String dbName = 'sembast.db';
  // -----------------------------------------------------------------------------

  /// DATABASE SINGLETON

  // --------------------
  Database? _database;
  Future<Database?> get database async =>  _database ??= await _createDatabaseRecursive();
  static Future<Database?> _getTheDatabase() => SembastInit.instance.database;
  static StoreRef<int, Map<String, dynamic>> _getTheStore(String? docName) => intMapStoreFactory.store(docName);
  /// concurrent callers await this SAME Completer instead of busy-polling
  /// every 100ms until _database shows up.
  Completer<Database?>? _creationCompleter;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _createDatabaseRecursive() async {

    if (_database != null){
      return _database;
    }

    if (_creationCompleter != null){
      return _creationCompleter!.future;
    }

    final Completer<Database?> _completer = Completer<Database?>();
    _creationCompleter = _completer;

    try {

      final Database? _output = kIsWeb
          ? await _createWebDatabase()
          : await _createSmartPhoneDatabase();

      if (_output != null){
        _database = _output;
      }

      _completer.complete(_output);

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
  Future<Database?> _createWebDatabase() async {
    Database? _db;
    await tryAndCatch(
      invoker: '_createWebDatabase',
      functions: () async {
        final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
        _db = await databaseFactoryWeb.openDatabase(_packageInfo.packageName);
      },
      onError: (String? error) async {
        blog('_createWebDatabase : error : $error');
      },
    );

    return _db;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _createSmartPhoneDatabase() async {
    Database? _db;
    await tryAndCatch(
      invoker: '_openSmartPhoneDatabase',
      functions: () async {
        final Directory? _appDocDir = await getApplicationDocumentsDirectory();
        await _appDocDir?.create(recursive: true);
        // final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
        final String _dbPath = path.join(_appDocDir!.path, dbName);
        _db = await databaseFactoryIo.openDatabase(_dbPath);
      },
      onError: (String? error) async {
        blog('_openSmartPhoneDatabase : error : $error');
      },
    );
    SembastInfo.report(
      invoker: '_createSmartPhoneDatabase',
      success: _db != null,
      docName: '...',
      key: '...',
    );

    return _db;
  }
  // -----------------------------------------------------------------------------

  /// CLOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> close() async {
    if (_database != null){
      await tryAndCatch(
        invoker: '_Sembast.close',
        functions: () async {
          final dynamic result = await _database?.close();
          blog('closeDatabase: resultType(${result.runtimeType}) : result($result)');
          _database = null;
        },
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeDatabase() => SembastInit.instance.close();
  // -----------------------------------------------------------------------------

  /// GETTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DBModel?> getDBModel(String? docName) async {
    DBModel? _output;

    if (docName != null){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getTheStore(docName);

      if (_doc != null){

        final Database? _db = await _getTheDatabase();

        if (_db != null){

          _output = DBModel(
            docName: docName,
            doc: _doc,
            database: _db,
          );

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
