import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('generatePathsFromMap', () {

    test('test1', () {

      final Map<String, dynamic> _map = {
        'a' : 'aa',
        'b' : 'bb',
      };

      final List<String> _expected = [
        'a/',
        'b/',
      ];

      final List<String> _generated = MapPathing.generatePathsFromMap(
        map: _map,
      );

      final bool _identical = Lister.checkListsAreIdentical(
        list1: _expected,
        list2: _generated,
      );

      Stringer.blogStrings(strings: _generated, invoker: 'generated Paths');

      expect(_identical, true);

    });

    test('test2', () {

      final Map<String, dynamic> _map = {
        'a' : 'aa',
        'b' : 'bb',
        'c' : {
          'c1': 'xxx',
          'c2': 2,
          'c3': 3.3,
        },
      };

      final List<String> _expected = [
        'a/',
        'b/',
        'c/',
        'c/c1/',
        'c/c2/',
        'c/c3/',
      ];

      final List<String> _generated = MapPathing.generatePathsFromMap(
        map: _map,
      );

      final bool _identical = Lister.checkListsAreIdentical(
        list1: _expected,
        list2: _generated,
      );

      Stringer.blogStrings(strings: _generated, invoker: 'generated Paths');

      expect(_identical, true);

    });

    test('test3', () {

      final Map<String, dynamic> _map = {
        'a' : 'aa',
        'b' : 'bb',
        'c' : {
          'c1': 'xxx',
          'c2': 2,
          'c3': 3.3,
        },
        'd': [
          'x',
          'y',
          'z',
        ],
      };

      final List<String> _expected = [
        'a/',
        'b/',
        'c/',
        'c/c1/',
        'c/c2/',
        'c/c3/',
        'd/',
        'd/i:0/',
        'd/i:1/',
        'd/i:2/',
      ];

      final List<String> _generated = MapPathing.generatePathsFromMap(
        map: _map,
      );

      final bool _identical = Lister.checkListsAreIdentical(
        list1: _expected,
        list2: _generated,
      );

      Stringer.blogStrings(strings: _generated, invoker: 'generated Paths');

      expect(_identical, true);

    });

    test('test4', () {

      final Map<String, dynamic> _map = {
        'a' : 'aa',
        'b' : 'bb',
        'c' : {
          'c1': 'xxx',
          'c2': 2,
          'c3': 3.3,
        },
        'd': [
          'x',
          'y',
          'z',
        ],
        'e': {
          'e1': 'x',
          'e2': {
            'q': 'qq',
            'w': 'ww',
          },
          'e3': [
            'w',
            'w',
            'w',
          ],
        },
      };

      final List<String> _expected = [
        'a/',
        'b/',
        'c/',
        'c/c1/',
        'c/c2/',
        'c/c3/',
        'd/',
        'd/i:0/',
        'd/i:1/',
        'd/i:2/',
        'e/',
        'e/e1/',
        'e/e2/',
        'e/e2/q/',
        'e/e2/w/',
        'e/e3/',
        'e/e3/i:0/',
        'e/e3/i:1/',
        'e/e3/i:2/',
      ];

      final List<String> _generated = MapPathing.generatePathsFromMap(
        map: _map,
      );

      final bool _identical = Lister.checkListsAreIdentical(
        list1: _expected,
        list2: _generated,
      );

      Stringer.blogStrings(strings: _generated, invoker: 'generated Paths');

      expect(_identical, true);

    });

    test('test5', () {

      final Map<String, dynamic> _map = {
        'a' : {
          'x': [
            '1',
            {
              'son': 'boy',
              'daughter': 'girl',
              'list': ['x', 2, true],
            },
            'xxx',
            [0,1,2],
          ],
          'y': {
            'ee': 2,
            'map': {
              'maw': {
                'x': 'xx',
              },
            },
          },
        },
      };

      final List<String> _expected = [
        'a/',
        'a/x/',
        'a/x/i:0/',
        'a/x/i:1/',
        'a/x/i:1/son/',
        'a/x/i:1/daughter/',
        'a/x/i:1/list/',
        'a/x/i:1/list/i:0/',
        'a/x/i:1/list/i:1/',
        'a/x/i:1/list/i:2/',
        'a/x/i:2/',
        'a/x/i:3/',
        'a/x/i:3/i:0/',
        'a/x/i:3/i:1/',
        'a/x/i:3/i:2/',

        'a/y/',
        'a/y/ee/',
        'a/y/map/',
        'a/y/map/maw/',
        'a/y/map/maw/x/'

      ];

      final List<String> _generated = MapPathing.generatePathsFromMap(
        map: _map,
      );

      final bool _identical = Lister.checkListsAreIdentical(
        list1: _expected,
        list2: _generated,
      );

      Stringer.blogStrings(strings: _generated, invoker: 'generated Paths');

      expect(_identical, true);

    });

    test('Empty map should return an empty list', () {
      final result = MapPathing.generatePathsFromMap(map: {});
      expect(result, isEmpty);
    });

    test('Map with a single value should generate a single path', () {
      final map = {'key1': 'value1'};
      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, ['key1/']);
    });

    test('Map with nested maps and lists should generate correct paths', () {
      final map = {
        'key1': {'key2': 'value2'},
        'key3': ['item1', 'item2'],
        'key4': 'value4',
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key1/key2/',
        'key3/',
        'key3/i:0/',
        'key3/i:1/',
        'key4/',
      ]);
    });

    test('Map with empty nested map should generate correct path', () {
      final map = {
        'key1': {},
      };
      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, ['key1/']);
    });

    test('Map with null nested map should generate correct path', () {
      final map = {'key1': null};
      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, ['key1/']);
    });

    test('Map with deep nesting should generate correct paths', () {
      final map = {
        'key1': {
          'key2': {
            'key3': {
              'key4': {
                'key5': 'value5',
              },
            },
          },
        },
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key1/key2/',
        'key1/key2/key3/',
        'key1/key2/key3/key4/',
        'key1/key2/key3/key4/key5/'
      ]);
    });

    test('Map with mixed data types should generate correct paths', () {

      final map = {
        'key1': 123,
        'key2': {'key3': true},
        'key4': ['item1', 'item2'],
        'key5': null,
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key2/',
        'key2/key3/',
        'key4/',
        'key4/i:0/',
        'key4/i:1/',
        'key5/',
      ]);

    });

  });

  group('generatePathsFromMap x', () {

    test('Nested maps with null values should generate correct paths', () {
      final map = {
        'key1': {
          'key2': {'key3': null},
          'key4': null,
        },
        'key5': {'key6': null},
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key1/key2/',
        'key1/key2/key3/',
        'key1/key4/',
        'key5/',
        'key5/key6/',
      ]);
    });

    test('Empty nested lists should not affect paths', () {
      final map = {
        'key1': [],
        'key2': {'key3': []},
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key2/',
        'key2/key3/',
      ]);
    });

    test('Map with complex nested structures should generate correct paths', () {
      final map = {
        'key1': {
          'key2': [
            {'key3': 'value3'},
            {'key4': ['item4']},
            {'key5': {'key6': 'value6'}},
          ],
        },
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'key1/',
        'key1/key2/',
        'key1/key2/i:0/',
        'key1/key2/i:0/key3/',
        'key1/key2/i:1/',
        'key1/key2/i:1/key4/',
        'key1/key2/i:1/key4/i:0/',
        'key1/key2/i:2/',
        'key1/key2/i:2/key5/',
        'key1/key2/i:2/key5/key6/',
      ]);
    });

    test('Map with numeric keys should generate correct paths', () {
      final map = {
        '1': 'one',
        '2': {'2a': 'twoA', '2b': 'twoB'},
        '3': [3, 33, 333],
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        '1/',
        '2/',
        '2/2a/',
        '2/2b/',
        '3/',
        '3/i:0/',
        '3/i:1/',
        '3/i:2/',
      ]);
    });

    test('Map with boolean values should generate correct paths', () {
      final map = {
        'true': {'key1': false},
        'key2': true,
        'key3': {'key4': true},
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'true/',
        'true/key1/',
        'key2/',
        'key3/',
        'key3/key4/',
      ]);
    });

    test('Map with DateTime values should generate correct paths', () {
      final map = {
        'date1': DateTime.parse('2023-01-01'),
        'date2': {'date3': DateTime.parse('2023-12-31')},
      };

      final result = MapPathing.generatePathsFromMap(map: map);
      expect(result, [
        'date1/',
        'date2/',
        'date2/date3/',
      ]);
    });

  });

  group('generatePathsFromList', () {

    test('Empty list should return an empty list', () {
      final result = MapPathing.generatePathsFromList(list: []);
      expect(result, isEmpty);
    });

    test('List with a single value should generate a single path', () {
      final list = ['value1'];
      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, ['i:0/']);
    });

    test('List with nested lists should generate correct paths', () {
      final list = [
        ['item1', 'item2'],
        ['item3', 'item4'],
      ];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:0/i:0/',
        'i:0/i:1/',
        'i:1/',
        'i:1/i:0/',
        'i:1/i:1/',
      ]);
    });

    test('List with mixed data types should generate correct paths', () {
      final list = [
        'string',
        123,
        {'key': 'value'},
        ['nested', 'list'],
      ];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:1/',
        'i:2/',
        'i:2/key/',
        'i:3/',
        'i:3/i:0/',
        'i:3/i:1/',
      ]);
    });

    test('List with empty nested list should not affect paths', () {
      final list = [
        'item1',
        [],
        'item2',
      ];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:1/',
        'i:2/',
      ]);
    });

    test('Nested lists with null values should not affect paths', () {
      final list = [
        [null, 'value1'],
        'value2',
        null,
      ];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:0/i:0/',
        'i:0/i:1/',
        'i:1/',
        'i:2/',
      ]);
    });

    test('List with duplicate values should generate correct paths', () {
      final list = ['item1', 'item2', 'item1', 'item3'];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:1/',
        'i:2/',
        'i:3/',
      ]);
    });

    test('List with boolean values should generate correct paths', () {
      final list = [true, false, {'key': true}, [false, true]];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:1/',
        'i:2/',
        'i:2/key/',
        'i:3/',
        'i:3/i:0/',
        'i:3/i:1/',
      ]);
    });

    test('List with DateTime values should generate correct paths', () {
      final list = [
        DateTime.parse('2023-01-01'),
        {'date': DateTime.parse('2023-12-31')},
      ];

      final result = MapPathing.generatePathsFromList(list: list);
      expect(result, [
        'i:0/',
        'i:1/',
        'i:1/date/',
      ]);
    });

  });

  group('generateMapFromSomePaths', () {

    test('Empty paths list should return {}', () {
      final result = MapPathing.generateMapFromSomePaths(somePaths: [], sourceMap: {});
      expect(result, {});
    });

    test('Reconstruct map from a single path', () {
      final paths = [
        'key1/',
        'key1/key2/',
        'key1/key2/key3/',
      ];
      final sourceMap = {
        'key1': {
          'key2': {
            'key3': 'value',
          }
        }
      };

      final result = MapPathing.generateMapFromSomePaths(
        somePaths: paths,
        sourceMap: sourceMap,
      );

      expect(result, {
        'key1': {
          'key2': {
            'key3': 'value'
          }
        }
      });
    });

    test('Reconstruct map from multiple paths', () {
      final paths = ['a/b/c/', 'x/y/z/', 'key/'];
      final sourceMap = {'a': {'b': {'c': 'abc'}}, 'x': {'y': {'z': 'xyz'}}, 'key': 'value'};

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {
        'a': {'b': {'c': 'abc'}},
        'x': {'y': {'z': 'xyz'}},
        'key': 'value',
      });
    });

    test('Reconstruct map with mixed data types from paths', () {
      final paths = ['a/b/c/', 'x/y/z/', 'key/'];
      final sourceMap = {
        'a': {'b': {'c': 'abc'}},
        'x': {'y': {'z': 123}},
        'key': ['item1', 'item2'],
      };

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {
        'a': {'b': {'c': 'abc'}},
        'x': {'y': {'z': 123}},
        'key': ['item1', 'item2'],
      });
    });

    test('Reconstruct map with duplicate paths', () {
      final paths = ['a/b/c/', 'a/b/c/', 'key/'];
      final sourceMap = {'a': {'b': {'c': 'abc'}}, 'key': 'value'};

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {
        'a': {'b': {'c': 'abc'}},
        'key': 'value'
      }
      );
    });

    test('Reconstruct map with nested lists from paths', () {
      final paths = [
        'a/b/c/i:0/',
        'a/b/c/i:1/',
        'key/i:2/'
      ];
      final sourceMap = {
        'a': {
          'b': {
            'c': [10, 20]
          }
        },
        'key': [
          true,
          false,
          {'nested': 'list'},
        ]
      };

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {
        'a': {'b': {'c': [10, 20]}},
        'key': [
          null,
          null,
          {'nested': 'list'},
        ],
      });
    });

    test('Reconstruct map with boolean values from paths', () {
      final paths = ['key1/', 'key2/', 'key3/'];
      final sourceMap = {'key1': true, 'key2': {'nested': false}, 'key3': [true, false]};

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {'key1': true, 'key2': {'nested': false}, 'key3': [true, false]});
    });

    test('Reconstruct map with DateTime values from paths', () {
      final paths = ['date1/', 'date2/date3/'];
      final sourceMap = {
        'date1': DateTime.parse('2023-01-01'),
        'date2': {'date3': DateTime.parse('2023-12-31')},
      };

      final result = MapPathing.generateMapFromSomePaths(somePaths: paths, sourceMap: sourceMap);
      expect(result, {
        'date1': DateTime.parse('2023-01-01'),
        'date2': {'date3': DateTime.parse('2023-12-31')},
      });
    });

  });

  group('checkNodeIsLastKeyAmongBrothers', () {

    const Map<String, dynamic> _map = {
      'grand1': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'grand2': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'parent': {'son1': true, 'son2': true,},
    };

    test('checkNodeIsLastKeyAmongBrothers 1', () {

      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent1/son1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent1/son2/'), true);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent2/sonA'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent2/sonB'), true);

      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent1/son1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent1/son2/'), true);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent2/sonA'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent2/sonB'), true);

      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'parent/son1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'parent/son2/'), true);

    });

    test('checkNodeIsLastKeyAmongBrothers 2', () {
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/parent2/'), true);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/parent2/'), true);
    });

    test('checkNodeIsLastKeyAmongBrothers 3', () {
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand1/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'grand2/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'parent/'), true);
    });

    test('checkNodeIsLastKeyAmongBrothers 4', () {
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'x/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'r/e/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: 'r/e/tt/'), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: ''), false);
      expect(MapPathing.checkNodeIsLastKeyAmongBrothers(map: _map, path: null), false);
    });

  });

  group('checkMyParentIsLastKeyAmongUncles', () {

    const Map<String, dynamic> _map = {
      'grand1': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'grand2': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'parent': {'son1': true, 'son2': true,},
    };

    test('checkMyParentIsLastKeyAmongUncles 1', () {

      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent1/son1/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent1/son2/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent2/sonA'), true);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent2/sonB'), true);

      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent1/son1/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent1/son2/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent2/sonA'), true);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent2/sonB'), true);

      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'parent/son1/'), true);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'parent/son2/'), true);

    });

    test('checkMyParentIsLastKeyAmongUncles 2', () {
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent1/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/parent2/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent1/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/parent2/'), false);
    });

    test('checkMyParentIsLastKeyAmongUncles 3', () {
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand1/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'grand2/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'parent/'), false);
    });

    test('checkMyParentIsLastKeyAmongUncles 4', () {
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'x/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'r/e/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: 'r/e/tt/'), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: ''), false);
      expect(MapPathing.checkMyParentIsLastKeyAmongUncles(map: _map, path: null), false);
    });

  });

  group('checkMyGranpaIsLastKeyAmongGrandUncles', () {

    const Map<String, dynamic> _map = {
      'grand1': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'grand2': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'parent': {'son1': true, 'son2': true,},
    };

    test('checkMyGranpaIsLastKeyAmongGrandUncles 1', () {

      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent1/son1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent1/son2/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent2/sonA'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent2/sonB'), false);

      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent1/son1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent1/son2/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent2/sonA'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent2/sonB'), false);

      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'parent/son1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'parent/son2/'), false);

    });

    test('checkMyGranpaIsLastKeyAmongGrandUncles 2', () {
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/parent2/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/parent2/'), false);
    });

    test('checkMyGranpaIsLastKeyAmongGrandUncles 3', () {
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand1/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'grand2/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'parent/'), false);
    });

    test('checkMyGranpaIsLastKeyAmongGrandUncles 4', () {
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'x/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'r/e/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: 'r/e/tt/'), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: ''), false);
      expect(MapPathing.checkMyGranpaIsLastKeyAmongGrandUncles(map: _map, path: null), false);
    });

  });

  group('getNodeOrderIndexByPath', () {

    const Map<String, dynamic> _map = {
      'grand1': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'grand2': {
        'parent1': {'son1': true, 'son2': true,},
        'parent2': {'sonA': true, 'sonB': true,},
      },
      'parent': {'son1': true, 'son2': true,},
    };

    test('getNodeOrderIndexByPath 1', () {

      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent1/son1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent1/son2/'), 1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent2/sonA'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent2/sonB'), 1);

      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent1/son1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent1/son2/'), 1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent2/sonA'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent2/sonB'), 1);

      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'parent/son1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'parent/son2/'), 1);

    });

    test('getNodeOrderIndexByPath 2', () {
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/parent2/'), 1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/parent2/'), 1);
    });

    test('getNodeOrderIndexByPath 3', () {
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand1/'), 0);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'grand2/'), 1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'parent/'), 2);
    });

    test('getNodeOrderIndexByPath 4', () {
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'x/'), -1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'r/e/'), -1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: 'r/e/tt/'), -1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: ''), -1);
      expect(MapPathing.getNodeOrderIndexByPath(map: _map, path: null), -1);
    });

  });

}
