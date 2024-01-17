import 'package:basics/helpers/maps/mapper_si.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('convertDynamicMap tests', () {

    test('handles null input gracefully', () {
      expect(MapperSI.convertDynamicMap(originalMap: null, transformDoubles: false), isEmpty);
    });

    test('converts simple integer values', () {
      final originalMap = {'key1': 10, 'key2': 20};
      final expectedMap = {'key1': 10, 'key2': 20};
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: false), expectedMap);
    });

    test('ignores non-integer values by default', () {
      final originalMap = {'key1': 10, 'key2': 'string', 'key3': 3.14};
      final expectedMap = {'key1': 10};
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: false), expectedMap);
    });

    test('converts doubles to integers when transformDoubles is true', () {
      final originalMap = {'key1': 10, 'key2': 3.14, 'key3': 4.56};
      final expectedMap = {'key1': 10, 'key2': 3, 'key3': 4};
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: true), expectedMap);
    });

    test('handles nested maps', () {
      final originalMap = {'key1': 10, 'key2': {'nestedKey': 20}};
      final expectedMap = {'key1': 10, };
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: false), expectedMap);
    });

    test('handles lists', () {
      final originalMap = {'key1': 10, 'key2': [1, 2, 3]};
      final expectedMap = {'key1': 10};
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: false), expectedMap);
    });

    test('handles null values within the original map', () {
      final originalMap = {'key1': 10, 'key2': null};
      final expectedMap = {'key1': 10};
      expect(MapperSI.convertDynamicMap(originalMap: originalMap, transformDoubles: false), expectedMap);
    });

  });

  group('combineMaps tests', () {

    test('handles null inputs gracefully', () {
      expect(MapperSI.combineMaps(map1: null, map2: null), isEmpty);
    });

    test('combines two simple maps', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key2': 5, 'key3': 30};
      final expectedMap = {'key1': 10, 'key2': 25, 'key3': 30};
      expect(MapperSI.combineMaps(map1: map1, map2: map2), expectedMap);
    });

    test('handles non-overlapping keys', () {
      final map1 = {'key1': 10};
      final map2 = {'key2': 20};
      final expectedMap = {'key1': 10, 'key2': 20};
      expect(MapperSI.combineMaps(map1: map1, map2: map2), expectedMap);
    });

    test('correctly combines values for overlapping keys', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key1': 5, 'key3': 30};
      final expectedMap = {'key1': 15, 'key2': 20, 'key3': 30};
      expect(MapperSI.combineMaps(map1: map1, map2: map2), expectedMap);
    });

    test('prioritizes values from map1 for overlapping keys', () {
      final map1 = {'key1': 10};
      final map2 = {'key1': 5};
      final expectedMap = {'key1': 15};
      expect(MapperSI.combineMaps(map1: map1, map2: map2), expectedMap);
    });

    test('handles empty maps', () {
      final Map<String, int> map1 = {};
      final Map<String, int> map2 = {};
      final Map<String, int> expectedMap = {};
      expect(MapperSI.combineMaps(map1: map1, map2: map2), expectedMap);
    });

  });

  group('checkMapsAreIdentical tests', () {
    test('returns true for identical maps', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key1': 10, 'key2': 20};
      expect(MapperSI.checkMapsAreIdentical(map1: map1, map2: map2), true);
    });

    test('returns false for maps with different values', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key1': 10, 'key2': 30};
      expect(MapperSI.checkMapsAreIdentical(map1: map1, map2: map2), false);
    });

    test('returns false for maps with different keys', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key1': 10, 'key3': 20};
      expect(MapperSI.checkMapsAreIdentical(map1: map1, map2: map2), false);
    });

    test('returns false for maps with different lengths', () {
      final map1 = {'key1': 10, 'key2': 20};
      final map2 = {'key1': 10};
      expect(MapperSI.checkMapsAreIdentical(map1: map1, map2: map2), false);
    });

    test('returns true for two null maps', () {
      expect(MapperSI.checkMapsAreIdentical(map1: null, map2: null), true);
    });

    test('returns false when one map is null and the other is not', () {
      final map1 = {'key1': 10};
      expect(MapperSI.checkMapsAreIdentical(map1: map1, map2: null), false);
    });

  });

}
