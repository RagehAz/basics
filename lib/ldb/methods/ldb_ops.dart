import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:basics/ldb/methods/sembast.dart';

/// => TAMAM
class LDBOps {
  // -----------------------------------------------------------------------------

  const LDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMap({
    required Map<String, dynamic>? input,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    final bool _success = await Sembast.insert(
      map: input,
      docName: docName,
      primaryKey: primaryKey,
      allowDuplicateIDs: allowDuplicateIDs,
    );

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMaps({
    required List<Map<String, dynamic>>? inputs,
    required String? docName,
    required String? primaryKey,
    bool allowDuplicateIDs = false,
  }) async {

    await Sembast.insertAll(
      maps: inputs,
      docName: docName,
      primaryKey: primaryKey,
      allowDuplicateIDs: allowDuplicateIDs,
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) async {

    final Map<String, dynamic>? map = await readMap(
      docName: docName,
      id: id,
      primaryKey: primaryKey,
    );

    if (map == null){
      return null;
    }
    else {
      return map[fieldName];
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {

    Map<String, dynamic>? _output;

    if (id != null && docName != null && primaryKey != null){

      final List<Map<String, dynamic>> _maps = await readMaps(
        docName: docName,
        ids: <String>[id],
        primaryKey: primaryKey,
      );

      if (Lister.checkCanLoop(_maps) == true){
        _output = _maps[0];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) async {

    final List<Map<String, dynamic>> _maps = await Sembast.readMaps(
      primaryKeyName: primaryKey,
      ids: ids,
      docName: docName,
    );

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllMaps({
    required String? docName,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.readAll(
      docName: docName,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> searchFirstMap({
    required String? sortFieldName,
    required String? searchFieldName,
    required dynamic searchValue,
    required String? docName,
  }) async {

    final Map<String, dynamic>? _result = await Sembast.findFirst(
      docName: docName,
      fieldToSortBy: sortFieldName,
      searchField: searchFieldName,
      searchValue: searchValue,
    );

    // blog('LDBOps.searchMap in ${docName} : ${searchField} : ${searchValue} : _result has value ? : ${_result != null}');

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchAllMaps({
    required String? fieldToSortBy,
    required String? searchField,
    required bool fieldIsList,
    required dynamic searchValue,
    required String? docName,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.search(
      docName: docName,
      fieldToSortBy: fieldToSortBy,
      fieldIsList: fieldIsList,
      searchField: searchField,
      searchValue: searchValue,
    );

    // blog('searchMaps : _result : $_result');

    final List<Map<String, dynamic>> _fixedMaps = _result; //_decipherSembastMapsToFirebaseMaps
    // (_result);

    return _fixedMaps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchPhrasesDoc({
    required dynamic searchValue,
    required String? docName,
    required String? langCode,
  }) async {

    // blog('receiving value : $searchValue');

    final List<Map<String, dynamic>> _result = await Sembast.searchArrays(
      searchValue: searchValue,
      docName: docName,
      fieldToSortBy: 'value',
      searchField: 'trigram',
    );

    if (Lister.checkCanLoop(_result) == true){
      // blog('searchPhrases : found ${_result.length} phrases');

      return _result;

    }
    else {
      // blog('searchPhrases : did not find anything');

      return [];
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchLDBDocTrigram({
    required dynamic searchValue,
    required String? docName,
    required String? searchField,
    required String? primaryKey,
  }) async {

    /// NOTE : REQUIRES ( Phrase.cipherMixedLangPhrasesToMap ) cipher for 'phrases' field

    final List<Map<String, dynamic>> _result = await Sembast.search(
      fieldToSortBy: primaryKey,
      searchField: searchField,
      fieldIsList: true,
      searchValue: searchValue,
      docName: docName,
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> searchMultipleValues({
    required String? docName,
    required String? fieldToSortBy,
    required String? searchField,
    required List<dynamic>? searchObjects,
  }) async {

    final List<Map<String, dynamic>> _result = await Sembast.searchMultiple(
      docName: docName,
      searchField: searchField,
      searchObjects: searchObjects,
      fieldToSortBy: fieldToSortBy,
    );

    return _result;
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

    await Sembast.deleteMap(
      docName: docName,
      objectID: objectID,
      primaryKey: primaryKey,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMaps ({
    required List<String>? ids,
    required String? docName,
    required String? primaryKey,
  }) async {

    await Sembast.deleteMaps(
      docName: docName,
      primaryKeyName: primaryKey,
      ids: ids,
    );

  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsOneByOne({
    required String docName,
  }) async {

    await Sembast.deleteAllOneByOne(
      docName: docName,
    );

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllMapsAtOnce({
    required String? docName,
  }) async {

    await Sembast.deleteAllAtOnce(docName: docName);

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? id,
    required String? docName,
    required String? primaryKey,
  }) async {
    bool _exists = false;

    if (id != null) {
      _exists = await Sembast.checkMapExists(
        docName: docName,
        id: id,
        primaryKey: primaryKey,
      );
    }

    return _exists;
  }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH - DAILY WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkShouldRefreshLDB({
    int refreshDurationInMinutes = 60,
  }) async {
    bool _shouldRefresh = true;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final List<Map<String, dynamic>> _maps = await readMaps(
      ids: ['theLastWipeMap'],
      docName: 'theLastWipeMap',
      primaryKey: 'id',
    );

    if (Lister.checkCanLoop(_maps) == true){

      final DateTime? _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
      );

      double? _diff = Timers.calculateTimeDifferenceInMinutes(
          from: _lastWipe,
          to: DateTime.now(),
      ).toDouble();

      _diff = Numeric.modulus(_diff);

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff < refreshDurationInMinutes){
        _shouldRefresh = false;
      }
      else {
        _shouldRefresh = true;
      }

    }

    if (_shouldRefresh == true){
      await insertMap(
        // allowDuplicateIDs: false,
        docName: 'theLastWipeMap',
        primaryKey: 'id',
        input: {
          'id': 'theLastWipeMap',
          'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
        },
      );
    }

    return _shouldRefresh;
  }
  // -----------------------------------------------------------------------------
}
