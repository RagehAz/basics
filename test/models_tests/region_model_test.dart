import 'package:basics/models/region_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// toMap / decipherRegion

  // --------------------
  group('Region.toMap / Region.decipherRegion', () {

    test('toMap produces a map with continent, name and countriesIDs', () {
      const region = Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy', 'lby']);
      final map = region.toMap();
      expect(map, {
        'continent': 'Africa',
        'name': 'Northern Africa',
        'countriesIDs': ['egy', 'lby'],
      });
    });

    test('decipherRegion rebuilds an equivalent Region from a map', () {
      final map = {
        'continent': 'Africa',
        'name': 'Northern Africa',
        'countriesIDs': ['egy', 'lby'],
      };
      final region = Region.decipherRegion(map);
      expect(region.continent, 'Africa');
      expect(region.name, 'Northern Africa');
      expect(region.countriesIDs, ['egy', 'lby']);
    });

    test('toMap then decipherRegion round-trips to an equivalent Region', () {
      const region = Region(continent: 'Asia', name: 'Southeast Asia', countriesIDs: ['idn', 'phl', 'vnm']);
      final roundTripped = Region.decipherRegion(region.toMap());
      expect(roundTripped.continent, region.continent);
      expect(roundTripped.name, region.name);
      expect(roundTripped.countriesIDs, region.countriesIDs);
    });

  });
  // -----------------------------------------------------------------------------

  /// cipherRegions / decipherRegions

  // --------------------
  group('Region.cipherRegions / Region.decipherRegions', () {

    test('cipherRegions keys the map by region name', () {
      const regions = [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
        Region(continent: 'Africa', name: 'Western Africa', countriesIDs: ['nga', 'gha']),
      ];
      final map = Region.cipherRegions(regions);
      expect(map.keys, containsAll(['Northern Africa', 'Western Africa']));
      expect(map['Northern Africa']['countriesIDs'], ['egy']);
    });

    test('cipherRegions returns an empty map for an empty list', () {
      final map = Region.cipherRegions(<Region>[]);
      expect(map, <String, dynamic>{});
    });

    test('Last region wins when two regions share the same name', () {
      const regions = [
        Region(continent: 'Africa', name: 'Same Name', countriesIDs: ['a']),
        Region(continent: 'Africa', name: 'Same Name', countriesIDs: ['b']),
      ];
      final map = Region.cipherRegions(regions);
      expect(map.length, 1);
      expect(map['Same Name']['countriesIDs'], ['b']);
    });

    test('cipherRegions then decipherRegions round-trips to equivalent Regions', () {
      const regions = [
        Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
        Region(continent: 'Africa', name: 'Western Africa', countriesIDs: ['nga', 'gha']),
      ];
      final roundTripped = Region.decipherRegions(Region.cipherRegions(regions));
      expect(roundTripped.length, 2);
      final byName = {for (final r in roundTripped) r.name: r};
      expect(byName['Northern Africa']!.countriesIDs, ['egy']);
      expect(byName['Western Africa']!.countriesIDs, ['nga', 'gha']);
    });

    test('decipherRegions returns an empty list for an empty map', () {
      final result = Region.decipherRegions(<String, dynamic>{});
      expect(result, <Region>[]);
    });

  });
  // -----------------------------------------------------------------------------

  /// regionsIncludeRegion

  // --------------------
  group('Region.regionsIncludeRegion', () {

    const regions = [
      Region(continent: 'Africa', name: 'Northern Africa', countriesIDs: ['egy']),
      Region(continent: 'Africa', name: 'Western Africa', countriesIDs: ['nga']),
    ];

    test('Returns true when a region with the given name exists', () {
      expect(Region.regionsIncludeRegion(regions: regions, name: 'Western Africa'), true);
    });

    test('Returns false when no region has the given name', () {
      expect(Region.regionsIncludeRegion(regions: regions, name: 'Nonexistent'), false);
    });

    test('Returns false for an empty regions list', () {
      expect(Region.regionsIncludeRegion(regions: const <Region>[], name: 'Western Africa'), false);
    });

  });
}
