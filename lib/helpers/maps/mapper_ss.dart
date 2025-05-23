import 'package:basics/helpers/maps/lister.dart';
/// => TAMAM
abstract class MapperSS {
  // -----------------------------------------------------------------------------

  /// CREATORS

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

      if (Lister.checkCanLoop(_keys) == true){
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

  /// GETTERS

  // --------------------
  /// AI TESTED
  static List<String> getKeysHavingThisValue({
    required Map<String, String>? map,
    required String? value,
    String prefix = '',
  }){
    final List<String> _output = <String>[];

    if (map != null && value != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          final String? _mapValue = map['$prefix$key'];

          if (_mapValue == value){
            _output.add(key);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

        if (Lister.checkCanLoop(_keys) == true){

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

  /// MODIFIERS

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
  static Map<String, String> combineStringStringMap({
    required Map<String, String>? baseMap,
    required Map<String, String>? insert,
    required bool replaceDuplicateKeys,
  }){
    Map<String, String> _output = {};

    if (baseMap != null){

      _output = baseMap;

      if (insert != null){

        final List<String> _keys = insert.keys.toList();

        if (Lister.checkCanLoop(_keys) == true){

          for (final String key in _keys){

            if (insert[key] != null){
              _output = insertPairInMapWithStringValue(
                map: _output,
                key: key,
                value: insert[key]!,
                overrideExisting: replaceDuplicateKeys,
              )!;
            }

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? lowerCaseAllKeys({
    required Map<String, String>? map,
  }){
    Map<String, String>? _output;

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        _output = {};

        for (final String key in _keys){

          final String _key = key.toLowerCase();
          final String? _value = map[key];

          if (_value != null){
            _output = insertPairInMapWithStringValue(
              map: _output,
              key: _key,
              value: _value,
              overrideExisting: true,
            );
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLEANERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, String>? cleanNullPairs({
    required Map<String, String?>? map,
  }){
    Map<String, String>? _output;

    if (map != null){

      _output = {};
      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        final String? _value = map[key];

        if (_value != null){
          _output[key] = _value;
        }

      }

      if (_output.keys.isEmpty == true){
        _output = null;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
