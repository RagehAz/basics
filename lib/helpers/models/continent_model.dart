import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/region_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
class Continent {
  /// --------------------------------------------------------------------------
  const Continent({
    required this.name,
    required this.regions,
  });

  /// --------------------------------------------------------------------------
  final String name;
  final List<Region> regions;

  // -----------------------------------------------------------------------------
  static const continentsMapID = 'continents';
  static const String continentsFilePath = 'packages/bldrs_theme/lib/assets/planet/continents.json';

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'regions': Region.cipherRegions(regions),
    };
  }

  // --------------------
  static Continent decipherContinent(Map<String, dynamic> map) {
    return Continent(
      name: map['name'],
      regions: Region.decipherRegions(map['regions']),
    );
  }

  // --------------------
  static Map<String, dynamic> cipherContinents(List<Continent> continents) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Lister.checkCanLoop(continents)) {
      for (final Continent continent in continents) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: continent.name,
          value: continent.toMap(),
          overrideExisting: true,
        );
      }

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: continentsMapID,
        overrideExisting: true,
      );
    }

    return _map;
  }

  // --------------------
  static List<Continent> decipherContinents(Map<String, dynamic>? map) {
    final List<Continent> _continents = <Continent>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys)) {
        for (final String key in _keys) {
          if (map[key] != continentsMapID) {
            final Continent _continent = decipherContinent(map[key]);
            _continents.add(_continent);
          }
        }
      }
    }

    return _continents;
  }

  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkContinentsIncludeContinent({
    required List<Continent> continents,
    required String name,
  }) {
    bool _includes = false;

    for (final Continent continent in continents) {
      if (continent.name == name) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }

  // --------------------
  static bool checkIconIsContinent(String? icon) {
    bool _iconIsContinent;

    if (icon == Iconz.contAfrica ||
        icon == Iconz.contAsia ||
        icon == Iconz.contSouthAmerica ||
        icon == Iconz.contNorthAmerica ||
        icon == Iconz.contEurope ||
        icon == Iconz.contAustralia ||
        icon == Iconz.planet) {
      _iconIsContinent = true;
    } else {
      _iconIsContinent = false;
    }

    return _iconIsContinent;
  }

  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static Continent? getContinentFromContinents({
    required List<Continent>? continents,
    required String? name,
  }) {
    final Continent? cont =
        continents?.firstWhereOrNull((Continent continent) => continent.name == name);

    return cont;
  }

  // --------------------
  static Continent? getContinentFromContinentsByCountryID({
    required List<Continent>? continents,
    required String? countryID,
  }) {
    Continent? _cont;

    if (Lister.checkCanLoop(continents) == true && countryID != null) {
      for (final Continent continent in continents!) {
        for (final Region region in continent.regions) {
          for (final String id in region.countriesIDs) {
            if (id == countryID) {
              _cont = continent;
              break;
            }

            if (_cont != null) {
              break;
            }
          }

          if (_cont != null) {
            break;
          }
        }

        if (_cont != null) {
          break;
        }
      }
    }

    return _cont;
  }

  // --------------------
  static String? getContinentIcon(Continent? continent) {
    final String? _name = continent?.name;

    switch (_name) {
      case 'Africa':
        return Iconz.contAfrica;
      case 'Asia':
        return Iconz.contAsia;
      case 'Oceania':
        return Iconz.contAustralia;
      case 'Europe':
        return Iconz.contEurope;
      case 'North America':
        return Iconz.contNorthAmerica;
      case 'South America':
        return Iconz.contSouthAmerica;
      default:
        return Iconz.planet;
    }
  }

  // --------------------
  static List<String> getCountriesIDsOfContinent(Continent continent) {
    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions) {
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }

  // -----------------------------------------------------------------------------

  /// LISTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<Map<String, dynamic>> continentsMaps = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Africa',
      'icon': Iconz.contAfrica,
    },
    <String, dynamic>{
      'name': 'Asia',
      'icon': Iconz.contAsia,
    },
    <String, dynamic>{
      'name': 'Oceania',
      'icon': Iconz.contAustralia,
    },
    <String, dynamic>{
      'name': 'Europe',
      'icon': Iconz.contEurope,
    },
    <String, dynamic>{
      'name': 'North America',
      'icon': Iconz.contNorthAmerica,
    },
    <String, dynamic>{
      'name': 'South America',
      'icon': Iconz.contSouthAmerica,
    },
  ];

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getContinentIconByID(String? id) {
    String? _output;

    if (id != null) {
      final Map<String, dynamic>? _map =
          continentsMaps.singleWhereOrNull((Map<String, dynamic> map) => map['name'] == id);

      if (_map != null) {
        _output = _map['icon'];
      }
    }

    return _output;
  }

  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogContinent({
    String invoker = '',
  }) {
    blog('CONTINENT : name : $name : regions : $regions');
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogContinents(List<Continent> continents) {
    if (Lister.checkCanLoop(continents) == true) {
      for (final Continent cont in continents) {
        cont.blogContinent();
      }
    }
  }
// -----------------------------------------------------------------------------
}
