import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/maps/mapper_ss.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mockito/mockito.dart';
// class MockQuerySnapshot extends Mock implements QuerySnapshot<dynamic> {}
// class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<dynamic> {}

void main() {
  // -----------------------------------------------------------------------------

  /// getMapsPrimaryKeysValues

  // --------------------
  group('getMapsPrimaryKeysValues', () {
      // --------------------
      /// AI GENERATED
      test('getMapsPrimaryKeysValues', () {
        final List<Map<String, dynamic>> maps = [
          {'id': '1', 'name': 'John Doe'},
          {'id': '2', 'name': 'Jane Doe'},
          {'id': '3', 'name': 'Bob Smith'},
        ];

        final List<String> primaryKeys = Mapper.getMapsPrimaryKeysValues(
          maps: maps,
          // primaryKey: 'id',
        );

        expect(primaryKeys, ['1', '2', '3']);
      });
      // --------------------
      /// AI GENERATED
      test('getMapsPrimaryKeysValues 2', () {
        final List<Map<String, dynamic>> maps = [
          {'id': 1, 'name': 'John Doe'},
          {'id': 2, 'name': 'Jane Doe'},
          {'id': 3, 'name': 'Bob Smith'},
        ];

        final List<String> primaryKeys = Mapper.getMapsPrimaryKeysValues(
          maps: maps,
          // primaryKey: 'id',
          // throwErrorOnInvalidID: false,
        );

        expect(primaryKeys, []);
      });
      // --------------------
      /// AI GENERATED
      test('getMapsPrimaryKeysValues with custom primaryKey', () {
        final List<Map<String, dynamic>> maps = [
          {'custom_id': 'a1', 'name': 'John Doe'},
          {'custom_id': 'b2', 'name': 'Jane Doe'},
          {'custom_id': 'c3', 'name': 'Bob Smith'},
        ];

        final List<String> primaryKeys =
            Mapper.getMapsPrimaryKeysValues(maps: maps, primaryKey: 'custom_id');

        expect(primaryKeys, ['a1', 'b2', 'c3']);
      });
      // --------------------
    });
  // -----------------------------------------------------------------------------

  /// insertPairInMap

  // --------------------
  group('insertPairInMap', () {
    // --------------------
    /// AI GENERATED
    test('insertPairInMap', () {
      final Map<String, dynamic> map = {'name': 'John Doe'};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: 'age',
        value: 30,
        overrideExisting: true,
      );

      expect(result, {'name': 'John Doe', 'age': 30});
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with overrideExisting', () {
      final Map<String, dynamic> map = {'name': 'John Doe', 'age': 25};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: 'age',
        value: 30,
        overrideExisting: true,
      );

      expect(result, {'name': 'John Doe', 'age': 30});
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with empty map', () {
      final Map<String, dynamic> map = {};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: 'age',
        value: 30,
        overrideExisting: true,
      );

      expect(result, {'age': 30});
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with null map', () {
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: null,
        key: 'age',
        value: 30,
        overrideExisting: true,
      );

      expect(result, {'age': 30});
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with null key', () {
      final Map<String, dynamic> map = {'name': 'John Doe'};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: null,
        value: 30,
        overrideExisting: true,
      );

      expect(result, map);
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with null value', () {
      final Map<String, dynamic> map = {'name': 'John Doe'};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: 'age',
        value: null,
        overrideExisting: true,
      );

      expect(result, {'name': 'John Doe', 'age': null});
    });
    // --------------------
    /// AI GENERATED
    test('insertPairInMap with existing key and overrideExisting false', () {
      final Map<String, dynamic> map = {'name': 'John Doe', 'age': 25};
      final Map<String, dynamic> result = Mapper.insertPairInMap(
        map: map,
        key: 'age',
        value: 30,
        overrideExisting: false,
      );

      expect(result, map);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// insertMapInMap

  // --------------------
  group('insertMapInMap', () {
    // --------------------
    final List<Map<String, dynamic>> maps = [
      {'id': '1', 'name': 'John Doe', 'age': 30},
      {'id': '2', 'name': 'Jane Smith', 'age': 25},
      {'id': '3', 'name': 'Bob Johnson', 'age': 35},
    ];
    // --------------------
    /// AI GENERATED
    test('getMapFromMapsByID with existing ID', () {
      final Map<String, dynamic>? result = Mapper.getMapFromMapsByID(
        maps: maps,
        id: '2',
      );
      expect(result, {'id': '2', 'name': 'Jane Smith', 'age': 25});
    });
    // --------------------
    /// AI GENERATED
    test('getMapFromMapsByID with non-existing ID', () {
      final Map<String, dynamic>? result = Mapper.getMapFromMapsByID(
        maps: maps,
        id: '4',
      );
      expect(result, null);
    });
    // --------------------
    /// AI GENERATED
    test('getMapFromMapsByID with null ID', () {
      final Map<String, dynamic>? result = Mapper.getMapFromMapsByID(
        maps: maps,
        id: null,
      );
      expect(result, null);
    });
    // --------------------
    /// AI GENERATED
    test('getMapFromMapsByID with null maps', () {
      final Map<String, dynamic>? result = Mapper.getMapFromMapsByID(
        maps: null,
        id: '2',
      );
      expect(result, null);
    });
    // --------------------
    /// AI GENERATED
    test('getMapFromMapsByID with custom ID field name', () {
      final Map<String, dynamic>? result = Mapper.getMapFromMapsByID(
        maps: [
          {'customID': '1', 'name': 'John Doe', 'age': 30},
          {'customID': '2', 'name': 'Jane Smith', 'age': 25},
        ],
        id: '2',
        idFieldName: 'customID',
      );
      expect(result, {'customID': '2', 'name': 'Jane Smith', 'age': 25});
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// insertMapInMap

  // --------------------
  group('insertMapInMap', () {
    // --------------------
    final List<Map<String, dynamic>> _maps2 = [
      {'id': '1', 'name': 'John Doe', 'age': 30},
      {'id': '2', 'name': 'Jane Smith', 'age': 25},
      {'id': '3', 'name': 'Bob Johnson', 'age': 35},
    ];
    // --------------------
    /// AI GENERATED
    test('getMapIndexByID with existing ID', () {
      final int result = Mapper.getMapIndexByID(
        maps: _maps2,
        id: '2',
        // idFieldName: 'id',
      );
      expect(result, 1);
    });
    // --------------------
    /// AI GENERATED
    test('getMapIndexByID with non-existing ID', () {
      final int result = Mapper.getMapIndexByID(
        maps: _maps2,
        id: '4',
      );
      expect(result, -1);
    });
    // --------------------
    /// AI GENERATED
    test('getMapIndexByID with null ID', () {
      final int result = Mapper.getMapIndexByID(
        maps: _maps2,
        id: null,
      );
      expect(result, -1);
    });
    // --------------------
    /// AI GENERATED
    test('getMapIndexByID with null maps', () {
      final int result = Mapper.getMapIndexByID(
        maps: null,
        id: '2',
      );
      expect(result, -1);
    });
    // --------------------
    /// AI GENERATED
    test('getMapIndexByID with custom ID field name', () {
      final int result = Mapper.getMapIndexByID(
        maps: [
          {'customID': '1', 'name': 'John Doe', 'age': 30},
          {'customID': '2', 'name': 'Jane Smith', 'age': 25},
          {'customID': '3', 'name': 'Bob Johnson', 'age': 35},
        ],
        id: '2',
        idFieldName: 'customID',
      );
      expect(result, 1);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// insertMapInMap

  // --------------------
  group('insertMapInMap', () {
    // --------------------
    final Map<String, dynamic> _map3 = {
      'id': '1',
      'name': 'John Doe',
      'age': 30,
      'address': {'city': 'New York', 'zip': '10001'}
    };
    // --------------------
    /// PERFECT
    test('removePair', () {
      final Map<String, dynamic> _a = Mapper.removePair(
        map: {},
        fieldKey: 'id',
      );
      expect(_a, {});

      final Map<String, dynamic> _b = Mapper.removePair(
        map: null,
        fieldKey: 'id',
      );
      expect(_b, {});

      final Map<String, dynamic> _c = Mapper.removePair(
        map: {'id': 'x'},
        fieldKey: 'id',
      );
      expect(_c, {});

      const Map<String, dynamic> _map = {
        'id': 'id',
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
        'thing': 0,
      };

      final Map<String, dynamic> _d = Mapper.removePair(
        map: _map,
        fieldKey: 'id',
      );

      const Map<String, dynamic> _expected = {
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
        'thing': 0,
      };

      expect(_d, _expected);
    });
    // --------------------
    /// AI GENERATED
    test('removePair with existing key', () {
      final Map<String, dynamic>? result = Mapper.removePair(
        map: _map3,
        fieldKey: 'name',
      );
      expect(result, {
        'id': '1',
        'age': 30,
        'address': {'city': 'New York', 'zip': '10001'}
      });
    });
    // --------------------
    /// AI GENERATED
    test('removePair with non-existing key', () {
      final Map<String, dynamic> result = Mapper.removePair(
        map: _map3,
        fieldKey: 'gender',
      );
      expect(result, _map3);
    });
    // --------------------
    /// AI GENERATED
    test('removePair with null key', () {
      final Map<String, dynamic> result = Mapper.removePair(
        map: _map3,
        fieldKey: null,
      );
      expect(result, _map3);
    });
    // --------------------
    /// AI GENERATED
    test('removePair with null _map3', () {
      final Map<String, dynamic> result = Mapper.removePair(
        map: null,
        fieldKey: 'name',
      );
      expect(result, {});
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// insertMapInMap

  // --------------------
  group('insertMapInMap', () {
    // --------------------
    final Map<String, dynamic> baseMapA = {
      'id': '1',
      'name': 'John Doe',
      'age': 30,
    };
    final Map<String, dynamic> insertMapA = {
      'address': {'city': 'New York', 'zip': '10001'},
      'phone': '555-555-5555',
    };
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with replaceDuplicateKeys = true', () {
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMapA,
        insert: insertMapA,
        // replaceDuplicateKeys: true,
      );
      expect(result, {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
        'address': {'city': 'New York', 'zip': '10001'},
        'phone': '555-555-5555',
      });
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with replaceDuplicateKeys = false', () {
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMapA,
        insert: insertMapA,
        replaceDuplicateKeys: false,
      );
      expect(result, {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
        'address': {'city': 'New York', 'zip': '10001'},
        'phone': '555-555-5555',
      });
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with null baseMapA', () {
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: null,
        insert: insertMapA,
        // replaceDuplicateKeys: true,
      );

      expect(result, insertMapA);
    });
    //--------------------
    /// AI GENERATED
    test('insertMapInMap with null insertMapA', () {
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMapA,
        insert: null,
        // replaceDuplicateKeys: true,
      );
      expect(result, baseMapA);
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with duplicate keys and replaceDuplicateKeys = true', () {
      final Map<String, dynamic> baseMap = {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
      };

      final Map<String, dynamic> insertMap = {
        'id': '2',
        'name': 'Jane Doe',
        'age': 25,
      };
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMap,
        insert: insertMap,
        // replaceDuplicateKeys: true,
      );
      expect(result, {
        'id': '2',
        'name': 'Jane Doe',
        'age': 25,
        // 'address': {'city': 'New York', 'zip': '10001'},
        // 'phone': '555-555-5555',
      });
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with duplicate keys and replaceDuplicateKeys = false', () {
      final Map<String, dynamic> baseMap = {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
      };

      final Map<String, dynamic> insertMap = {
        'id': '2',
        'name': 'Jane Doe',
        'age': 25,
      };
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMap,
        insert: insertMap,
        replaceDuplicateKeys: false,
      );
      expect(result, {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
        // 'address': {'city': 'New York', 'zip': '10001'},
        // 'phone': '555-555-5555',
        // 'id': '2',
        // 'name': 'Jane Doe',
        // 'age': 25,
      });
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with nested maps', () {
      final Map<String, dynamic> baseMap = {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
      };

      final Map<String, dynamic> insertMap = {
        'address': {'city': 'Los Angeles', 'zip': '90001'},
      };

      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: baseMap,
        insert: insertMap,
        // replaceDuplicateKeys: true,
      );

      expect(result, {
        'id': '1',
        'name': 'John Doe',
        'age': 30,
        'address': {'city': 'Los Angeles', 'zip': '90001'},
      });
    });
    // --------------------
    /// AI GENERATED
    test('insertMapInMap with empty baseMap and insertMap', () {
      final Map<String, dynamic> result = Mapper.insertMapInMap(
        baseMap: {},
        insert: {},
        // replaceDuplicateKeys: true,
      );

      expect(result, {});
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// cleanDuplicateMaps

  // --------------------
  group('cleanDuplicateMaps', () {
    // --------------------
    /// AI GENERATED
    test('cleanDuplicateMaps Test for empty input list', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];
      final List<Map<String, dynamic>> result = Mapper.cleanDuplicateMaps(maps: maps);
      expect(result, <Map<String, dynamic>>[]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanDuplicateMaps Test for list with duplicate maps', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25},
        {'name': 'John', 'age': 30}
      ];
      final List<Map<String, dynamic>> result = Mapper.cleanDuplicateMaps(maps: maps);
      expect(result, <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25}
      ]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanDuplicateMaps Test for list with no duplicate maps', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25},
        {'name': 'Mike', 'age': 35}
      ];
      final List<Map<String, dynamic>> result = Mapper.cleanDuplicateMaps(maps: maps);
      expect(result, <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25},
        {'name': 'Mike', 'age': 35}
      ]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanDuplicateMaps Test for list with duplicate maps but different keys', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25},
        {'first_name': 'John', 'age': 30}
      ];
      final List<Map<String, dynamic>> result = Mapper.cleanDuplicateMaps(maps: maps);
      expect(result, <Map<String, dynamic>>[
        {'name': 'John', 'age': 30},
        {'name': 'Jane', 'age': 25},
        {'first_name': 'John', 'age': 30}
      ]);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// cleanMapsOfDuplicateIDs

  // --------------------
  group('cleanMapsOfDuplicateIDs', () {
    // --------------------
      /// AI GENERATED
    test('cleanMapsOfDuplicateIDs Test for empty input list', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];
      const String idFieldName = 'id';
      final List<Map<String, dynamic>> result = Mapper.cleanMapsOfDuplicateIDs(maps: maps, idFieldName:
      idFieldName);
      expect(result, <Map<String, dynamic>>[]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanMapsOfDuplicateIDs Test for list with duplicate IDs', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25},
        {'id': 1, 'name': 'Mike', 'age': 35}
      ];
      const String idFieldName = 'id';
      final List<Map<String, dynamic>> result = Mapper.cleanMapsOfDuplicateIDs(maps: maps, idFieldName:
      idFieldName);
      expect(result, <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25}
      ]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanMapsOfDuplicateIDs Test for list with no duplicate IDs', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25},
        {'id': 3, 'name': 'Mike', 'age': 35}
      ];
      const String idFieldName = 'id';
      final List<Map<String, dynamic>> result = Mapper.cleanMapsOfDuplicateIDs(maps: maps, idFieldName:
      idFieldName);
      expect(result, <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25},
        {'id': 3, 'name': 'Mike', 'age': 35}
      ]);
    });
    // --------------------
    /// AI GENERATED
    test('cleanMapsOfDuplicateIDs Test for list with duplicate IDs but different fields', () {
      final List<Map<String, dynamic>> maps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25},
        {'id': 1, 'first_name': 'Mike', 'age': 35}
      ];
      const String idFieldName = 'id';
      final List<Map<String, dynamic>> result = Mapper.cleanMapsOfDuplicateIDs(maps: maps, idFieldName:
      idFieldName);
      expect(result, <Map<String, dynamic>>[
        {'id': 1, 'name': 'John', 'age': 30},
        {'id': 2, 'name': 'Jane', 'age': 25}
      ]);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// replaceMapInMapsWithSameIDField

  // --------------------
  group('replaceMapInMapsWithSameIDField tests', () {
    // --------------------
    test('Test case 1: baseMaps is empty, should return empty list', () {
      final List<Map<String, dynamic>> baseMaps = <Map<String, dynamic>>[];
      final Map<String, dynamic> mapToReplace = {'id': 1, 'name': 'John'};
      final List<Map<String, dynamic>>? result = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: baseMaps,
        mapToReplace: mapToReplace,
      );
      expect(result, isEmpty);
    });
    // --------------------
    test('Test case 2: mapToReplace is null, should return baseMaps unchanged', () {
      final List<Map<String, dynamic>> baseMaps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane'},
        {'id': 3, 'name': 'Bob'},
      ];
      const Map<String, dynamic>? mapToReplace = null;
      final List<Map<String, dynamic>>? result = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: baseMaps,
        mapToReplace: mapToReplace,
      );
      expect(result, baseMaps);
    });
    // --------------------
    test('Test case 3: idFieldName not found, should return baseMaps unchanged', () {
      final List<Map<String, dynamic>> _baseMaps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane'},
        {'id': 3, 'name': 'Bob'},
      ];
      final Map<String, dynamic> _mapToReplace = {'id': 2, 'name': 'Jane Doe'};
      final List<Map<String, dynamic>>? _result = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: _baseMaps,
        mapToReplace: _mapToReplace,
        idFieldName: 'identity',
      );
      expect(_result, _baseMaps);
    });
    // --------------------
    test('Test case 4: idFieldName found, should replace map in baseMaps', () {

      final List<Map<String, dynamic>> _baseMaps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane'},
        {'id': 3, 'name': 'Bob'},
      ];
      final Map<String, dynamic> _mapToReplace = {'id': 2, 'name': 'Jane Doe'};
      final List<Map<String, dynamic>> _expected = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John'},
        {'id': 2, 'name': 'Jane Doe'},
        {'id': 3, 'name': 'Bob'},
      ];
      final List<Map<String, dynamic>>? _result = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: _baseMaps,
        mapToReplace: _mapToReplace,
      );

      expect(_result, _expected);
    });
    // --------------------
    test('Test case 5: mapToReplace is not present in baseMaps, should return baseMaps unchanged', () {
      final List<Map<String, dynamic>> _baseMaps = <Map<String, dynamic>>[
        {'id': 1, 'name': 'John'},
        {'id': 3, 'name': 'Bob'},
      ];
      final Map<String, dynamic> _mapToReplace = {'id': 2, 'name': 'Jane Doe'};

      final List<Map<String, dynamic>>? _result = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: _baseMaps,
        mapToReplace: _mapToReplace,
      );
      expect(_result, _baseMaps);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  group('cleanZeroValuesPairs / removePair', () {
    // --------------------
    const Map<String, dynamic> _mapXXX = {
      'id': 'id',
      'name': 'name',
      'phid': 'phid',
      'phidType': 'phidType',
      'thing': 0,
    };
    // --------------------
    test('cleanZeroValuesPairs', () {

      final Map<String, dynamic>? _cleaned = Mapper.cleanZeroValuesPairs(
        map: _mapXXX,
      );

      const Map<String, dynamic> _expected = {
        'id': 'id',
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
      };

      expect(_cleaned, _expected);

    });
    // --------------------
    test('removePair', () {

      final Map<String, dynamic> _a = Mapper.removePair(
        map: {},
        fieldKey: 'id',
      );
      expect(_a, {});

      final Map<String, dynamic> _b = Mapper.removePair(
        map: null,
        fieldKey: 'id',
      );
      expect(_b, {});


      final Map<String, dynamic> _c = Mapper.removePair(
        map: {'id' : 'x'},
        fieldKey: 'id',
      );
      expect(_c, {});

      final Map<String, dynamic> _d = Mapper.removePair(
        map: _mapXXX,
        fieldKey: 'id',
      );

      const Map<String, dynamic> _expected = {
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
        'thing': 0,
      };

      expect(_d, _expected);



    });
    // --------------------
    test('cleanZeroValuesPairs cleanZeroValuesPairs', () {

      const Map<String, dynamic> _map = {
        'id': 'id',
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
        'thing': 0,
      };

      final Map<String, dynamic>? _cleaned = Mapper.cleanZeroValuesPairs(
        map: _map,
      );

      const Map<String, dynamic> _expected = {
        'id': 'id',
        'name': 'name',
        'phid': 'phid',
        'phidType': 'phidType',
      };

      expect(_cleaned, _expected);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// removeMapFromMapsByIdField

  // --------------------
  group('removeMapFromMapsByIdField', () {
    // --------------------
    test('removeMapFromMapsByIdField: should remove map with matching id', () {
      final List<Map<String, dynamic>> baseMaps = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '2', 'name': 'Map 2'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> expectedOutput = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
        baseMaps: baseMaps,
        mapIDToRemove: '2',
      );
      expect(output, expectedOutput);
    });
    // --------------------
    test('removeMapFromMapsByIdField: should return original list if id not found', () {
      final List<Map<String, dynamic>> baseMaps = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '2', 'name': 'Map 2'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
        baseMaps: baseMaps,
        mapIDToRemove: '4',
      );
      expect(output, baseMaps);
    });
    // --------------------
    test('removeMapFromMapsByIdField: should return empty list if id is null', () {
      final List<Map<String, dynamic>> baseMaps = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '2', 'name': 'Map 2'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> expectedOutput = [];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
        baseMaps: baseMaps,
        mapIDToRemove: null,
      );
      expect(output, expectedOutput);
    });
    // --------------------
    test('removeMapFromMapsByIdField: should remove map with matching id using custom id field name', () {
      final List<Map<String, dynamic>> baseMaps = [
        {'custom_id': '1', 'name': 'Map 1'},
        {'custom_id': '2', 'name': 'Map 2'},
        {'custom_id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> expectedOutput = [
        {'custom_id': '1', 'name': 'Map 1'},
        {'custom_id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
        baseMaps: baseMaps,
        mapIDToRemove: '2',
        idFieldName: 'custom_id',
      );
      expect(output, expectedOutput);
    });
    // --------------------
    test('removeMapFromMapsByIdField: should return empty list if baseMaps is empty', () {
      final List<Map<String, dynamic>> baseMaps = [];
      final List<Map<String, dynamic>> expectedOutput = [];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
          baseMaps: baseMaps,
          mapIDToRemove: '1',
      );
      expect(output, expectedOutput);
    });
    // --------------------
    test('removeMapFromMapsByIdField: should return original list if baseMaps is null', () {

      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
          baseMaps: null,
          mapIDToRemove: '1',
      );

      expect(output, []);

    });
    // --------------------
    test('removeMapFromMapsByIdField: should remove only first occurrence of map with matching id', () {
      final List<Map<String, dynamic>> baseMaps = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '2', 'name': 'Map 2'},
        {'id': '2', 'name': 'Map 2 duplicate'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> expectedOutput = [
        {'id': '1', 'name': 'Map 1'},
        {'id': '2', 'name': 'Map 2 duplicate'},
        {'id': '3', 'name': 'Map 3'},
      ];
      final List<Map<String, dynamic>> output = Mapper.removeMapFromMapsByIdField(
          baseMaps: baseMaps,
          mapIDToRemove: '2',
      );
      expect(output, expectedOutput);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// cleanNullPairs

  // --------------------
  group('cleanNullPairs', () {
    // --------------------
    test('cleanNullPairs removes null values from map', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': null,
        'key3': {
          'subkey1': 'subvalue1',
          'subkey2': null,
        },
      };
      final Map<String, dynamic> expectedOutput = {
        'key1': 'value1',
        'key3': {
          'subkey1': 'subvalue1',
        },
      };
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanNullPairs returns null if all values are null', () {
      final Map<String, dynamic> input = {
        'key1': null,
        'key2': null,
      };
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, null);
    });
    // --------------------
    test('cleanNullPairs works with nested maps', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': {
          'subkey1': {
            'subsubkey1': null,
            'subsubkey2': 'subsubvalue2',
          },
          'subkey2': null,
        },
      };
      final Map<String, dynamic> expectedOutput = {
        'key1': 'value1',
        'key2': {
          'subkey1': {
            'subsubkey2': 'subsubvalue2',
          },
        },
      };
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanNullPairs works with empty input', () {
      final Map<String, dynamic>? input = {};
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, null);
    });
    // --------------------
    test('cleanNullPairs works with null input', () {
      const Map<String, dynamic>? input = null;
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, null);
    });
    // --------------------
    test('cleanNullPairs works with map containing only non-null values', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
      };
      final Map<String, dynamic> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
      };
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanNullPairs works with nested maps containing only non-null values', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': {
          'subkey1': {
            'subsubkey1': 'subsubvalue1',
            'subsubkey2': 'subsubvalue2',
          },
          'subkey2': 'subvalue2',
        },
      };
      final Map<String, dynamic> expectedOutput = {
        'key1': 'value1',
        'key2': {
          'subkey1': {
            'subsubkey1': 'subsubvalue1',
            'subsubkey2': 'subsubvalue2',
          },
          'subkey2': 'subvalue2',
        },
      };
      final Map<String, dynamic>? output = Mapper.cleanNullPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// cleanNullPairs

  // --------------------
  group('cleanZeroValuesPairs', () {
    // --------------------
    test('cleanZeroValuesPairs removes zero values from map', () {
      final Map<String, dynamic> input = {
        'key1': 0,
        'key2': 'value2',
        'key3': {
          'subkey1': 0,
          'subkey2': 'subvalue2',
        },
      };
      final Map<String, dynamic> expectedOutput = {
        'key2': 'value2',
        'key3': {
          'subkey2': 'subvalue2',
        },
      };
      final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanZeroValuesPairs works with nested maps', () {
      final Map<String, dynamic> input = {
        'key1': 0,
        'key2': {
          'subkey1': {
            'subsubkey1': 0,
            'subsubkey2': 'subsubvalue2',
          },
          'subkey2': 0,
        },
      };
      final Map<String, dynamic> expectedOutput = {
        'key2': {
          'subkey1': {
            'subsubkey2': 'subsubvalue2',
          },
        },
      };
      final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanZeroValuesPairs works with empty input', () {
      final Map<String, dynamic> input = {};
      final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
      expect(output, null);
    });
    // --------------------
    test('cleanZeroValuesPairs works with map containing only non-zero values', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
      };
      final Map<String, dynamic> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
      };
      final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
      expect(output, expectedOutput);
    });
    // --------------------
    test('cleanZeroValuesPairs works with null input', () {
      const Map<String, dynamic>? input = null;
      final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
      expect(output, null);
    });
    // --------------------
    test('cleanZeroValuesPairs works with map containing mixed types of values', () {
        final Map<String, dynamic> input = {
          'key1': 0,
          'key2': 'value2',
          'key3': [0, 1, 2],
          'key4': {
            'subkey1': 0,
            'subkey2': ['subvalue1', 0, 'subvalue3'],
          },
        };
        final Map<String, dynamic> expectedOutput = {
          'key2': 'value2',
          'key3': [0, 1, 2],
          'key4': {
            'subkey2': ['subvalue1', 0, 'subvalue3'],
          },
        };
        final Map<String, dynamic>? output = Mapper.cleanZeroValuesPairs(map: input);
        expect(output, expectedOutput);
      });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkCanLoopList

  // --------------------
  group('checkCanLoopList', () {
    // --------------------
    test('checkCanLoopList returns true for non-empty list', () {
      final List<dynamic> input = [1, 2, 3];
      final bool output = Lister.checkCanLoop(input);
      expect(output, true);
    });
    // --------------------
    test('checkCanLoopList returns false for empty list', () {
      final List<dynamic> input = [];
      final bool output = Lister.checkCanLoop(input);
      expect(output, false);
    });
    // --------------------
    test('checkCanLoopList returns false for null input', () {
      final bool output = Lister.checkCanLoop(null);
      expect(output, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkCanLoopList

  // --------------------
  group('checkListHasNullValue', () {
    // --------------------
    test('checkListHasNullValue returns true for list containing null value', () {
      final List<dynamic> input = [1, 2, null, 4];
      final bool output = Lister.checkListHasNullValue(input);
      expect(output, true);
    });
    // --------------------
    test('checkListHasNullValue returns false for list not containing null value', () {
      final List<dynamic> input = [1, 2, 3, 4];
      final bool output = Lister.checkListHasNullValue(input);
      expect(output, false);
    });
    // --------------------
    test('checkListHasNullValue returns false for empty list', () {
      final List<dynamic> input = [];
      final bool output = Lister.checkListHasNullValue(input);
      expect(output, false);
    });
    // --------------------
    test('checkListHasNullValue returns false for null input', () {
      final bool output = Lister.checkListHasNullValue(null);
      expect(output, false);
    });
    // --------------------
    test('checkListHasNullValue works with list containing mixed types of values', () {
      final List<dynamic> input = [1, 'string', null, {'key': 'value'}];
      final bool output = Lister.checkListHasNullValue(input);
      expect(output, true);
    });
    // --------------------
    test('checkListHasNullValue works with list containing only non-null values', () {
      final List<dynamic> input = [1, 'string', 3.14, {'key': 'value'}];
      final bool output = Lister.checkListHasNullValue(input);
      expect(output, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkListsAreIdentical

  // --------------------
  group('checkListsAreIdentical', () {
    // --------------------
    test('checkListsAreIdentical returns true for identical lists', () {
      final List<dynamic> input1 = [1, 2, 3];
      final List<dynamic> input2 = [1, 2, 3];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical returns false for lists with different length', () {
      final List<dynamic> input1 = [1, 2, 3];
      final List<dynamic> input2 = [1, 2, 3, 4];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkListsAreIdentical returns false for lists with different values', () {
      final List<dynamic> input1 = [1, 2, 3];
      final List<dynamic> input2 = [1, 2, 4];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkListsAreIdentical returns true for empty lists', () {
      final List<dynamic> input1 = [];
      final List<dynamic> input2 = [];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical returns true for null inputs', () {
      final bool output = Lister.checkListsAreIdentical(list1: null, list2: null);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical works with lists containing mixed types of values', () {
      final List<dynamic> input1 = [
        1,
        'string',
        3.14,
        {'key': 'value'}
      ];
      final List<dynamic> input2 = [
        1,
        'string',
        3.14,
        {'key': 'value'}
      ];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical works with lists containing only non-null values', () {
      final List<dynamic> input1 = [
        1,
        'string',
        3.14,
        {'key': 'value'}
      ];
      final List<dynamic> input2 = [
        1,
        'string',
        3.14,
        {'key': 'value'}
      ];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical works with lists containing multiple null values', () {
      final List<dynamic> input1 = [1, null, 3.14, null, 'string', null];
      final List<dynamic> input2 = [1, null, 3.14, null, 'string', null];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkListsAreIdentical works with lists containing mixed types of values and different order', () {
      final List<dynamic> input1 = [
        1,
        'string',
        3.14,
        {'key': 'value'}
      ];
      final List<dynamic> input2 = [
        {'key': 'value'},
        3.14,
        'string',
        1
      ];
      final bool output = Lister.checkListsAreIdentical(list1: input1, list2: input2);
      expect(output, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkMapsAreIdentical

  // --------------------
  group('checkMapsAreIdentical', () {
    // --------------------
    test('checkMapsAreIdentical returns true for identical maps', () {
      final Map<String, dynamic> input1 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final Map<String, dynamic> input2 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkMapsAreIdentical returns false for maps with different keys', () {
      final Map<String, dynamic> input1 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final Map<String, dynamic> input2 = {'key1': 1, 'key2': 'value', 'key4': 3.14};
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsAreIdentical returns false for maps with different values', () {
      final Map<String, dynamic> input1 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final Map<String, dynamic> input2 = {'key1': 1, 'key2': 'value2', 'key3': 3.14};
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsAreIdentical returns true for maps with different order of keys', () {
      final Map<String, dynamic> input1 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final Map<String, dynamic> input2 = {'key3': 3.14, 'key1': 1, 'key2': 'value'};
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkMapsAreIdentical returns true for null inputs', () {
      final bool output = Mapper.checkMapsAreIdentical(map1: null, map2: null);
      expect(output, true);
    });
    // --------------------
    test('checkMapsAreIdentical returns false for one null input and one non-null input', () {
      final Map<String, dynamic> input1 = {'key1': 1, 'key2': 'value', 'key3': 3.14};
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: null);
      expect(output, false);
    });
    // --------------------
    test('checkMapsAreIdentical works with maps containing mixed types of values', () {
      final Map<String, dynamic> input1 = {
        'key1': 1,
        'key2': 'value',
        'key3': 3.14,
        'key4': {'subkey': 'subvalue'}
      };
      final Map<String, dynamic> input2 = {
        'key1': 1,
        'key2': 'value',
        'key3': 3.14,
        'key4': {'subkey': 'subvalue'}
      };
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkMapsAreIdentical works with maps containing nested maps with different values', () {
      final Map<String, dynamic> input1 = {
        'key1': 1,
        'key2': 'value',
        'key3': 3.14,
        'key4': {'subkey': 'subvalue'}
      };
      final Map<String, dynamic> input2 = {
        'key1': 1,
        'key2': 'value',
        'key3': 3.14,
        'key4': {'subkey': 'subvalue2'}
      };
      final bool output = Mapper.checkMapsAreIdentical(map1: input1, map2: input2);
      expect(output, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkMapsListsAreIdentical

  // --------------------
  group('checkMapsListsAreIdentical', () {
    // --------------------
    test('checkMapsListsAreIdentical returns true for identical input lists', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns false for lists with different maps', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value3'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns true for empty input lists', () {
      final List<Map<String, dynamic>> input1 = [];
      final List<Map<String, dynamic>> input2 = [];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, true);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns false for one empty and one non-empty input list', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns true for identical input lists with different order of maps', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [
        {'key3': 3.14, 'key4': 'value2'},
        {'key1': 1, 'key2': 'value'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns false for lists with different length', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [
        {'key1': 1, 'key2': 'value'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, false);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns false when one of the input lists is null', () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: null);
      expect(output, false);
    });
    // --------------------
    test('checkMapsListsAreIdentical returns false when maps inside the lists have different values for the same key',
        () {
      final List<Map<String, dynamic>> input1 = [
        {'key1': 1, 'key2': 'value'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final List<Map<String, dynamic>> input2 = [
        {'key1': 1, 'key2': 'value2'},
        {'key3': 3.14, 'key4': 'value2'}
      ];
      final bool output = Mapper.checkMapsListsAreIdentical(maps1: input1, maps2: input2);
      expect(output, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkMapsContainMapWithID

  // --------------------
  group('checkMapsContainMapWithID', () {
    // --------------------
    test('checkMapsContainMapWithID returns true when the map with the specified id is present in the input list', () {
        final List<Map<String, dynamic>> input1 = [{'id': 1, 'key2': 'value'}, {'id': 2, 'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'id': 2, 'key3': 3.14, 'key4': 'value2'};
        final bool output = Mapper.checkMapsContainMapWithID(maps: input1, map: input2);
        expect(output, true);
      });
    // --------------------
    test('checkMapsContainMapWithID returns false when the input map is null', () {
        final List<Map<String, dynamic>> input1 = [{'id': 1, 'key2': 'value'}, {'id': 2, 'key3': 3.14, 'key4': 'value2'}];
        final bool output = Mapper.checkMapsContainMapWithID(maps: input1, map: null);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainMapWithID returns false when the input list is empty', () {
        final List<Map<String, dynamic>> input1 = [];
        final Map<String, dynamic> input2 = {'id': 2, 'key3': 3.14, 'key4': 'value2'};
        final bool output = Mapper.checkMapsContainMapWithID(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainMapWithID returns false when the map with the specified id is not present in the input list', () {
        final List<Map<String, dynamic>> input1 = [{'id': 1, 'key2': 'value'}, {'id': 2, 'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'id': 3, 'key3': 3.14, 'key4': 'value2'};
        final bool output = Mapper.checkMapsContainMapWithID(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainMapWithID returns false when the input list is empty', () {
        final List<Map<String, dynamic>> input1 = [];
        final Map<String, dynamic> input2 = {'myId': 2, 'key3': 3.14, 'key4': 'value2'};
        final bool output = Mapper.checkMapsContainMapWithID(
            maps: input1,
            map: input2,
            idFieldName: 'myId'
        );
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainMapWithID returns false when the input map is null', () {
        final List<Map<String, dynamic>> input1 = [{'id': 1, 'key2': 'value'}, {'myId': 2, 'key3': 3.14, 'key4': 'value2'}];
        const Map<String, dynamic>? input2 = null;
        final bool output = Mapper.checkMapsContainMapWithID(maps: input1, map: input2, idFieldName:
        'm'
            'yId');
        expect(output, false);
      });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkMapsContainIdenticalMap

  // --------------------
  group('checkMapsContainIdenticalMap', () {
    // --------------------
    test('checkMapsContainIdenticalMap returns false when the input list is empty', () {
        final List<Map<String, dynamic>> input1 = [];
        final Map<String, dynamic> input2 = {'key1': 1, 'key2': 'value'};
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainIdenticalMap returns false when the input map is null', () {
        final List<Map<String, dynamic>> input1 = [{'key1': 1, 'key2': 'value'}, {'key3': 3.14, 'key4': 'value2'}];
        const Map<String, dynamic>? input2 = null;
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainIdenticalMap returns true when the input list contains identical map', () {
        final List<Map<String, dynamic>> input1 = [{'key1': 1, 'key2': 'value'}, {'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'key1': 1, 'key2': 'value'};
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, true);
      });
    // --------------------
    test('checkMapsContainIdenticalMap returns false when the input list contains different maps', () {
        final List<Map<String, dynamic>> input1 = [{'key1': 1, 'key2': 'value'}, {'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'key5': true, 'key6': 'value3'};
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainIdenticalMap returns false when the input list contains maps with same keys but different values', () {
        final List<Map<String, dynamic>> input1 = [{'key1': 1, 'key2': 'value'}, {'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'key1': 2, 'key2': 'value'};
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, false);
      });
    // --------------------
    test('checkMapsContainIdenticalMap returns true when the input list contains identical maps with same keys and values but in different order', () {
        final List<Map<String, dynamic>> input1 = [{'key1': 1, 'key2': 'value'}, {'key3': 3.14, 'key4': 'value2'}];
        final Map<String, dynamic> input2 = {'key2': 'value', 'key1': 1};
        final bool output = Mapper.checkMapsContainIdenticalMap(maps: input1, map: input2);
        expect(output, true);
      });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// checkMapsContainValue

  // --------------------
  group('checkMapsContainValue', () {
    // --------------------
    test('should return true when the field and value are present in one of the maps', () {
      final listOfMaps = [
        {'field1': 'value1', 'field2': 'value2'},
        {'field1': 'value3', 'field2': 'value4'},
      ];
      const field = 'field1';
      const value = 'value1';
      final result = Mapper.checkMapsContainValue(maps: listOfMaps, field: field, value:
      value);
      expect(result, true);
    });
    // --------------------
    test('should return false when the field and value are not present in any of the maps', () {
      final listOfMaps = [
        {'field1': 'value1', 'field2': 'value2'},
        {'field1': 'value3', 'field2': 'value4'},
      ];
      const field = 'field1';
      const value = 'value5';
      final result = Mapper.checkMapsContainValue(maps: listOfMaps, field: field, value:
      value);
      expect(result, false);
    });
    // --------------------
    test('should return false when the list is empty', () {

      final List<Map<String, dynamic>> listOfMaps = [];
      const field = 'field1';
      const value = 'value5';

      final result = Mapper.checkMapsContainValue(
          maps: listOfMaps,
          field: field,
          value: value
      );

      expect(result, false);
    });
    // --------------------
    test('should return false when the field is not present in the maps', () {
      final listOfMaps = [
        {'field1': 'value1', 'field2': 'value2'},
        {'field1': 'value3', 'field2': 'value4'},
      ];
      const field = 'field3';
      const value = 'value5';
      final result = Mapper.checkMapsContainValue(
          maps: listOfMaps,
          field: field,
          value: value,
      );
      expect(result, false);
    });
    // --------------------
    test('when listOfMaps is null', () {
      const listOfMaps = null;
      const field = 'field3';
      const value = 'value5';
      final result = Mapper.checkMapsContainValue(
          maps: listOfMaps,
          field: field,
          value: value,
      );
      expect(result, false);
    });
    // --------------------
    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];
    // --------------------
    test('field is null', () {
      final listOfMaps = [
        {'field1': 'value1', 'field2': 'value2'},
        {'field1': 'value3', 'field2': 'value4'},
      ];
      const field = null;
      const value = 'value5';
      final result = Mapper.checkMapsContainValue(
          maps: listOfMaps,
          field: field,
          value: value,
      );
      expect(result, false);
    });
    // --------------------
    test('value is null', () {
      final listOfMaps = [
        {'field1': 'value1', 'field2': 'value2'},
        {'field1': 'value3', 'field2': 'value4'},
      ];
      const field = 'field3';
      const value = null;
      final result = Mapper.checkMapsContainValue(
          maps: listOfMaps,
          field: field,
          value: value,
      );
      expect(result, false);

    });
    // --------------------
    test('correct input id = a', () {
      final bool _result = Mapper.checkMapsContainValue(
        maps: _listOfMaps,
        field: 'id',
        value: 'a',
      );
      expect(_result, true);
    });
    // --------------------
    test('in-correct input id = c', () {
      final bool _result = Mapper.checkMapsContainValue(
        maps: _listOfMaps,
        field: 'id',
        value: 'c',
      );
      expect(_result, false);
    });
    // --------------------
    test('in-correct input id = null', () {
      final bool _result = Mapper.checkMapsContainValue(
        maps: _listOfMaps,
        field: 'id',
        value: null,
      );
      expect(_result, false);
    });
    // --------------------
    test('in-correct field = koko, input = toto', () {
      final bool _result = Mapper.checkMapsContainValue(
        maps: _listOfMaps,
        field: 'koko',
        value: 'toto',
      );
      expect(_result, false);
    });
    // --------------------
  });
  // -----------------------------------------------------------------------------

  /// getKeysHavingThisValue

  // --------------------
  group('getKeysHavingThisValue', () {

    test('returns empty list when map is null', () {
      final List<String> result = MapperSS.getKeysHavingThisValue(map: null, value: 'test');
      expect(result, isEmpty);
    });

    test('returns empty list when value is null', () {
      final Map<String, String> testMap = {'key1': 'value1', 'key2': 'value2'};
      final List<String> result = MapperSS.getKeysHavingThisValue(map: testMap, value: null);
      expect(result, isEmpty);
    });

    test('returns correct keys when value is present in map', () {
      final Map<String, String> testMap = {'key1': 'value1', 'key2': 'value2', 'key3': 'value1'};
      final List<String> result = MapperSS.getKeysHavingThisValue(map: testMap, value: 'value1');
      expect(result, ['key1', 'key3']);
    });

    test('returns empty list when value is not present in map', () {
      final Map<String, String> testMap = {'key1': 'value1', 'key2': 'value2'};
      final List<String> result = MapperSS.getKeysHavingThisValue(map: testMap, value: 'value3');
      expect(result, isEmpty);
    });

    test('returns empty list when Lister.checkCanLoopList returns false', () {
      final Map<String, String> testMap = {'key1': 'value1', 'key2': 'value2'};
      final List<String> result = MapperSS.getKeysHavingThisValue(map: testMap, value: 'value3');
      expect(result, isEmpty);
    });

  });
  // -----------------------------------------------------------------------------

  /// insertPairInMapWithStringValue

  // --------------------
  group('insertPairInMapWithStringValue', () {

    test('inserts a new key-value pair into the map', () {
      final Map<String, String> map = {'key1': 'value1'};
      final Map<String, String?>? result = MapperSS.insertPairInMapWithStringValue(
        map: map,
        key: 'key2',
        value: 'value2',
        overrideExisting: true,
      );
      expect(result, {'key1': 'value1', 'key2': 'value2'});
    });

    test('overrides an existing key-value pair in the map', () {
      final Map<String, String> map = {'key1': 'value1'};
      final Map<String, String?>? result = MapperSS.insertPairInMapWithStringValue(
        map: map,
        key: 'key1',
        value: 'new value',
        overrideExisting: true,
      );
      expect(result, {'key1': 'new value'});
    });

    test('keeps an existing key-value pair in the map', () {
      final Map<String, String> map = {'key1': 'value1'};
      final Map<String, String?>? result = MapperSS.insertPairInMapWithStringValue(
        map: map,
        key: 'key1',
        value: 'new value',
        overrideExisting: false,
      );
      expect(result, {'key1': 'value1'});
    });

    test('inserts a new key-value pair if the input map is null', () {

      const Map<String, String>? map = null;

      final Map<String, String?>? result = MapperSS.insertPairInMapWithStringValue(
        map: map,
        key: 'key1',
        value: 'value1',
        overrideExisting: true,
      );
      expect(result, {'key1': 'value1'});
    });

    test('inserts a new key-value pair if the key is null', () {
      final Map<String, String> map = {};
      final Map<String, String?>? result = MapperSS.insertPairInMapWithStringValue(
        map: map,
        key: null,
        value: 'value1',
        overrideExisting: true,
      );
      expect(result, {});
    });

    // test('inserts a new key-value pair if the value is null', () {
    //   final Map<String, String> map = {};
    //   final Map<String, String>? result = Mapper.insertPairInMapWithStringValue(
    //     map: map,
    //     key: 'key1',
    //     value: null,
    //     overrideExisting: true,
    //   );
    //   expect(result, {'key1': null});
    // });


  });
  // -----------------------------------------------------------------------------

  /// combineStringStringMap

  // --------------------
  group('combineStringStringMap', () {

    test('combines two maps', () {
      final Map<String, String> baseMap = {'key1': 'value1'};
      final Map<String, String> insert = {'key2': 'value2'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: true,
      );
      expect(result, {'key1': 'value1', 'key2': 'value2'});
    });

    test('overrides duplicate keys in the base map', () {
      final Map<String, String> baseMap = {'key1': 'value1'};
      final Map<String, String> insert = {'key1': 'new value'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: true,
      );
      expect(result, {'key1': 'new value'});
    });

    test('keeps duplicate keys in the base map', () {
      final Map<String, String> baseMap = {'key1': 'value1'};
      final Map<String, String> insert = {'key1': 'new value'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: false,
      );
      expect(result, {'key1': 'value1'});
    });

    test('returns an empty map if baseMap is null', () {
      const Map<String, String>? baseMap = null;
      final Map<String, String> insert = {'key1': 'value1'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: true,
      );
      expect(result, {});
    });

    test('returns the baseMap if insert is null', () {
      final Map<String, String> baseMap = {'key1': 'value1'};
      const Map<String, String>? insert = null;
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: true,
      );
      expect(result, baseMap);
    });

    test('inserts new key-value pairs and replaces existing ones if replaceDuplicateKeys is true', () {
      final Map<String, String> baseMap = {'key1': 'value1', 'key2': 'value2'};
      final Map<String, String> insert = {'key3': 'value3', 'key2': 'new_value2'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: true,
      );
      expect(result, {'key1': 'value1', 'key2': 'new_value2', 'key3': 'value3'});
    });

    test('inserts new key-value pairs and keeps existing ones if replaceDuplicateKeys is false', () {
      final Map<String, String> baseMap = {'key1': 'value1', 'key2': 'value2'};
      final Map<String, String> insert = {'key3': 'value3', 'key2': 'new_value2'};
      final Map<String, String?>? result = MapperSS.combineStringStringMap(
        baseMap: baseMap,
        insert: insert,
        replaceDuplicateKeys: false,
      );
      expect(result, {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'});
    });

  });
  // -----------------------------------------------------------------------------

  /// getStringStringMapFromImmutableMapStringObject

  // --------------------
  /*
  group('getStringStringMapFromImmutableMapStringObject tests: ', () {

    test('Should return an empty map if input is null', () {
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(null);
      expect(output, {});
    });

    test('Should return a map with string keys and string values if input is a Map<String,
    dynamic>',
    () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 2,
        'key3': true,
      };
      final Map<String, String> output = Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': '2', 'key3': 'true'});
    });

    test('Should return the same map if input is already a Map<String, String>', () {
      final Map<String, String> input = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, input);
    });

    test('Test with valid input: Map<String, dynamic>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 2,
        'key3': true,
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': '2', 'key3': 'true'});
    });

    test('Test with valid input: Map<String, dynamic>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 2,
        'key3': true,
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': '2', 'key3': 'true'});
    });

    test('Test with valid input: _InternalLinkedHashMap<String, dynamic>', () {
      final Map<String, dynamic> input = <String, dynamic>{};
      input['key1'] = 'value1';
      input['key2'] = 2;
      input['key3'] = true;
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': '2', 'key3': 'true'});
    });

    test('Test with valid input: _InternalLinkedHashMap<String, dynamic>', () {
      final Map<String, dynamic> input = <String, dynamic>{};
      input['key1'] = 'value1';
      input['key2'] = 2;
      input['key3'] = true;
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': '2', 'key3': 'true'});
    });

    test('Test with valid input: _InternalLinkedHashMap<String, String>', () {
      final Map<String, String> input = <String, String>{};
      input['key1'] = 'value1';
      input['key2'] = 'value2';
      input['key3'] = 'value3';
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'});
    });

    test('Test Case 1: input is valid ImmutableMap<String, dynamic>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, expectedOutput);
    });

    test('Test Case 2: input is valid Map<String, dynamic>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, expectedOutput);
    });

    test('Test Case 3: input is valid Map<String, dynamic>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, expectedOutput);
    });

    test('Test Case 4: input is valid Map<String, dynamic?>', () {
      final Map<String, dynamic> input = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> expectedOutput = {
        'key1': 'value1',
        'key2': 'value2',
        'key3': 'value3',
      };
      final Map<String, String> output =
          Mapper.getStringStringMapFromImmutableMapStringObject(input);
      expect(output, expectedOutput);
    });

  });
   */
  // -----------------------------------------------------------------------------

  /// getFirstInList

  // --------------------
   group('Mapper.getFirstInList', () {
    test('Returns null when list is null', () {
      final result = Mapper.getFirstInList(null);
      expect(result, isNull);
    });

    test('Returns null when list is empty', () {
      final result = Mapper.getFirstInList([]);
      expect(result, isNull);
    });

    test('Returns first element when list has one element', () {
      final result = Mapper.getFirstInList([5]);
      expect(result, equals(5));
    });

    test('Returns last element when list has multiple elements', () {
      final result = Mapper.getFirstInList([1, 2, 3, 4, 5]);
      expect(result, equals(5));
    });

    test('Returns null when list contains null values', () {
      final result = Mapper.getFirstInList([null, null]);
      expect(result, isNull);
    });

    test('Returns first non-null element when list contains null and non-null values', () {
      final result = Mapper.getFirstInList([null, 2, null, 4]);
      expect(result, equals(4));
    });
  });
  // -----------------------------------------------------------------------------
}
