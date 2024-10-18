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
  // -----------------------------------------------------------------------------

  /// DATABASE SINGLETON

  // --------------------
  Database? _database;
  Future<Database?> get database async =>  _database ??= await _createDatabase();
  static Future<Database?> _getTheDatabase() => SembastInit.instance.database;
  static StoreRef<int, Map<String, dynamic>> _getTheStore(String? docName) => intMapStoreFactory.store(docName);
  bool _canCreateNewDatabase = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _createDatabase() async {
    Database? _output;

    if (_database == null && _canCreateNewDatabase == true){

      if (kIsWeb){
        _output = await _createWebDatabase();
      }
      else {
        _output = await _createSmartPhoneDatabase();
      }

      if (_output != null){
        _database = _output;
        _canCreateNewDatabase = false;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _createWebDatabase() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    final Database _db = await databaseFactoryWeb.openDatabase(_packageInfo.packageName);
    return _db;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _createSmartPhoneDatabase() async {
    blog('_openSmartPhoneDatabase start');
    final Directory? _appDocDir = await getApplicationDocumentsDirectory();
    await _appDocDir?.create(recursive: true);
    blog('1--> LDB : _appDocDir : $_appDocDir');
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    blog('2--> LDB : _packageInfo : ${_packageInfo.packageName}');
    final String _dbPath = path.join(_appDocDir!.path, _packageInfo.packageName);
    blog('3--> LDB : _dbPath : $_dbPath');

    Database? _db;
    await tryAndCatch(
      invoker: '_openSmartPhoneDatabase',
      functions: () async {
        _db = await databaseFactoryIo.openDatabase(_dbPath);
      },
      onError: (String? error) async {
        blog('_openSmartPhoneDatabase : error : $error');
        /*
        E/flutter ( 6925): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: FileSystemException: Deletion failed, path = '/data/user/0/net.bldrs.app/app_flutter' (OS Error: Directory not empty, errno = 39)
        E/flutter ( 6925): #0      _checkForErrorResponse (dart:io/common.dart:55:9)
        E/flutter ( 6925): #1      _Directory._delete.<anonymous closure> (dart:io/directory_impl.dart:180:7)
        E/flutter ( 6925): <asynchronous suspension>
        E/flutter ( 6925): #2      SembastInit._createSmartPhoneDatabase.<anonymous closure> (package:basics/ldb/src/foundation/sembast_init.dart:74:9)
        E/flutter ( 6925): <asynchronous suspension>
        E/flutter ( 6925):
         */
        /// SEMBAST_THROWS_ERROR_IN_BASICS
        await _appDocDir.delete();
      },
    );

    SembastInfo.report(
      invoker: '_createSmartPhoneDatabase',
      success: _db != null,
      docName: '...',
      key: '...',
    );

    blog('4--> LDB : done : _db : $_db');
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
