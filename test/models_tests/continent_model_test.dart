import 'package:basics/models/continent_model.dart';
import 'package:basics/models/region_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// toMap / decipherContinent

  // --------------------
  group('Continent.toMap / Continent.decipherContinent', () {

    const continent = Continent(
      name: 'Africa',
      regions: [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
      ],
    );

    test('toMap produces a map with name and ciphered regions', () {
      final map = continent.toMap();
      expect(map['name'], 'Africa');
      expect(map['regions'], isA<Map<String, dynamic>>());
      expect((map['regions'] as Map)['Northern Africa']['countriesIDs'], ['egy']);
    });

    test('decipherContinent rebuilds an equivalent Continent from a map', () {
      final rebuilt = Continent.decipherContinent(continent.toMap());
      expect(rebuilt.name, 'Africa');
      expect(rebuilt.regions.length, 1);
      expect(rebuilt.regions.first.name, 'Northern Africa');
      expect(rebuilt.regions.first.countriesIDs, ['egy']);
    });

  });
  // -----------------------------------------------------------------------------

  /// cipherContinents / decipherContinents

  // --------------------
  group('Continent.cipherContinents / Continent.decipherContinents', () {

    const continents = [
      Continent(name: 'Africa', regions: [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
      ]),
      Continent(name: 'Asia', regions: [
        Region(continent: 'Asia', name: 'Southeast Asia', countriesIDs: ['idn']),
      ]),
    ];

    test('cipherContinents keys the map by continent name and adds an id entry', () {
      final map = Continent.cipherContinents(continents);
      expect(map.keys, containsAll(['Africa', 'Asia', 'id']));
      expect(map['id'], Continent.continentsMapID);
    });

    test('cipherContinents returns an empty map for an empty list', () {
      final map = Continent.cipherContinents(<Continent>[]);
      expect(map, <String, dynamic>{});
    });

    test('Last continent wins when two continents share the same name', () {
      const dup = [
        Continent(name: 'Same', regions: []),
        Continent(name: 'Same', regions: [
          Region(continent: 'Same', name: 'R', countriesIDs: ['x']),
        ]),
      ];
      final map = Continent.cipherContinents(dup);
      expect((map['Same'] as Map)['regions'], isNotEmpty);
    });

    test('cipherContinents then decipherContinents round-trips (excluding the id marker entry)', () {
      final roundTripped = Continent.decipherContinents(Continent.cipherContinents(continents));
      expect(roundTripped.length, 2);
      final byName = {for (final c in roundTripped) c.name: c};
      expect(byName['Africa']!.regions.first.name, 'Northern Africa');
      expect(byName['Asia']!.regions.first.countriesIDs, ['idn']);
    });

    test('decipherContinents returns an empty list for a null map', () {
      expect(Continent.decipherContinents(null), <Continent>[]);
    });

  });
  // -----------------------------------------------------------------------------

  /// checkContinentsIncludeContinent

  // --------------------
  group('Continent.checkContinentsIncludeContinent', () {

    const continents = [
      Continent(name: 'Africa', regions: []),
      Continent(name: 'Asia', regions: []),
    ];

    test('Returns true when a continent with the given name exists', () {
      expect(Continent.checkContinentsIncludeContinent(continents: continents, name: 'Asia'), true);
    });

    test('Returns false when no continent has the given name', () {
      expect(Continent.checkContinentsIncludeContinent(continents: continents, name: 'Nonexistent'), false);
    });

  });
  // -----------------------------------------------------------------------------

  /// getContinentFromContinents / getContinentFromContinentsByCountryID

  // --------------------
  group('Continent lookups', () {

    const continents = [
      Continent(name: 'Africa', regions: [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
      ]),
      Continent(name: 'Asia', regions: [
        Region(continent: 'Asia', name: 'Southeast Asia', countriesIDs: ['idn']),
      ]),
    ];

    test('getContinentFromContinents finds a continent by name', () {
      final result = Continent.getContinentFromContinents(continents: continents, name: 'Asia');
      expect(result?.name, 'Asia');
    });

    test('getContinentFromContinents returns null for an unknown name', () {
      final result = Continent.getContinentFromContinents(continents: continents, name: 'Nonexistent');
      expect(result, isNull);
    });

    test('getContinentFromContinentsByCountryID finds the continent containing a country', () {
      final result = Continent.getContinentFromContinentsByCountryID(continents: continents, countryID: 'idn');
      expect(result?.name, 'Asia');
    });

    test('getContinentFromContinentsByCountryID returns null when the country is not found', () {
      final result = Continent.getContinentFromContinentsByCountryID(continents: continents, countryID: 'zzz');
      expect(result, isNull);
    });

    test('getCountriesIDsOfContinent flattens all region country ids', () {
      const continent = Continent(name: 'Africa', regions: [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy', 'lby']),
        Region(continent: 'Africa', name: 'Western Africa', countriesIDs: ['nga']),
      ]);
      expect(Continent.getCountriesIDsOfContinent(continent), ['egy', 'lby', 'nga']);
    });

  });
  // -----------------------------------------------------------------------------

  /// getContinentIconByID

  // --------------------
  group('Continent.getContinentIconByID', () {

    test('Returns the icon for a known continent name', () {
      final icon = Continent.getContinentIconByID('Africa');
      expect(icon, isNotNull);
    });

    test('Returns null for an unknown continent name', () {
      expect(Continent.getContinentIconByID('Nonexistent'), isNull);
    });

    test('Returns null when id is null', () {
      expect(Continent.getContinentIconByID(null), isNull);
    });

  });
}
