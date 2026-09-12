import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


@immutable
class Region {
  /// --------------------------------------------------------------------------
  const Region({
    required this.continent,
    required this.name,
    required this.countriesIDs,
  });
  /// --------------------------------------------------------------------------
  final String continent;
  final String name;
  final List<String> countriesIDs;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'continent': continent,
      'name': name,
      'countriesIDs': countriesIDs,
    };
  }
  // --------------------
  static Region decipherRegion(Map<String, dynamic> map) {
    return Region(
      name: map['name'],
      continent: map['continent'],
      countriesIDs: Stringer.getStringsFromDynamics(map['countriesIDs']),
    );
  }
  // --------------------
  static Map<String, dynamic> cipherRegions(List<Region> regions) {
    final Map<String, dynamic> _map = <String, dynamic>{};

    /// direct assignment instead of insertPairInMap per entry -- that
    /// copies the whole accumulator map on every call, O(n^2).
    if (Lister.checkCanLoop(regions)) {
      for (final Region region in regions) {
        _map[region.name] = region.toMap();
      }
    }

    return _map;
  }
  // --------------------
  static List<Region> decipherRegions(Map<String, dynamic> map) {
    final List<Region> _regions = <Region>[];

    final List<String> _keys = map.keys.toList();

    if (Lister.checkCanLoop(_keys)) {
      for (final String key in _keys) {
        _regions.add(decipherRegion(map[key]));
      }
    }

    return _regions;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool regionsIncludeRegion({
    required List<Region> regions,
    required String name,
  }) {
    bool _includes = false;

    for (final Region region in regions) {
      if (region.name == name) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }
  // -----------------------------------------------------------------------------
}
