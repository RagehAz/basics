import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/phrase_model.dart';

/// => TAMAM
class America {
  // ---------------------------------------------------------------------------

  const America();

  // --------------------
  /// us_ca+cupertino - us_ca
  // --------------------
  static const useISO2 = false;
  // --------------------
  static const Map<String, String> statesNamesMap = {
    'us_al': 'Alabama',
    'us_ak': 'Alaska',
    'us_az': 'Arizona',
    'us_ar': 'Arkansas',
    'us_ca': 'California',
    'us_co': 'Colorado',
    'us_ct': 'Connecticut',
    'us_de': 'Delaware',
    'us_dc': 'District of Columbia',
    'us_fl': 'Florida',
    'us_ga': 'Georgia',
    'us_hi': 'Hawaii',
    'us_id': 'Idaho',
    'us_il': 'Illinois',
    'us_in': 'Indiana',
    'us_ia': 'Iowa',
    'us_ks': 'Kansas',
    'us_ky': 'Kentucky',
    'us_la': 'Louisiana',
    'us_me': 'Maine',
    'us_md': 'Maryland',
    'us_ma': 'Massachusetts',
    'us_mi': 'Michigan',
    'us_mn': 'Minnesota',
    'us_ms': 'Mississippi',
    'us_mo': 'Missouri',
    'us_mt': 'Montana',
    'us_ne': 'Nebraska',
    'us_nv': 'Nevada',
    'us_nh': 'New Hampshire',
    'us_nj': 'New Jersey',
    'us_nm': 'New Mexico',
    'us_ny': 'New York',
    'us_nc': 'North Carolina',
    'us_nd': 'North Dakota',
    'us_oh': 'Ohio',
    'us_ok': 'Oklahoma',
    'us_or': 'Oregon',
    'us_pa': 'Pennsylvania',
    'us_ri': 'Rhode Island',
    'us_sc': 'South Carolina',
    'us_sd': 'South Dakota',
    'us_tn': 'Tennessee',
    'us_tx': 'Texas',
    'us_ut': 'Utah',
    'us_vt': 'Vermont',
    'us_va': 'Virginia',
    'us_wa': 'Washington',
    'us_wv': 'West Virginia',
    'us_wi': 'Wisconsin',
    'us_wy': 'Wyoming',
  };
  // --------------------
  static const List<String> statesNames = <String>[
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'District of Columbia',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
  ];
  // --------------------
  static const Map<String, String> statesNamesMapWidthISO2 = {
    'us_al': 'AL. Alabama',
    'us_ak': 'AK. Alaska',
    'us_az': 'AZ. Arizona',
    'us_ar': 'AR. Arkansas',
    'us_ca': 'CA. California',
    'us_co': 'CO. Colorado',
    'us_ct': 'CT. Connecticut',
    'us_de': 'DE. Delaware',
    'us_dc': 'DC. District of Columbia',
    'us_fl': 'FL. Florida',
    'us_ga': 'GA. Georgia',
    'us_hi': 'HI. Hawaii',
    'us_id': 'ID. Idaho',
    'us_il': 'IL. Illinois',
    'us_in': 'IN. Indiana',
    'us_ia': 'IA. Iowa',
    'us_ks': 'KS. Kansas',
    'us_ky': 'KY. Kentucky',
    'us_la': 'LA. Louisiana',
    'us_me': 'ME. Maine',
    'us_md': 'MD. Maryland',
    'us_ma': 'MA. Massachusetts',
    'us_mi': 'MI. Michigan',
    'us_mn': 'MN. Minnesota',
    'us_ms': 'MS. Mississippi',
    'us_mo': 'MO. Missouri',
    'us_mt': 'MT. Montana',
    'us_ne': 'NE. Nebraska',
    'us_nv': 'NV. Nevada',
    'us_nh': 'NH. New Hampshire',
    'us_nj': 'NJ. New Jersey',
    'us_nm': 'NM. New Mexico',
    'us_ny': 'NY. New York',
    'us_nc': 'NC. North Carolina',
    'us_nd': 'ND. North Dakota',
    'us_oh': 'OH. Ohio',
    'us_ok': 'OK. Oklahoma',
    'us_or': 'OR. Oregon',
    'us_pa': 'PA. Pennsylvania',
    'us_ri': 'RI. Rhode Island',
    'us_sc': 'SC. South Carolina',
    'us_sd': 'SD. South Dakota',
    'us_tn': 'TN. Tennessee',
    'us_tx': 'TX. Texas',
    'us_ut': 'UT. Utah',
    'us_vt': 'VT. Vermont',
    'us_va': 'VA. Virginia',
    'us_wa': 'WA. Washington',
    'us_wv': 'WV. West Virginia',
    'us_wi': 'WI. Wisconsin',
    'us_wy': 'WY. Wyoming',
  };
  // --------------------
  static const List<String> statesNamesWithISO2 = <String>[
    'AL. Alabama',
    'AK. Alaska',
    'AZ. Arizona',
    'AR. Arkansas',
    'CA. California',
    'CO. Colorado',
    'CT. Connecticut',
    'DE. Delaware',
    'DC. District of Columbia',
    'FL. Florida',
    'GA. Georgia',
    'HI. Hawaii',
    'ID. Idaho',
    'IL. Illinois',
    'IN. Indiana',
    'IA. Iowa',
    'KS. Kansas',
    'KY. Kentucky',
    'LA. Louisiana',
    'ME. Maine',
    'MD. Maryland',
    'MA. Massachusetts',
    'MI. Michigan',
    'MN. Minnesota',
    'MS. Mississippi',
    'MO. Missouri',
    'MT. Montana',
    'NE. Nebraska',
    'NV. Nevada',
    'NH. New Hampshire',
    'NJ. New Jersey',
    'NM. New Mexico',
    'NY. New York',
    'NC. North Carolina',
    'ND. North Dakota',
    'OH. Ohio',
    'OK. Oklahoma',
    'OR. Oregon',
    'PA. Pennsylvania',
    'RI. Rhode Island',
    'SC. South Carolina',
    'SD. South Dakota',
    'TN. Tennessee',
    'TX. Texas',
    'UT. Utah',
    'VT. Vermont',
    'VA. Virginia',
    'WA. Washington',
    'WV. West Virginia',
    'WI. Wisconsin',
    'WY. Wyoming',
  ];
  // --------------------
  static const List<String> statesISO2 = <String>[
    'al',
    'ak',
    'az',
    'ar',
    'ca',
    'co',
    'ct',
    'de',
    'dc',
    'fl',
    'ga',
    'hi',
    'id',
    'il',
    'in',
    'ia',
    'ks',
    'ky',
    'la',
    'me',
    'md',
    'ma',
    'mi',
    'mn',
    'ms',
    'mo',
    'mt',
    'ne',
    'nv',
    'nh',
    'nj',
    'nm',
    'ny',
    'nc',
    'nd',
    'oh',
    'ok',
    'or',
    'pa',
    'ri',
    'sc',
    'sd',
    'tn',
    'tx',
    'ut',
    'vt',
    'va',
    'wa',
    'wv',
    'wi',
    'wy',
  ];
  // --------------------
  static const Map<String, dynamic> statePhoneCodes = {
    'us_al': '+1334',
    'us_ak': '+1907',
    'us_az': '+1602',
    'us_ar': '+1501',
    'us_ca': '+1916',
    'us_co': '+1303',
    'us_ct': '+1860',
    'us_de': '+1302',
    'us_dc': '+1202',
    'us_fl': '+1850',
    'us_ga': '+1404',
    'us_hi': '+1808',
    'us_id': '+1208',
    'us_il': '+1417',
    'us_in': '+1317',
    'us_ia': '+1515',
    'us_ks': '+1785',
    'us_ky': '+1502',
    'us_la': '+1225',
    'us_me': '+1207',
    'us_md': '+1410',
    'us_ma': '+1617',
    'us_mi': '+1517',
    'us_mn': '+1651',
    'us_ms': '+1601',
    'us_mo': '+1573',
    'us_mt': '+1406',
    'us_ne': '+1402',
    'us_nv': '+1775',
    'us_nh': '+1603',
    'us_nj': '+1609',
    'us_nm': '+1505',
    'us_ny': '+1518',
    'us_nc': '+1919',
    'us_nd': '+1701',
    'us_oh': '+1614',
    'us_ok': '+1405',
    'us_or': '+1503',
    'us_pa': '+1717',
    'us_ri': '+1401',
    'us_sc': '+1803',
    'us_sd': '+1605',
    'us_tn': '+1615',
    'us_tx': '+1512',
    'us_ut': '+1385',
    'us_vt': '+1802',
    'us_va': '+1604',
    'us_wa': '+1360',
    'us_wv': '+1843',
    'us_wi': '+1608',
    'us_wy': '+1307',
  };
  // ---------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStatesIDs(){
    return statesNamesMap.keys.toList();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getStateName({
    required String stateID,
    required bool withISO2,
  }){

    if (withISO2 == true){
      return statesNamesMapWidthISO2[stateID];
    }
    else {
      return statesNamesMap[stateID];
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getStateIDByName({
    required String stateName,
  }){
    String? _output;

    List<String> _keys = MapperSS.getKeysHavingThisValue(
        map: statesNamesMap,
        value: stateName
    );

    if (Lister.checkCanLoop(_keys) == false){
      _keys = MapperSS.getKeysHavingThisValue(
          map: statesNamesMapWidthISO2,
          value: stateName
      );
    }

    if (Lister.checkCanLoop(_keys) == true){
      _output = _keys.first;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStatesNames({
    required List<String> statesIDs,
    required bool withISO2,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(statesIDs) == true){

      for (final String stateID in statesIDs){
        final String? _stateName = getStateName(
          stateID: stateID,
          withISO2: withISO2,
        );
        if (_stateName != null){
          _output.add(_stateName);
        }
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStatesIDsByNames({
    required List<String> statesNames,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(statesNames) == true){

      for (final String stateName in statesNames){

        final String? stateID = getStateIDByName(
            stateName: stateName
        );

        if (stateID != null){
          _output.add(stateID);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStatesIDsFromCountriesIDs({
    required List<String>? countriesIDs,
  }){
    final List<String> _statesIDs = [];

    if (Lister.checkCanLoop(countriesIDs) == true){

      for (final String countryID in countriesIDs!){

        final bool _isStateID = checkCountryIDIsStateID(countryID);

        if (_isStateID == true){
          _statesIDs.add(countryID);
        }

      }

    }

    return sortStatesIDsByName(statesIDs: _statesIDs);
  }
  // ---------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> sortStatesIDsByName({
    required List<String> statesIDs,
  }){
    List<String> _output = <String>[];

    if (Lister.checkCanLoop(statesIDs) == true){

      List<String> _statesNames = getStatesNames(
        statesIDs: statesIDs,
        withISO2: false,
      );

      _statesNames = Stringer.sortAlphabetically(_statesNames);

      _output = getStatesIDsByNames(
        statesNames: _statesNames,
      );

    }

    return _output;
  }
  // ---------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchStatesByName({
    required String? text,
    required bool withISO2,
  }){
    List<Phrase> _output = <Phrase>[];

    if (TextCheck.isEmpty(text) == false){

      final List<String> _names = TextCheck.getStringsContainingThis(
          strings: America.statesNames,
          subString: text
      );

      final List<String> _ids = getStatesIDsByNames(
          statesNames: _names
      );

      _output = createStatesPhrases(
        statesIDs: _ids,
        withISO2: withISO2,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchStatesByISO2({
    required String? text,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (TextCheck.isEmpty(text) == false && text?.length == 2){

      final String _stateID = 'us_$text';

      final String? _pairValue = statesNamesMap[_stateID];
      if (_pairValue != null){
        final Phrase _phrase = Phrase(
          id: _stateID,
          value: _pairValue,
          langCode: 'en',
          // trigram: [],
        );
        _output.add(_phrase);
      }

    }

    return _output;
  }
  // ---------------------------------------------------------------------------

  /// PHRASE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Phrase? createStatePhrase({
    required String? stateID,
    required bool withISO2,
  }){
    Phrase? _output;

    if (TextCheck.isEmpty(stateID) == false){

      final String? _value = getStateName(
        stateID: stateID!,
        withISO2: withISO2,
      );

      if (_value != null){
        _output = Phrase(
          id: stateID,
          value:_value ,
          langCode: 'en',
          // trigram: [],
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> createStatesPhrases({
    required List<String> statesIDs,
    required bool withISO2,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(statesIDs) == true){

      for (final String stateID in statesIDs){

        final Phrase? _phrase = createStatePhrase(
          stateID: stateID,
          withISO2: withISO2,
        )!;

        if (_phrase != null){
          _output.add(_phrase);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> createAllStatesPhrases(){
    return createStatesPhrases(
      statesIDs: getStatesIDs(),
      withISO2: useISO2,
    );
  }
  // ---------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> addUSAIDToCountriesIDsIfContainsAStateID({
    required List<String> countriesIDs,
  }){
    final List<String> _output = [...countriesIDs];

    if (Lister.checkCanLoop(countriesIDs) == true){

      final bool _hasAStateID = checkCountriesIDsIncludeAStateID(
        countriesIDs: countriesIDs,
      );

      if (_hasAStateID == true){
        _output.add('usa');
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> removeStatesPhrases({
    required List<Phrase> removeFrom,
  }){
    final List<Phrase> _output = [];

    if (Lister.checkCanLoop(removeFrom) == true){

      for (final Phrase phrase in removeFrom){

        final bool _isState = checkCountryIDIsStateID(phrase.id);

        if (_isState == false){
          _output.add(phrase);
        }

      }

    }

    return _output;
  }
  // ---------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCountryIDIsStateID(String? countryID){
    bool _isState = false;

    if (countryID != null){

      final String? us = TextMod.removeTextAfterFirstSpecialCharacter(
        text: countryID,
        specialCharacter: '_',
      );

      if (countryID != 'usa' && us == 'us'){
        _isState = true;
      }

    }

    return _isState;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCountriesIDsIncludeAStateID({
    required List<String> countriesIDs,
  }){
    bool _output = false;

    if (Lister.checkCanLoop(countriesIDs) == true){

      for (final String countryID in countriesIDs){

        final bool _isStateID = checkCountryIDIsStateID(countryID);

        if (_isStateID == true){
          _output = true;
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool searchTextIsExactlyUSA(String? searchText){
    bool _output = false;
    if (searchText == 'usa' || searchText == 'USA'){
      _output = true;
    }
    return _output;
  }
// ---------------------------------------------------------------------------
}
