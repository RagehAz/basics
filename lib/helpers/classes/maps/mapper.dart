import 'dart:convert';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:collection/collection.dart';

/// => AI TESTED
class Mapper {
  // -----------------------------------------------------------------------------

  const Mapper();

  // -----------------------------------------------------------------------------

  /// STRINGS GETTERS FROM LISTS

  // --------------------
  /// AI TESTED
  static List<String> getMapsPrimaryKeysValues({
    required List<Map<String, dynamic>>? maps,
    String primaryKey = 'id',
    bool throwErrorOnInvalidID = false,
  }){

    final List<String> _primaryKeys = <String>[];

    if (checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final dynamic _id = map[primaryKey];

        if (_id != null && _id is String){
          _primaryKeys.add(_id);
        }
        else {
          if (throwErrorOnInvalidID == true){
            // assert(_id is String, 'id : $_id is not a String');
            final Error _error = ArgumentError('id : $_id is not a String');
            throw _error;
          }
        }

      }

    }

    return _primaryKeys;
  }
  // -----------------------------------------------------------------------------

  /// MAP GETTERS FROM (URL - DYNAMIC - STRING STRING IMMUTABLE MAP STRING OBJECT)

  // --------------------
  /// NOT USED
  /*
  static List<Map<String, dynamic>> getMapsFromDynamics(List<dynamic> dynamics) {
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (checkCanLoopList(dynamics) == true) {
      for (final dynamic map in dynamics) {
        _maps.add(map);
      }
    }

    return _maps;
  }
   */
  // --------------------
  /// NOT USED
  /*
  static Map<String, dynamic> getMapFromURLQuery({
    required String urlQuery,
  }) {

    /// url query should look like this
    /// 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';
    /// url query looks like "key1=value1&key1=value2&key3=value3"

    Map<String, dynamic> _output = <String, dynamic>{};

    final int _numberOfAnds = '&'.allMatches(urlQuery).length;
    final int _numberOfEquals = '='.allMatches(urlQuery).length;
    final bool _countsOfPairsAreGood = _numberOfAnds + 1 == _numberOfEquals;

    /// if urlQuery counts are good
    if (_countsOfPairsAreGood == true) {
      /// pairs should look like this : key=value
      final List<String> _pairs = <String>[];

      /// holds temp trimmed url in here while trimming loops
      String _trimmedURL = urlQuery;

      blog('_trimmedURL : $_trimmedURL');

      /// trim urlQuery into string pairs
      for (int i = 0; i < _numberOfAnds; i++) {
        final String _beforeAnd =
        TextMod.removeTextAfterFirstSpecialCharacter(_trimmedURL, '&');
        _pairs.add(_beforeAnd);

        final String _afterAnd =
        TextMod.removeTextBeforeFirstSpecialCharacter(_trimmedURL, '&');

        if (i == _numberOfAnds - 1) {
          _pairs.add(_afterAnd);
        } else {
          _trimmedURL = _afterAnd;
        }
      }

      /// add pairs to a map
      for (final String pair in _pairs) {
        final String _key =
        TextMod.removeTextAfterFirstSpecialCharacter(pair, '=');
        final String _value =
        TextMod.removeTextBeforeFirstSpecialCharacter(pair, '=');

        _output = insertPairInMap(
          map: _output,
          key: _key,
          value: _value,
        );
      }
    }

    /// if counts are no good
    else {
      blog('getMapFromURLQuery : _countsOfPairsAreGood : $_countsOfPairsAreGood');
      blog(
          'getMapFromURLQuery : something is wrong in this : urlQuery : $urlQuery');
    }

    return _output;
  }
   */
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static Map<String, dynamic>? getMapFromIHLMOO({
    required Object? ihlmoo,
  }){
    Map<String, dynamic>? _output;

    /// NOTE : IHLMOO = Internal Hash Linked Map Object Object

    if (ihlmoo != null){
      _output = jsonDecode(jsonEncode(ihlmoo));
      // _output = Map<String, dynamic>.from(internalHashLinkedMapObjectObject);
    }

    return _output;
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromIHLMOO({
    required Object? ihlmoo,
    bool addChildrenIDs = true,
  }){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    /// NOTE : IHLMOO = Internal Hash Linked Map Object Object

    if (ihlmoo != null){

      final Map<String, dynamic> _bigMap = jsonDecode(jsonEncode(ihlmoo));
      // Map.from(internalHashLinkedMapObjectObject);
      final List<String> _ids = _bigMap.keys.toList();

      for (final String id in _ids){

        Map<String, dynamic> _map = jsonDecode(jsonEncode(_bigMap[id]));
        // Map.from();

        if (addChildrenIDs == true){
          _map = insertPairInMap(
            map: _map,
            key: 'id',
            value: id,
            overrideExisting: true,
          );
        }

        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static Map<String, String>? createStringStringMap({
    required Map? hashMap,
    required bool stringifyNonStrings,
  }){
    Map<String, String>? _output;

    // blog('1 - createStringStringMap : hashMap : $hashMap');

    if (hashMap != null){

      final List<dynamic>? _keys = hashMap.keys.toList();

      // blog('1 - createStringStringMap : _keys : $_keys');

      if (checkCanLoopList(_keys) == true){
        _output = {};

        for (final String key in _keys!){

          if (hashMap[key] is String){

            _output[key] = hashMap[key];

            // blog('2 - createStringStringMap : added : ($key : ${_output[key]})');

          }
          else {

            if (stringifyNonStrings == true){
              _output[key] = hashMap[key].toString();
              // blog('2 - createStringStringMap : added : ($key : ${_output[key].toString()})');

            }

          }

        }

      }

    }

    // blog('3 - createStringStringMap : _output : $_output');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MAP IN MAPS INDEX CHECKERS

  // --------------------
  /// AI TESTED
  static Map<String, dynamic>? getMapFromMapsByID({
    required List<Map<String, dynamic>>? maps,
    required String? id,
    String idFieldName = 'id',
  }){
    Map<String, dynamic>? _output;

    if (checkCanLoopList(maps) == true && id != null){

      final int _index = getMapIndexByID(
        maps: maps,
        id: id,
        idFieldName: idFieldName,
      );

      /// NOT FOUND
      if (_index == -1){
        // output is null
      }
      /// FOUND
      else {
        _output = maps![_index];
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int getMapIndexByID({
    required List<Map<String, dynamic>>? maps,
    required String? id,
    String idFieldName = 'id',
  }) {
    if (checkCanLoopList(maps) == true){
      return maps!.indexWhere((Map<String, dynamic> m) => m[idFieldName] == id);
    }
    else {
      return -1;
    }
  }
  // --------------------
  /// NOT USED
  /*
  static int indexOfMapByValueInListOfMaps({
    required List<Map<String, dynamic>> listOfMaps,
    required String key,
    required dynamic value,
  }) {
    return listOfMaps.indexWhere((Map<String, dynamic> map) => map[key] == value);
  }
   */
  // -----------------------------------------------------------------------------

  /// MAPS MODIFIERS

  // --------------------
  /// AI TESTED
  static Map<String, dynamic> insertPairInMap({
    required Map<String, dynamic>? map,
    required String? key,
    required dynamic value,
    required bool overrideExisting, // was always false by default
  }) {

    final Map<String, dynamic> _result = <String, dynamic>{};

    if (map != null){
      _result.addAll(map);
    }

    if (key != null){

      /// PAIR IS NULL
      if (_result[key] == null){
        _result[key] = value;
        // _result.putIfAbsent(key, () => value);
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true){
          _result[key] = value;
        }
      }

    }

    return _result;
  }
  // --------------------
  /// NOT USED
  /*
  static Map<String, Object> replacePair({
    required Map<String, Object> map,
    required String fieldKey,
    required dynamic inputValue,
  }) {
    final Map<String, Object> _aMap = cloneMap(map);

    try {
      _aMap[fieldKey] = inputValue;
    } on Exception catch (e) {
      blog('error is : $e');
      blog('map is : $map');
      blog('fieldKey is : $fieldKey');
      blog('inputValue : $inputValue');
    }

    return _aMap;
  }
   */
  // --------------------
  /// AI TESTED
  static Map<String, dynamic> removePair({
    required Map<String, dynamic>? map,
    required String? fieldKey,
  }) {
    Map<String, dynamic> _output = {};
    _output = insertMapInMap(
        baseMap: _output,
        insert: map,
    );

    if (map != null && fieldKey != null){
      _output.removeWhere((key, value) => key == fieldKey);
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic> insertMapInMap({
    required Map<String, dynamic>? baseMap,
    required Map<String, dynamic>? insert,
    bool replaceDuplicateKeys = true,
  }){
    Map<String, dynamic> _output = {};

    if (baseMap != null){
      _output.addAll(baseMap);
    }

    if (insert != null){

      final List<String> _keys = insert.keys.toList();

      if (checkCanLoopList(_keys) == true){

        for (final String key in _keys){

            _output = insertPairInMap(
              map: _output,
              key: key,
              value: insert[key],
              overrideExisting: replaceDuplicateKeys,
            );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<Map<String, dynamic>> cleanDuplicateMaps({
    required List<Map<String, dynamic>>? maps,
  }){
    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final bool _exists = checkMapsContainIdenticalMap(
          maps: _output,
          map: map,
        );

        if (_exists == false){
          _output.add(map);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<Map<String, dynamic>> cleanMapsOfDuplicateIDs({
    required List<Map<String, dynamic>>? maps,
    required String idFieldName,
  }){
    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final int _index = _output.indexWhere((m) => m[idFieldName] == map[idFieldName]);

        if (_index == -1){
          _output.add(map);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<Map<String, dynamic>>? replaceMapInMapsWithSameIDField({
    required List<Map<String, dynamic>>? baseMaps,
    required Map<String, dynamic>? mapToReplace,
    String idFieldName = 'id',
  }){
    final List<Map<String, dynamic>> _output = <Map<String,dynamic>>[...?baseMaps];

    // Mapper.blogMap(mapToReplace, invoker: 'replaceMapInMapsWithSameIDField');

    /// Note : if baseMaps is empty, there will be nothing to replace ya zaki
    if (checkCanLoopList(baseMaps) == true && mapToReplace != null){

      final int _index = _output.indexWhere((map){

        // if (map == null){
        //   return false;
        // }
        // else {

          final dynamic _baseIDValue = map[idFieldName];
          final dynamic _replaceIDValue = mapToReplace[idFieldName];

          if (_baseIDValue != null && _replaceIDValue != null){
            return _baseIDValue == _replaceIDValue;
          }
          else {
            return false;
          }

        // }


      });

      /// IF FOUND
      if (_index != -1){
        // blog('replaceMapInMapsWithSameIDField : found map to replace at index $_index : '
        //     'idFieldName : $idFieldName');
        _output.removeAt(_index);
        _output.insert(_index, mapToReplace);
      }
      // else {
        // blog('replaceMapInMapsWithSameIDField : did not find this map : $_index');
      // }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<Map<String, dynamic>> removeMapFromMapsByIdField({
    required List<Map<String, dynamic>>? baseMaps,
    required String? mapIDToRemove,
    String idFieldName = 'id',
  }){
    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    // Mapper.blogMap(mapToReplace, invoker: 'replaceMapInMapsWithSameIDField');

    /// NOTE : if maps is empty, nothing to remove ya zaki bardo
    if (checkCanLoopList(baseMaps) == true && mapIDToRemove != null){

      _output = <Map<String,dynamic>>[...baseMaps!];

      final int _index = _output.indexWhere((map){
        final bool _condition = map[idFieldName] == mapIDToRemove;
        return _condition;
      });

      /// IF FOUND
      if (_index != -1){
        // blog('removeMapFromMapsByIdField : found map to remove at index $_index');
        _output.removeAt(_index);
      }
      // else {
      //   blog('removeMapFromMapsByIdField : did not find this map and nothing is removed');
      // }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic>? cleanNullPairs({
    required Map<String, dynamic>? map,
  }){
    Map<String, dynamic>? _output;

    if (map != null){

      _output = {};
      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        if (map[key] != null){

          if (map[key] is Map<String, dynamic>){
            final Map<String, dynamic>? _sub = cleanNullPairs(
               map: map[key],
            );
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: _sub,
              overrideExisting: true,
            );
          }

          else {
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: map[key],
              overrideExisting: true,
            );
          }

        }

        // else {
        //   blog('$key : value is null');
        // }

      }

      if (_output != null && _output.keys.isEmpty == true){
        _output = null;
      }

    }

    // else {
    //   blog('cleanNullPairs: map is null');
    // }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Map<String, dynamic>? cleanZeroValuesPairs({
    required Map<String, dynamic>? map,
  }){
    Map<String, dynamic>? _output;

    if (map != null){

      _output = {};
      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        if (map[key] != 0){

          if (map[key] is Map<String, dynamic>){
            final Map<String, dynamic>? _sub = cleanZeroValuesPairs(
               map: map[key],
            );
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: _sub,
              overrideExisting: true,
            );
          }

          else {
            _output = insertPairInMap(
              map: _output,
              key: key,
              value: map[key],
              overrideExisting: true,
            );
          }

        }

      }

      if (_output != null && _output.keys.isEmpty == true){
        _output = null;
      }

    }

    return _output;
}
  // -----------------------------------------------------------------------------

  /// DYNAMIC LISTS CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkCanLoopList(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }
    return _canLoop;
  }
  // --------------------
  /// AI TESTED
  static bool checkListHasNullValue(List<dynamic>? list){
    bool _hasNull = false;

    if (checkCanLoopList(list) == true){

      _hasNull = list!.contains(null);

    }

    return _hasNull;
  }
  // --------------------
  /// AI TESTED
  static bool checkListsAreIdentical({
    required List<dynamic>? list1,
    required List<dynamic>? list2
  }) {
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoopList(list1) == true && checkCanLoopList(list2) == true){

      if (list1!.length != list2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( ${list1.toString()} )');
        // blog(' ---> lis2 is ( ${list2.toString()} )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          if (list1[i] != list2[i]) {
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (list1[i].toString() == list2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// NOT USED
  /*
  ///
  static bool checkIsLastListObject({
    required List<dynamic> list,
    required int index,
  }){

    bool _isAtLast = false;

    if (checkCanLoopList(list) == true){

      if (index != null){

        _isAtLast = index == (list.length - 1);

      }

    }

    return _isAtLast;
  }
   */
  // -----------------------------------------------------------------------------

  /// LIST GETTERS

  // --------------------
  /// AI TESTED
  static dynamic getFirstInList(List<dynamic>? list){
    dynamic _output;

    if (checkCanLoopList(list) == true){
      _output = list!.last;
    }

      return _output;
  }
  // -----------------------------------------------------------------------------

  /// IDENTICAL MAPS CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkMapsAreIdentical({
    required Map<String, dynamic>? map1,
    required Map<String, dynamic>? map2,
  }) {

    return const DeepCollectionEquality().equals(map1, map2);

    /*
    bool _mapsAreIdentical = false;

    /// BOTH ARE NULL
    if (map1 == null && map2 == null) {
      _mapsAreIdentical = true;
    }

    /// BOTH AREN'T NULL BUT ATLEAST ONE OF THEM IS NULL
    else if (map1 == null || map2 == null){
      _mapsAreIdentical = false;
    }

    /// NON OF THEM IS NULL
    else if (map1 != null && map2 != null){

      if (map1.toString() == map2.toString()){
        _mapsAreIdentical = true;
      }
      else {
        _mapsAreIdentical = false;
      }

      // final List<String> _map1Keys = map1.keys.toList();
      // final List<String> _map2Keys = map2.keys.toList();
      //
      // /// KEYS LENGTH ARE DIFFERENT
      // if (_map1Keys.length != _map2Keys.length) {
      //   _mapsAreIdentical = false;
      // }
      //
      // /// KEYS LENGTH ARE IDENTICAL
      // else {
      //
      //   /// FOR EACH PAIR
      //   for (int i = 0; i < _map1Keys.length; i++){
      //
      //     final String _key1 = _map1Keys[i];
      //     final String _key2 = _map1Keys[i];
      //
      //     /// KEYS ARE DIFFERENT
      //     if (_key1 != _key2){
      //       _mapsAreIdentical = false;
      //       break;
      //     }
      //
      //     /// KEYS ARE IDENTICAL
      //     else {
      //
      //       /// BOTH VALUES ARE NULL
      //       if (map1[_key1] == null && map2[_key2] == null){
      //         // continue looping
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL BUT ONE OF THEM IS
      //       else if (map1[_key1] == null || map2[_key2] == null){
      //         _mapsAreIdentical = false;
      //         break;
      //       }
      //
      //       /// BOTH VALUES ARE NOT NULL
      //       else {
      //
      //         /// VALUE TYPES ARE DIFFERENT
      //         if (map1[_key1].runtimeType != map2[_key2].runtimeType){
      //           _mapsAreIdentical = false;
      //           break;
      //         }
      //
      //         /// VALUE TYPES ARE IDENTICAL
      //         else {
      //
      //           if (
      //               map1[_key1] is String ||
      //               map1[_key1] is int ||
      //               map1[_key1] is double ||
      //               map1[_key1] is bool
      //           ){
      //
      //             if (map1[_key1] != map2[_key2]){
      //               _mapsAreIdentical = false;
      //               break;
      //             }
      //
      //           }
      //
      //           else if (map1[_key1] is List){
      //
      //           }
      //
      //         }
      //
      //       }
      //
      //
      //     }
      //
      //   }
      //
      //   // final List<dynamic> _map1Values = map1.values.toList();
      //   // final List<dynamic> _map2Values = map2.values.toList();
      //   //
      //   // if (
      //   //     checkListsAreIdentical(list1: _map1Keys, list2: _map2Keys) == true
      //   //     &&
      //   //     checkListsAreIdentical(list1: _map1Values, list2: _map2Values) == true
      //   // ){
      //   //   _mapsAreIdentical = true;
      //   // }
      //   //
      //   // else {
      //   //   _mapsAreIdentical = false;
      //   // }
      //
      // }

    }

    return _mapsAreIdentical;
     */
  }
  // --------------------
  /// AI TESTED
  static bool checkMapsListsAreIdentical({
    required List<Map<String, dynamic>>? maps1,
    required List<Map<String, dynamic>>? maps2,
  }){

    /// OLD BULLSHIT
    // bool _listsAreIdentical = false;
    //
    // if (maps1 == null && maps2 == null){
    //   _listsAreIdentical = true;
    // }
    //
    // else if (maps1?.isEmpty && maps2 == []){
    //   _listsAreIdentical = true;
    // }
    //
    // else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){
    //
    //   if (maps1.length != maps2.length) {
    //     _listsAreIdentical = false;
    //   }
    //
    //   else {
    //     for (int i = 0; i < maps1.length; i++) {
    //
    //       final bool _mapsAreIdentical = checkMapsAreIdentical(
    //         map1: maps1[i],
    //         map2: maps2[i],
    //       );
    //
    //       if (_mapsAreIdentical == false) {
    //         // blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
    //         _listsAreIdentical = false;
    //         break;
    //       }
    //
    //       else {
    //         _listsAreIdentical = true;
    //       }
    //
    //     }
    //   }
    //
    // }
    //
    // if (_listsAreIdentical == false){
    //   blogMapsListsDifferences(
    //     maps1: maps1,
    //     maps2: maps2,
    //     invoker: 'checkMapsListsAreIdentical',
    //   );
    // }
    // return _listsAreIdentical;

    /// THIS DOES NOT CONDUCT DEEP MAP CHECK
    // return checkListsAreIdentical(list1: maps1, list2: maps2);

    /// ITERATE AND DEEP CHECK
    bool _listsAreIdentical = false;

    if (maps1 == null && maps2 == null){
      _listsAreIdentical = true;
    }
    else if (maps1 != null && maps1.isEmpty == true && maps2 != null && maps2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){

      if (maps1!.length != maps2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( ${list1.toString()} )');
        // blog(' ---> lis2 is ( ${list2.toString()} )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < maps1.length; i++) {

          if (checkMapsAreIdentical(map1: maps1[i], map2: maps2[i]) == false){
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (maps1[i].toString() == maps2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;

  }
  // -----------------------------------------------------------------------------

  /// MAP CONTAINS ?

  // --------------------
  /// AI TESTED
  static bool checkMapsContainMapWithID({
    required List<Map<String, dynamic>>? maps,
    required Map<String, dynamic>? map,
    String idFieldName = 'id',
  }){
    bool _include = false;

    /// Note : if baseMaps is empty, there will be nothing to replace ya zaki
    if (checkCanLoopList(maps) == true && map != null){

      final int _index = maps!.indexWhere((maw){

        // if (maw == null){
        //   return false;
        // }
        // else {
          final bool _condition = maw[idFieldName] == map[idFieldName];
          return _condition;
        // }

      });

      /// IF FOUND
      if (_index != -1){
        _include = true;
      }

    }

    return _include;
  }
  // --------------------
  /// AI TESTED
  static bool checkMapsContainIdenticalMap({
    required List<Map<String, dynamic>>? maps,
    required Map<String, dynamic>? map,
  }) {
    bool _contain = false;

    if (checkCanLoopList(maps) == true && map != null){

      for (final Map<String, dynamic>? _map in maps!){

        final bool _identical = checkMapsAreIdentical(
          map1: map,
          map2: _map,
        );

        if (_identical == true){
          _contain = true;
          break;
        }

      }

    }

    return _contain;
  }
  // --------------------
  /// AI TESTED
  static bool checkMapsContainValue({
    required List<Map<String, dynamic>>? maps,
    required String? field,
    required dynamic value,
  }) {
    bool _listOfMapContainsTheValue = false;

    if (checkCanLoopList(maps) == true && value != null){

      for (final Map<String, dynamic> map in maps!) {

           if (map[field] == value) {
             _listOfMapContainsTheValue = true;
             break;
           }

           else {

             if (map[field]?.toString() == value?.toString()){
               _listOfMapContainsTheValue = true;
               break;
             }
             else {
               _listOfMapContainsTheValue = false;
             }

           }

         }

    }

    return _listOfMapContainsTheValue;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING MAPS

  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static void blogMap(Map<String, dynamic>? map, {String invoker = ''}) {

    if (map != null){

      blog('$invoker ~~~> <String, dynamic>{');

      final List<dynamic> _keys = map.keys.toList();
      final List<dynamic> _values = map.values.toList();

      for (int i = 0; i < _keys.length; i++) {

        final String? _index = Numeric.formatIndexDigits(
          index: i,
          listLength: _keys.length,
        );

        blog('         $_index. ${_keys[i]} : <${_values[i].runtimeType}>( ${_values[i]} ), ');
      }

      blog('      }.........Length : ${_keys.length} keys <~~~');

    }

    else {
      blog('MAP IS NULL');
    }

  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static void blogMaps(List<Map<String, dynamic>>? maps, {String invoker = 'map'}) {
    if (checkCanLoopList(maps) == true) {
      for (int i = 0; i < maps!.length; i++) {
        final Map<String, dynamic> map = maps[i];
        blogMap(map,
            invoker: '$i : $invoker',
        );
      }
    }

    else {
      blog('No maps to blog ( $invoker )');
    }
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static void blogMapsListsDifferences({
    required List<Map<String, dynamic>>? maps1,
    required List<Map<String, dynamic>>? maps2,
    required String invoker,
  }){

    blog('blogMapsListsDifferences : START');

    if (maps1 == null && maps2 == null){
      blog('both maps lists are null');
    }

    if (maps1 == [] && maps2 == []){
      blog('both maps lists are empty');
    }

    if (checkCanLoopList(maps1) == true && checkCanLoopList(maps2) == true){

      if (maps1!.length != maps2!.length) {
        blog('maps1.length != maps2.length');
      }

      else {
        for (int i = 0; i < maps1.length; i++) {

          final bool _mapsAreIdentical = checkMapsAreIdentical(
            map1: maps1[i],
            map2: maps2[i],
          );

          if (_mapsAreIdentical == false) {
            blog('items at index ( $i ) do not match : ( ${maps1[i]} ) <=> ( ${maps2[i]} )');
            break;
          }

          else {
            blog('all maps are identical');
          }

        }
      }

    }

    blog('blogMapsListsDifferences : END');
  }
  // -----------------------------------------------------------------------------

  /// MAP<STRING, STRING> STUFF

  // --------------------
  /// AI TESTED
  static List<String> getKeysHavingThisValue({
    required Map<String, String>? map,
    required String? value,
  }){
    final List<String> _output = <String>[];

    if (map != null && value != null){

      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          final String? _mapValue = map[key];

          if (_mapValue == value){
            _output.add(key);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Map<String, String>? insertPairInMapWithStringValue({
    required Map<String, String>? map,
    required String? key,
    required String value,
    required bool overrideExisting, // otherwise will keep existing pair
  }) {

    Map<String, String>? _result = <String, String>{};

    if (map != null){
      _result = map;
    }

    if (key != null){

      /// PAIR IS NULL
      if (_result[key] == null){
        _result[key] = value;
      }

      /// PAIR HAS VALUE
      else {
        if (overrideExisting == true){
          _result[key] = value;
        }
      }

    }

    return _result;
  }
  // --------------------
  /// AI TESTED
  static Map<String, String>? combineStringStringMap({
    required Map<String, String>? baseMap,
    required Map<String, String>? insert,
    required bool replaceDuplicateKeys,
  }){
    Map<String, String>? _output = {};

    if (baseMap != null){

      _output = baseMap;

      if (insert != null){

        final List<String> _keys = insert.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

            if (insert[key] != null){
              _output = insertPairInMapWithStringValue(
                map: _output,
                key: key,
                value: insert[key]!,
                overrideExisting: replaceDuplicateKeys,
              );
            }

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static Map<String, String>? getStringStringMapFromImmutableMapStringObject(dynamic object){

    Map<String, String>? _output = {};

    if (object != null){

      final String _runTime = object.runtimeType.toString();
      const String _mapType0 = 'ImmutableMap<String, Object?>';
      const String _mapType00 = 'ImmutableMap<String, Object>';
      const String _mapType1 = 'Map<String, Object?>';
      const String _mapType2 = 'Map<String, Object>';
      const String _mapType3 = 'Map<String, dynamic?>';
      const String _mapType4 = 'Map<String, dynamic>';
      const String _mapType5 = '_InternalLinkedHashMap<String, Object?>';
      const String _mapType6 = '_InternalLinkedHashMap<String, Object>';
      const String _mapType7 = '_InternalLinkedHashMap<String, dynamic?>';
      const String _mapType8 = '_InternalLinkedHashMap<String, dynamic>';
      const String _mapType9 = '_InternalLinkedHashMap<String, String>';
      const String _mapType10 = '_InternalLinkedHashMap<String, String?>';

      final bool _canContinue = _runTime == _mapType0 ||
                                _runTime == _mapType00 ||
                                _runTime == _mapType1 ||
                                _runTime == _mapType2 ||
                                _runTime == _mapType3 ||
                                _runTime == _mapType4 ||
                                _runTime == _mapType5 ||
                                _runTime == _mapType6 ||
                                _runTime == _mapType7 ||
                                _runTime == _mapType8 ||
                                _runTime == _mapType9 ||
                                _runTime == _mapType10;


      if (_canContinue == true){

        final Map _map =  object;
        // blog('3 - FUCK : _map : ${_map.runtimeType}');
        final List<dynamic> _keys = _map.keys.toList();

        if (checkCanLoopList(_keys) == true){

          for (final String key in _keys){

            final String _value = _map[key] is String ? _map[key] : _map[key].toString();

            _output = insertPairInMapWithStringValue(
              map: _output,
              key: key,
              value: _value,
              overrideExisting: true,
            );

          }

        }

      }

      else {
        // blog('getStringStringMapFromImmutableMapStringObject : starts : is NOT IMMUTABLE MAP');
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TO JSON

  // --------------------
  /// EXPERIMENT
  /*
         // static String mapsToJson(List<Map<String, dynamic>> map) {
         //   String res = '[';
         //
         //   for (var s in map) {
         //     res += '{';
         //
         //     for (String k in s.keys) {
         //       res += '"';
         //       res += k;
         //       res += '":"';
         //       res += s[k].toString();
         //       res += '",';
         //     }
         //     res = res.substring(0, res.length - 1);
         //
         //     res += '},';
         //     res = res.substring(0, res.length - 1);
         //   }
         //
         //   res += "]";
         //
         //   return res;
         // }
       */
  // -----------------------------------------------------------------------------

  /// BOOL

  // --------------------
  static bool boolIsTrue(bool? value){
    bool _output = false;

    if (value != null){
      _output = value;
    }

    return _output;
  }
  // --------------------
  static int superLength(dynamic list){
    int _output = 0;

    if (list is List<dynamic>){
      if (checkCanLoopList(list) == true){
        _output = list.length;
      }
    }
    else if (list is String? || list is String){
      _output = list?.length;
    }
    else if (list is int || list is int?){
      _output = list ?? 0;
    }
    else if (list is double || list is double?){
      _output = list?.toInt();
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
