import 'package:basics/bldrs_theme/assets/planet/all_flags_list.dart';
import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// => TAMAM
@immutable
class Flag {
  // --------------------------------------------------------------------------
  /// THIS CLASS IS USED TO STORE CONSTANT COUNTRY DATA
  // --------------------------------------------------------------------------
  const Flag({
    required this.id,
    required this.iso2,
    required this.icon,
    required this.region,
    required this.continent,
    required this.language,
    required this.currencyID,
    required this.phoneCode,
    required this.capital,
    required this.langCodes,
    required this.areaSqKm,
    required this.population,
    required this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String iso2;
  final String icon;
  final String region;
  final String continent;
  final String language;
  final String currencyID;
  final String phoneCode;
  final String capital;
  final String langCodes;
  final int? population;
  final int areaSqKm;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------
  static const String planetID = 'planet';
  static const String allCitiesID = 'allCities';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  Flag copyWith({
    String? id,
    String? iso2,
    String? icon,
    String? region,
    String? continent,
    String? language,
    String? currencyID,
    String? phoneCode,
    String? capital,
    String? langCodes,
    int? areaSqKm,
    int? population,
    List<Phrase>? phrases,
  }){
    return Flag(
      id: id ?? this.id,
      iso2: iso2 ?? this.iso2,
      icon: icon ?? this.icon,
      region: region ?? this.region,
      continent: continent ?? this.continent,
      language: language ?? this.language,
      currencyID: currencyID ?? this.currencyID,
      phoneCode: phoneCode ?? this.phoneCode,
      capital: capital ?? this.capital,
      langCodes: langCodes ?? this.langCodes,
      areaSqKm: areaSqKm ?? this.areaSqKm,
      population: population ?? this.population,
      phrases: phrases ?? this.phrases,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'iso2': iso2,
      'flag': icon,
      'region': region,
      'continent': continent,
      'language': language,
      'currencyID': currencyID,
      'phoneCode': phoneCode,
      'capital': capital,
      'langCodes': langCodes,
      'areaSqKm': areaSqKm,
      'population': population,
      'phrases': Phrase.cipherPhrasesToLangsMap(phrases),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherFlags(List<Flag> flags){
    final List<Map<String, dynamic>> _maps = [];

    if (Lister.checkCanLoop(flags) == true){
      for (final Flag flag in flags){
        _maps.add(flag.toMap());
      }
    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Flag? decipher(Map<String, dynamic>? map){
    Flag? _output;

    if (map != null){
      _output = Flag(
        id: map['id'],
        iso2: map['iso2'],
        icon: map['flag'],
        region: map['region'],
        continent: map['continent'],
        language: map['language'],
        currencyID: map['currencyID'],
        phoneCode: map['phoneCode'],
        capital: map['capital'],
        langCodes: map['langCodes'],
        areaSqKm: map['areaSqKm'],
        population: map['population'],
        phrases: Phrase.decipherPhrasesLangsMap(
          phid: map['id'],
          langsMap: map['phrases'],
        ),
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Flag> decipherMaps(List<dynamic> maps){
    final List<Flag> _output = [];

    if (Lister.checkCanLoop(maps) == true){
      for (final dynamic map in maps){
        _output.add(decipher(map)!);
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FLAG GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Flag? getFlagFromFlagsByCountryID({
    required List<Flag>? flags,
    required String? countryID,
  }){
    Flag? _output;

    if (TextCheck.isEmpty(countryID) == false){
      if (Lister.checkCanLoop(flags) == true){
        for (final Flag flag in flags!){
          if (flag.id == countryID){
            _output = flag;
            break;
          }
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Flag? getFlagFromFlagsByISO2({
    required List<Flag>? flags,
    required String? iso2,
  }){
    Flag? _output;

    if (TextCheck.isEmpty(iso2) == false){
      if (Lister.checkCanLoop(flags) == true){
        for (final Flag flag in flags!){
          if (flag.iso2 == iso2){
            _output = flag;
            break;
          }
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ID GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getCountryIDByISO2(String? iso2){
    String? _output;

    if (iso2 != null) {

      if (iso2.length == 2){
        
        final Flag? _flag = getFlagFromFlagsByISO2(
          flags: allFlags,
          iso2: iso2,
        );
  
        _output = _flag?.id;
        
      }
      
      else if (iso2.length == 3){
        _output = iso2;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllCountriesIDs() {
    final List<String> _ids = <String>[];
    for (final Flag flag in allFlags) {
      _ids.add(flag.id);
    }
    return _ids;
  }
  // --------------------
  // -----------------------------------------------------------------------------

  /// ICON GETTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getCountryIcon(String? countryID) {
    String? _output = Iconz.planet;

    if (countryID != null && countryID != planetID){

      /// EURO
      if (countryID == 'euz'){
        _output = Iconz.getFlagByFileName('flag_eu_euro.svg');
      }

      else {

        String _countryID = countryID;

        /// STATES
        if (TextCheck.stringStartsExactlyWith(text: _countryID, startsWith: 'us_') == true){
          _countryID = 'usa';
        }

        /// GET FLAG
        final Flag? _flag = getFlagFromFlagsByCountryID(
          flags: allFlags,
          countryID: _countryID,
        );

        _output = _flag?.icon;

      }


    }


    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getAmericaStateIcon(String? stateID){
    String? _output = usaFlag;

    if (stateID != null && stateID != 'usa') {

      final String? us = TextMod.removeTextAfterFirstSpecialCharacter(
        text: stateID,
        specialCharacter: '_',
      );

      if (us == 'us'){
        _output = '${WorldZoningPaths.flagsDirectory}/$stateID.svg';
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PHONE CODE GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getCountryPhoneCode(String? countryID){
    String? _output;

    if (countryID != null && countryID != planetID) {

      final Flag? _flag = getFlagFromFlagsByCountryID(
        flags: allFlags,
        countryID: countryID,
      );

      _output = _flag?.phoneCode;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PHONE CODE GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getCountryCurrencyID(String? countryID){
    Flag? _flag;


    if (countryID != null) {

      if (countryID == planetID){
        _flag = getFlagFromFlagsByCountryID(
          flags: allFlags,
          countryID: 'usa',
        );
      }
      else {
        _flag = getFlagFromFlagsByCountryID(
          flags: allFlags,
          countryID: countryID,
        );
      }


    }

    return _flag?.currencyID;
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> createAllCountriesPhrasesForLDB({
    required List<String> langCodes,
  }){
    final List<Phrase> _output = <Phrase>[];

    for (final Flag flag in allFlags){

      final List<Phrase> _phrasesOfGivenLangCodes = Phrase.searchPhrasesByLangs(
        phrases: flag.phrases,
        langCodes: langCodes,
      );

      final List<Phrase> _phrases = Phrase.addTrigramsToPhrases(
        phrases: _phrasesOfGivenLangCodes,
      );

      _output.addAll(_phrases);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogFlag(){

    blog(
      'Flag(\n'
          "id: '$id',\n"
          "iso2: '$iso2',\n"
          "icon: '$icon',\n"
          "region: '$region',\n"
          "continent: '$continent',\n"
          "language: '$language',\n"
          "currencyID: '$currencyID',\n"
          "phoneCode: '$phoneCode',\n"
          "capital: '$capital',\n"
          "langCodes: '$langCodes',\n"
          'areaSqKm: $areaSqKm,\n'
          'population: $population,\n'
          'phrases: <Phrase>[\n'
              "Phrase(langCode: 'de', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'de')?.value}', id: '$id'),\n"
              "Phrase(langCode: 'ar', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'ar')?.value}', id: '$id'),\n"
              "Phrase(langCode: 'en', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'en')?.value}', id: '$id'),\n"
              "Phrase(langCode: 'fr', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'fr')?.value}', id: '$id'),\n"
              "Phrase(langCode: 'es', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'es')?.value}', id: '$id'),\n"
              "Phrase(langCode: 'zh', value: '${Phrase.searchPhraseByIDAndLangCode(phrases: phrases, phid: id, langCode: 'zh')?.value}', id: '$id'),\n"
          '],\n'
        '),\n',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFlags(List<Flag> flags){
    if (Lister.checkCanLoop(flags) == true){
      for (final Flag flag in flags){
        flag.blogFlag();
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// JSON BLOG CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFlagsToJSON(List<Flag> flags){
    if (Lister.checkCanLoop(flags) == true){
      blog('[\n');
      for (int i = 0; i < flags.length; i++){

        final Flag _flag = flags[i];
        final bool _lastItem = i == flags.length - 1;

        String _string = '{\n'
            '"id":"${_flag.id}",\n'
            '"iso2":"${_flag.iso2}",\n'
            '"flag":"${_flag.icon}",\n'
            '"region":"${_flag.region}",\n'
            '"continent":"${_flag.continent}",\n'
            '"language":"${_flag.language}",\n'
            '"currencyID":"${_flag.currencyID}",\n'
            '"phoneCode":"${_flag.phoneCode}",\n'
            '"capital":"${_flag.capital}",\n'
            '"langCodes":"${_flag.langCodes}",\n'
            '"areaSqKm":${_flag.areaSqKm},\n'
            '"population":${_flag.population},\n'
            '"phrases":${_blogPhrasesToJSON(_flag.phrases)}\n'
            '}';

        if (_lastItem == false){
          _string = '$_string,';
        }

        blog(_string);

      }
      blog(']');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _blogPhrasesToJSON(List<Phrase> phrases){
    String _output = '{\n';

    if (Lister.checkCanLoop(phrases) == true) {

      for (int i = 0; i < phrases.length; i++) {

        final Phrase phrase = phrases[i];
        final bool _isLast = i + 1 == phrases.length;

        if (_isLast == false){
          _output = '$_output"${phrase.langCode}": "${phrase.value}",\n';
        }
        else {
          /// remove last comma
          _output = '$_output"${phrase.langCode}": "${phrase.value}"\n';
        }

      }

  }

    return '$_output}';
  }
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  static String generateDemographicsLine({
    required Flag? flag,
    required String thousand,
    required String million,
  }){

    String? counterCaliber(int? x){
      return Numeric.formatNumToCounterCaliber(
        x: x,
        thousand: thousand,
        million: million,
      );
    }

    final String? _areaNumbers = counterCaliber(flag?.areaSqKm);
    final String? _population = counterCaliber(flag?.population);
    final double? _popDensityValue = (flag?.population ?? 0) / (flag?.areaSqKm ?? 0);
    final String? _popDensity = Numeric.formatNumToSeparatedKilos(
      number: _popDensityValue,
      fractions: 0,
    );

    final String _areaLine = '🧍 $_population person / 🌉 $_areaNumbers km² = 👪 $_popDensity person/km²';
    return _areaLine;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlagsAreIdentical(Flag? flag1, Flag? flag2){
    bool _identical = false;

    if (flag1 == null && flag2 == null){
      _identical = true;
    }

    else if (flag1 != null && flag2 != null) {
      if (
      flag1.id == flag2.id &&
      flag1.iso2 == flag2.iso2 &&
      flag1.icon == flag2.icon &&
      flag1.region == flag2.region &&
      flag1.continent == flag2.continent &&
      flag1.language == flag2.language &&
      flag1.currencyID == flag2.currencyID &&
      flag1.phoneCode == flag2.phoneCode &&
      flag1.capital == flag2.capital &&
      flag1.langCodes == flag2.langCodes &&
      flag1.areaSqKm == flag2.areaSqKm &&
      flag1.population == flag2.population &&
      Phrase.checkPhrasesListsAreIdentical(phrases1: flag1.phrases, phrases2: flag2.phrases,) == true
    ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Flag){
      _areIdentical = checkFlagsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      iso2.hashCode^
      icon.hashCode^
      region.hashCode^
      continent.hashCode^
      language.hashCode^
      currencyID.hashCode^
      phoneCode.hashCode^
      capital.hashCode^
      langCodes.hashCode^
      areaSqKm.hashCode^
      population.hashCode^
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
