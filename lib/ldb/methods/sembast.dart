// ignore_for_file: unused_element

import 'dart:async';
import 'dart:io';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:sembast_web/sembast_web.dart';

class Sembast  {
  // -----------------------------------------------------------------------------
  /// Simple Embedded Application Store database
  // -----------------------------------------------------------------------------

  /// REFERENCES

  // --------------------
  /// private constructor to create instances of this class only in itself
  Sembast._thing();
  /// Singleton instance
  static final Sembast _singleton = Sembast._thing();
  /// Singleton accessor
  static Sembast get instance => _singleton;
  // --------------------
  /// local instance : to transform from synchronous into asynchronous
  Completer<Database>? _dbOpenCompleter;
  // --------------------
  /// instance getter
  Future<Database?> get database async {
    /// NOTE :this is db object accessor
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      await _openDatabase();
    }

    return _dbOpenCompleter?.future;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<Database?> _openDatabase() async {

      final Directory? _appDocDir =
      kIsWeb == true ? null
          :
      await getApplicationDocumentsDirectory();
      // blog('1--> LDB : _appDocDir : $_appDocDir');

      final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      // blog('2--> LDB : _packageInfo : $_packageInfo');

      final String packageName = _packageInfo.packageName;
      // blog('3--> LDB : packageName : $packageName');

      final String _dbPath = kIsWeb == true ? packageName : join(_appDocDir!.path, packageName);
      // blog('4--> LDB : _dbPath : $_dbPath');

      final DatabaseFactory factory = kIsWeb == true ? databaseFactoryWeb : databaseFactoryIo;
      // blog('5--> LDB : before open factory.hasStorage : ${factory.hasStorage}');

      final Database _db = await factory.openDatabase(_dbPath);
      // blog('6--> LDB : after open factory.hasStorage : ${factory.hasStorage}');

      _dbOpenCompleter?.complete(_db);
      // blog('7--> LDB : done : _db : $_db');

      return _db;
  }
  // --------------------
  /*
  /// Static close
  static Future<void> dispose() async {
    final Database _result = await _getDB();
    await _result.close();
  }
   */
  // -----------------------------------------------------------------------------
  /// static const String _storeName = 'blah';
  /// final StoreRef<int, Map<String, dynamic>> _doc = intMapStoreFactory.store(_storeName);
  /// Future<Database> get _db async => await AppDatabase.instance.database;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Database?> _getDB() async {
    final Database? _result = await Sembast.instance.database;
    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StoreRef<int, Map<String, dynamic>> _getStore({
    required String? docName,
  }) {
    return intMapStoreFactory.store(docName);
  }
  // -----------------------------------------------------------------------------

  /// INSERT SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    /// Note : either updates all existing maps with this primary key "ID"
    /// or inserts new map

