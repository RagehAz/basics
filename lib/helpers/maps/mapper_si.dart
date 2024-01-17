import 'package:collection/collection.dart';
/// => TAMAM
class MapperSI {
  // -----------------------------------------------------------------------------

  const MapperSI();

  // -----------------------------------------------------------------------------

  /// CONVERTER

  // --------------------
  /// AI TESTED
  static Map<String, int> convertDynamicMap({
    required Map<String, dynamic>? originalMap,
    required bool transformDoubles,
  }) {
    final Map<String, int> convertedMap = {};

    if (originalMap != null){

      originalMap.forEach((key, value) {

        if (value is int) {
          convertedMap[key] = value;
        }
        else if (transformDoubles == true && value is double){
          convertedMap[key] = value.toInt();
        }

      });

    }

    return convertedMap;
  }
  // -----------------------------------------------------------------------------

  /// COMBINE

  // --------------------
  /// AI TESTED
  static Map<String, int> combineMaps({
    required Map<String, int>? map1,
    required Map<String, int>? map2,
  }){
    Map<String, int> _output = {};

    if (map1 != null){
      _output = map1;
    }

    if (map2 != null){

      final List<String> _keys2 = map2.keys.toList();

      for (final String key in _keys2){

        final int _existingValue = _output[key] ?? 0;
        final int _valueToAdd = map2[key] ?? 0;
        final int _newValue = _existingValue + _valueToAdd;

        _output[key] = _newValue;

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// AI TESTED
  static bool checkMapsAreIdentical({
    required Map<String, int>? map1,
    required Map<String, int>? map2,
  }) {

    return const DeepCollectionEquality().equals(map1, map2);

  }
  // -----------------------------------------------------------------------------
}