    if (
    map != null &&
        docName != null
    ){

      // blog('SEMBAST : insert : docName : $docName : primaryKey : $primaryKey : allowDuplicateIDs : $allowDuplicateIDs');

      if (allowDuplicateIDs == true){
        await _addMap(
          docName: docName,
          map: map,
        );
      }

      else {

        final bool _exists = await checkMapExists(
          docName: docName,
          id: map[primaryKey!] as String,
          primaryKey: primaryKey,
        );

        /// ADD IF NOT FOUND
        if (_exists == false){
          await _addMap(
            docName: docName,
            map: map,
          );
        }

        /// UPDATE IF FOUND
        else {
          await _updateExistingMap(
            docName: docName,
            map: map,
            primaryKey: primaryKey,
          );
        }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMap({
    required Map<String, dynamic>? map,
    required String? docName,
  }) async {

    if (map != null && docName != null){

      /// NOTE : this ignores if there is an existing map with same ID
      final Database? _db = await _getDB();

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
        docName: docName,
      );

      if (_db != null){
        await _doc?.add(_db, map);
      }

      // blog('SEMBAST : _addMap : added to ($docName) : map has (${map.keys.length}) : _db : $_db');

    }

  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateExistingMap({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
  }) async {

    if (map != null && docName != null && primaryKey != null){

      final Database? _db = await _getDB();

      if (_db != null){
        final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
          docName: docName,
        );

        final String? _objectID = map[primaryKey] as String;

        final Finder _finder = Finder(
          filter: Filter.equals(primaryKey, _objectID),
        );


        // final int _result =
        await _doc?.update(
          _db,
          map,
          finder: _finder,
        );

        // blog('SEMBAST : _updateExistingMap : updated in ( $docName ) : result : $_result : map has ${map?.keys?.length} keys');

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// INSERT MULTIPLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAll({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    if (
          Lister.checkCanLoop(maps) == true &&
          docName != null &&
          primaryKey != null
    ) {

      if (allowDuplicateIDs == true){
        await _addMaps(
          docName: docName,
          maps: maps!,
        );
      }

      else {

        /// old slow solution
        // final List<Map<String, dynamic>> _existingMaps = await readAll(
        //   docName: docName,
        // );
        //
        // final List<Map<String, dynamic>> _cleanedMaps = Mapper.cleanMapsOfDuplicateIDs(
        //   /// do not change this order of maps to overwrite the new values
        //   maps: [...maps!,..._existingMaps,],
        //   idFieldName: primaryKey,
        // );
        //
        // await _deleteAllThenAddAll(
        //     maps: _cleanedMaps,
        //     docName: docName
        // );

        /// new fast solution
        await _updateMaps(
          primaryKey: primaryKey,
          docName: docName,
          maps: maps!,
        );

      }

      // blog('SEMBAST : insertAll : inserted ${maps.length} maps into ( $docName ) ');

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMaps({
    required List<Map<String, dynamic>> maps,
    required String? docName,
  }) async {
    /// NOTE : this allows duplicate IDs

    if (Lister.checkCanLoop(maps) == true && docName != null) {

      final Database? _db = await _getDB();
      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
        docName: docName,
      );

      if (_db != null){
        await _doc?.addAll(_db, maps);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateMaps({
    required List<Map<String, dynamic>> maps,
    required String docName,
    required String primaryKey,
  }) async {

    final List<Map<String, dynamic>> _cleanedMaps = Mapper.cleanMapsOfDuplicateIDs(
      maps: maps,
      idFieldName: primaryKey,
    );

    await Future.wait([

      ...List.generate(_cleanedMaps.length, (index){

        final Map<String, dynamic> _map = _cleanedMaps[index];

        return insert(
          map: _map,
          docName: docName,
          primaryKey: primaryKey,
          // allowDuplicateIDs: false,
        );

      }),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT ( SLOW MOTHER FUCKER )
  static Future<void> _deleteAllThenAddAll({
    required List<Map<String, dynamic>> maps,
    required String? docName,
  }) async {

    if (
        Lister.checkCanLoop(maps) == true &&
        docName != null
    ){

      await deleteAllAtOnce(
        docName: docName,
      );

      await _addMaps(
        maps: maps,
        docName: docName,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map <String, dynamic>>> readMaps({
    required String? docName,
    required List<String>? ids,
    required String? primaryKeyName,
  }) async {

    List<Map<String, dynamic>> _output = [];

    if (
      docName != null &&
      Lister.checkCanLoop(ids) == true &&
      primaryKeyName != null
    ){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
        docName: docName,
      );

      final Database? _db = await _getDB();

      if (_db != null && _doc != null){

        final Finder _finder = Finder(
          filter: Filter.inList(primaryKeyName, ids!),
        );

        final List<RecordSnapshot<int, Map<String, dynamic>>> _recordSnapshots =
        await _doc.find(
          _db,
          finder: _finder,
        );

        _output = _recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
          return snapshot.value;
        }).toList();

      }
      // blog('Sembast : readMaps : $docName : $primaryKeyName : ${_maps.length} maps');

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAll({
    required String? docName,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (docName != null) {
      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_db != null && _doc != null) {
        final List<RecordSnapshot<int, Map<String, dynamic>>> _recordSnapshots = await _doc.find(
          _db,
          // finder: _finder,
        );

        _output = _recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
          return snapshot.value;
        }).toList();
      }
    }

    return _output;
  }

  // --------------------
  /*
  static Future<List<Map<String, dynamic>>> readAllNewMethod({
    required String docName,
  }) async {

    final StoreRef<int, Map<String, dynamic>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final QueryRef<int, Map<String, dynamic>> _query = _doc.query();

    final List<RecordSnapshot<int, Map<String, dynamic>>> _snaps = await _query.getSnapshots(_db);

    final List<Map<String, dynamic>> _maps = [];

    for (final snap in _snaps){
      _maps.add(snap.value);
    }

    return _maps;
  }
 */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchArrays({
    required String? fieldToSortBy,
    required String? searchField,
    required dynamic searchValue,
    required String? docName,
  }) async {

    List<Map<String, dynamic>> _output = [];

    if (
        fieldToSortBy != null &&
        searchField != null &&
        searchValue != null &&
        docName != null
    ){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_doc != null && _db != null){

         final _finder = Finder(
        filter: Filter.matches(searchField, searchValue, anyInList: true),
        sortOrders: <SortOrder>[
          SortOrder(fieldToSortBy)
        ],
      );

      final List<RecordSnapshot<int, Map<String, dynamic>>> _recordSnapshots = await _doc.find(
        _db,
        finder: _finder,
      );

      _output = _recordSnapshots.map((snapshot){
        return snapshot.value;
      }).toList();

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> search({
    required String? fieldToSortBy,
    required String? searchField,
    required bool? fieldIsList,
    required dynamic searchValue,
    required String? docName,
  }) async {

    List<Map<String, dynamic>> _output = [];

    if (
        fieldToSortBy != null &&
        searchField != null &&
        fieldIsList != null &&
        searchValue != null &&
        docName != null
    ){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_doc != null && _db != null) {

        final Finder _finder = Finder(
          filter: Filter.equals(searchField, searchValue, anyInList: fieldIsList),
          sortOrders: <SortOrder>[SortOrder(fieldToSortBy)],
        );

        final List<RecordSnapshot<int, Map<String, dynamic>>> _recordSnapshots = await _doc.find(
          _db,
          finder: _finder,
        );

        // blog('fieldToSortBy : $fieldToSortBy');
        // blog('searchField : $searchField');
        // blog('searchValue : $searchValue');
        // blog('docName : $docName');
        // blog('_doc : $_doc');
        // blog('_db : $_db');
        // blog('_finder : $_finder');
        // blog('_recordSnapshots : $_recordSnapshots');

        _output = _recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
          return snapshot.value;
        }).toList();
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> findFirst({
    required String? fieldToSortBy,
    required String? searchField,
    required dynamic searchValue,
    required String? docName,
  }) async {
    Map<String, dynamic>? _output;

    if (
        fieldToSortBy != null &&
        searchField != null &&
        searchValue != null &&
        docName != null
    ) {

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_doc != null && _db != null) {

        final Finder _finder = Finder(
          filter: Filter.equals(searchField, searchValue, anyInList: false),
          // sortOrders: <SortOrder>[
          //   SortOrder(fieldToSortBy)
          // ],
        );

        // blog('_finder is : $_finder');

        final RecordSnapshot<int, Map<String, dynamic>>? _recordSnapshot = await _doc.findFirst(
          _db,
          finder: _finder,
        );

        // blog('_recordSnapshot : $_recordSnapshot');

        _output = _recordSnapshot?.value;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchMultiple({
    required String? docName,
    required String? searchField,
    required List<dynamic>? searchObjects,
    required String? fieldToSortBy,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (
        docName != null &&
        searchField != null &&
        Lister.checkCanLoop(searchObjects) == true &&
        fieldToSortBy != null
    ){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_doc != null && _db != null){

        final Finder _finder = Finder(
          filter: Filter.inList(searchField, <Object>[...?searchObjects]),
          sortOrders: <SortOrder>[SortOrder(fieldToSortBy)],
        );

        final List<RecordSnapshot<int, Map<String, dynamic>>> _recordSnapshots = await _doc.find(
          _db,
          finder: _finder,
        );

        _output = _recordSnapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
          return snapshot.value;
        }).toList();
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMap({
    required String? objectID,
    required String? docName,
    required String? primaryKey,
  }) async {

    if (objectID != null && docName != null && primaryKey != null){

      /// NOTE : Deletes all maps with the given primary key,
      /// as LDB allows duplicate maps of same ID "same value of the primary key"

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
          docName: docName
      );
      final Database? _db = await _getDB();


      if (_db != null && _doc != null){

        final Finder _finder = Finder(
          filter: Filter.equals(primaryKey, objectID),
        );

        await _doc.delete(
          _db,
          finder: _finder,
        );

        // blog('Sembast : deleteMap : $docName : $primaryKey : $objectID');

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMaps({
    required String? primaryKeyName,
    required List<String>? ids,
    required String? docName,
  }) async {

    if (
        primaryKeyName != null &&
        Lister.checkCanLoop(ids) == true &&
        docName != null
    ){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
        docName: docName,
      );

      final Database? _db = await _getDB();


      if (_db != null && _doc != null){

        final Finder _finder = Finder(
          filter: Filter.inList(primaryKeyName, ids!),
        );

        await _doc.delete(
          _db,
          finder: _finder,
        );

        // blog('Sembast : deleteDocs : $docName : $primaryKeyName : $ids');
      }

    }

  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED :
  static Future<void> deleteAllOneByOne({
    required String docName,
  }) async {

    final List<Map<String, dynamic>> _allMaps = await readAll(
      docName: docName,
    );

    if (Lister.checkCanLoopList(_allMaps) == true){

      final String _primaryKey = LDBDoc.getPrimaryKey(docName);

      await Future.wait(<Future>[

        ...List.generate(_allMaps.length, (index){

          final String _id = _allMaps[index][_primaryKey];

          blog('Sembast : deleteAll : $docName : _id : $_id');

          return deleteMap(
            objectID: _id,
            docName: docName,
          );

        }),

      ]);

    }

  // -----------------------------------------------------------------------------
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllAtOnce({
    required String? docName,
  }) async {

    if (docName != null){

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(
          docName: docName
      );

      final Database? _db = await _getDB();

      if (_db != null){
        await _doc?.delete(_db,);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    bool _output = false;

    if (docName != null && id != null && primaryKey != null) {

      final StoreRef<int, Map<String, dynamic>>? _doc = _getStore(docName: docName);
      final Database? _db = await _getDB();

      if (_doc != null && _db != null) {

        final Finder _finder = Finder(
          filter: Filter.equals(primaryKey, id, anyInList: false),
        );

        final int? _val = await _doc.findKey(
          _db,
          finder: _finder,
        );

        /// NOT FOUND
        if (_val == null) {
          _output = false;
        }

        /// FOUND
        else {
          _output = true;
        }
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
