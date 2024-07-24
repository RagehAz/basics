import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class Phrase {
  /// --------------------------------------------------------------------------
  const Phrase({
    required this.value,
    required this.id,
    this.langCode,
    this.trigram,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final String? langCode;
  final String? value;
  final List<String>? trigram;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// AI TESTED
  Phrase copyWith({
    String? id,
    String? langCode,
    String? value,
    List<String>? trigram,
  }){
    return Phrase(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      value: value ?? this.value,
      trigram: trigram ?? this.trigram,
    );
  }
  // --------------------
  /// AI TESTED
  Phrase completeTrigram(){

    Phrase _phrase = Phrase(
      id: id,
      value: value,
      langCode: langCode,
      trigram: trigram,
    );

    if (Lister.checkCanLoop(trigram) == false){

      _phrase = _phrase.copyWith(
        trigram: Stringer.createTrigram(input: value),
      );

    }

    return _phrase;
  }
  // -----------------------------------------------------------------------------

  /// Default Map CYPHER

  // --------------------
  /// DEFAULT MAP LOOKS LIKE THIS:
  /// {
  ///   'id': id,
  ///   'langCode': langCode,
  ///   'value': value,
  ///   'trigram': trigram,
  /// }
  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toDefaultMap({
    required bool includeID,
    bool includeTrigram = false,
    bool includeLangCode = false,
    String? overrideLangCode,
  }) {

    /// START MAP
    Map<String, dynamic> _map = <String, dynamic>{
      /// 'id' : id, DO NOT put id in the single phrase map, will be used as phrases map key
      'value': value,
    };

    /// WHEN INCLUDES ID
    if (includeID == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
        overrideExisting: true,
      );

    }

    /// WHEN INCLUDING LANGUAGE CODE
    if (includeLangCode == true){

      /// ADD LANG CODE IF EXISTED
      if (langCode != null){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'langCode',
          value: overrideLangCode ?? langCode,
          overrideExisting: true,
        );
      }

    }

    /// WHEN INCLUDING TRIGRAM
    if (includeTrigram == true){

      final bool _trigramExists = Lister.checkCanLoop(trigram);

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'trigram',
        overrideExisting: true,
        value: _trigramExists ?
        trigram
            :
        Stringer.createTrigram(input: value),
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Phrase decipherPhraseDefaultMap({
    required String id,
    required Map<String, dynamic> map,
    String? langCodeOverride,
    bool includeTrigram = true,
  }) {

    final List<String> _trigram = _getTrigramIfIncluded(
      includeTrigram: includeTrigram,
      existingTrigram: Stringer.getStringsFromDynamics(map['trigram']),
      originalString: map['value'],
    );

    return Phrase(
      id: id, // ?? map['id'],
      value: map['value'],
      langCode: langCodeOverride ?? map['langCode'],
      trigram: _trigram,
    );

  }
  // -----------------------------------------------------------------------------

  /// Phids Map CYPHER

  // --------------------
  /// PHIDS MAP LOOKS LIKE THIS:
  /// {
  ///   'phid_1': value1,
  ///   'phid_2': value2,
  /// }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherPhrasesToPhidsMap(List<Phrase>? phrases){

    Map<String, dynamic>? _map;

    if (Lister.checkCanLoop(phrases) == true){
      _map = {};

      for (final Phrase phrase in phrases!){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: phrase.id,
          value: phrase.value,
          overrideExisting: true,
        );

      }

    }

    return _map;
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static List<Phrase> decipherPhrasesFromPhidsMap({
    required String langCode,
    required Map<String, dynamic>? map,
    bool includeTrigram = true,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          final List<String>? _trigram = includeTrigram == true ?
          Stringer.createTrigram(
            input: map[key],
            // removeSpaces: false,
          )
              :
          null;

          final Phrase _phrase = Phrase(
            id: key,
            value: map[key],
            langCode: langCode,
            trigram: _trigram,
          );

          _output.add(_phrase);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// Langs Map CYPHER

  // --------------------
  /// LANGS MAP LOOKS LIKE THIS:
  /// {
  ///   'langCode_1': value1,
  ///   'langCode_2': value2,
  ///   'en' : 'countryName',
  ///   'ar' : 'الاسم',
  /// }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherPhrasesToLangsMap(List<Phrase>? phrases){
    Map<String, dynamic> _output = {};

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases!){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: phrase.langCode,
          value: phrase.value,
          overrideExisting: true,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherPhrasesLangsMap({
    required Map<String, dynamic>? langsMap,
    required String? phid,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (langsMap != null){

      final List<String> _keys = langsMap.keys.toList(); // lang codes

      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          final String _value = langsMap[key];

          final Phrase _phrase = Phrase(
            id: phid,
            langCode: key,
            value: _value,
            trigram: Stringer.createTrigram(
              input: TextMod.fixCountryName(input: _value),
            ),
          );

          _output.add(_phrase);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MIXED LANGS SINGLE MAP CYPHER

  // --------------------
  /// MIXED LANGS SINGLE MAP LOOKS LIKE THIS:
  /// {
  ///  'langCode_1': {
  ///     'id': id, <----- duplicate ID
  ///     'langCode': en, <----- different lang code
  ///     'value': valueEN,
  ///     'trigram': trigramEN,
  ///  },
  ///  'langCode_2': {
  ///     'id': id, <----- duplicate ID
  ///     'langCode': en, <----- different lang code
  ///     'value': valueAR,
  ///     'trigram': trigramAR,
  ///  },
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherMixedLangPhrasesToMap({
    required List<Phrase>? phrases,
    bool includeMapID = true,
    bool includeMapLangCode = true,
    bool includeMapTrigram = true,
  }){
    Map<String, dynamic> _output = {};

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases!){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: phrase.langCode,
          value: phrase.toDefaultMap(
            includeID: includeMapID,
            includeLangCode: includeMapLangCode,
            includeTrigram: includeMapTrigram,
          ),
          overrideExisting: true,
        );

      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherMixedLangPhrasesFromMap({
    required Map<String, dynamic>? map,
  }){
    final List<Phrase> _phrases = <Phrase>[];

    if (map != null){

      final List<String> _langCodes = map.keys.toList();

      if (Lister.checkCanLoop(_langCodes) == true){

        for (final String langCode in _langCodes){

          final Map<String, dynamic> _defaultPhraseMap = map[langCode];

          _phrases.add(decipherPhraseDefaultMap(
            id: _defaultPhraseMap['id'],
            map: _defaultPhraseMap,
            // includeTrigram: true,
          ));

        }

      }

    }

    return _phrases;

  }
  // -----------------------------------------------------------------------------

  /// MIXED LANGS MAPS CYPHER

  // --------------------
  /// MIXED LANGS LOOKS LIKE THIS:
  /// {
  ///   'id': id, <----- duplicate ID
  ///   'langCode': en, <----- different lang code
  ///   'value': valueEN,
  ///   'trigram': trigramEN,
  /// }
  /// {
  ///   'id': id, <----- duplicate ID
  ///   'langCode': ar, <----- different lang code
  ///   'value': valueAR,
  ///   'trigram': trigramAR,
  /// }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherMixedLangPhrasesToMaps({
    required List<Phrase> phrases,
    bool includeTrigrams = true,
  }){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        Map<String, dynamic> _map = phrase.toDefaultMap(
          includeID: true,
          includeTrigram: includeTrigrams,
          overrideLangCode: phrase.langCode,
          includeLangCode: true,
        );

        /// used as primary key, due to duplicates in both ids and langCodes
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'primaryKey',//'id_langCode',
          value: createPhraseLDBPrimaryKey(
            phid: phrase.id,
            langCode: phrase.langCode,
          ),
          overrideExisting: true,
        );

        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createPhraseLDBPrimaryKey({
    required String? phid,
    required String? langCode,
  }){

    if (phid == null || langCode == null){
      return null;
    }
    else {
      return '${phid}_$langCode';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherMixedLangPhrasesFromMaps({
    required List<dynamic>? maps,
  }){
    final List<Phrase> _phrases = <Phrase>[];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final Phrase _phrase = decipherPhraseDefaultMap(
          id: map['id'],
          map: map,
          langCodeOverride: map['langCode'],
          // includeTrigram: true,
        );

        _phrases.add(_phrase);

      }

    }

    return _phrases;
  }
  // -----------------------------------------------------------------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT : used to upload to firebase
  static Map<String, dynamic> cipherOneLangPhrasesToMap({
    required List<Phrase> phrases,
    bool addTrigrams = false,
    bool includeLangCode = false,
    String overrideLangCode,
  }) {
    Map<String, dynamic> _phrasesMap = <String, dynamic>{};

    if (Lister.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _phrasesMap = Mapper.insertPairInMap(
          map: _phrasesMap,
          key: phrase.id,
          value: phrase.toDefaultMap(
            includeID: false,
            includeTrigram: addTrigrams,
            includeLangCode: includeLangCode,
            overrideLangCode: overrideLangCode,
          ),

        );
      }

    }

    return _phrasesMap;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  /// used to store in LDB
  static List<Map<String, dynamic>> cipherOneLangPhrasesToMapsX({
    required List<Phrase> phrases,
    bool addTrigrams = false,
    bool includeLangCode = false,
    String overrideLangCode,
  }){

    final List<Map<String, dynamic>> _maps = <Map<String,dynamic>>[];

    if (Lister.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        final Map<String, dynamic> _map = phrase.toDefaultMap(
          includeID: true,
          includeTrigram: addTrigrams,
          includeLangCode: includeLangCode,
          overrideLangCode: overrideLangCode,
        );

        _maps.add(_map);

      }

    }

    return _maps;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherOneLangPhrasesMapX({
    required Map<String, dynamic> map,
    String addLangCodeOverride,
    bool includeTrigrams = false,
  }){
    final List<Phrase> _phrases = <Phrase>[];

    final List<String> _keys = map?.keys?.toList();

    if (Lister.checkCanLoopList(_keys)){

      for (int i = 0; i<_keys.length; i++){

        final String _key = _keys[i];
        final Phrase _phrase = decipherPhraseDefaultMap(
          id: _key,
          map: map[_key],
          langCodeOverride: addLangCodeOverride,
          includeTrigram: includeTrigrams,
        );
        _phrases.add(_phrase);

      }

    }

    return _phrases;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherOneLangPhrasesMapsX({
    required List<Map<String, dynamic>> maps,
    String langCodeOverride,
    bool includeTrigrams = false,
  }){

    final List<Phrase> _phrases = <Phrase>[];

    if (Lister.checkCanLoopList(maps) == true){

      for (int i = 0; i< maps.length; i++){

        final Map<String, dynamic> _map = maps[i];

        final Phrase _phrase = decipherPhraseDefaultMap(
          id: _map['id'],
          map: _map,
          langCodeOverride: langCodeOverride,
          includeTrigram: includeTrigrams,
        );

        _phrases.add(_phrase);
      }

    }

    return _phrases;
  }
   */
  // -----------------------------------------------------------------------------

  /// STREAMING

  // --------------------
  /// DEPRECATED
  /*
  static List<Phrase> getPhrasesFromStream({
    required DocumentSnapshot<Object> doc,
    required String langCode,
  }) {

    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(
      docSnapshot: doc,
      addDocSnapshot: false,
      addDocID: false,
    );

    final List<Phrase> _models = Phrase.decipherOneLangPhrasesMap(
      map: _map,
      addLangCodeOverride: langCode,
    );

    return _models;
  }
   */
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// DEPRECATED IN FAVOR TO [getLangCodes]
  /*
  static List<String> _getLingCodesFromPhrases(List<Phrase> phrases){

    final List<String> _langCodes = <String>[];

    if (Lister.checkCanLoopList(phrases)){

      for (final Phrase phrase in phrases){
        _langCodes.add(phrase.langCode);
      }

    }

    return _langCodes;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhrasesIDs(List<Phrase>? phrases){

    List<String> _output = <String>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases!){

        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: phrase.id,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getLangCodes(List<Phrase>? phrases){
     List<String> _codes = <String>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase _phrase in phrases!){

        _codes = Stringer.addStringToListIfDoesNotContainIt(
            strings: _codes,
            stringToAdd: _phrase.langCode,
        );

      }

    }

    return _codes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhrasesValues(List<Phrase>? phrases){
     List<String> _codes = <String>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase _phrase in phrases!){

        _codes = Stringer.addStringToListIfDoesNotContainIt(
            strings: _codes,
            stringToAdd: _phrase.value,
        );

      }

    }

    return _codes;
  }
  // -----------------------------------------------------------------------------

  /// SEARCHERS

  // --------------------
  /// BY ID
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByID({
    required List<Phrase>? phrases,
    required String? phid,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true && phid != null){

      final List<Phrase> _phrases = phrases!.where((ph) => ph.id == phid).toList();

      if (Lister.checkCanLoop(_phrases) == true){
        _output.addAll(_phrases);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByIDs({
    required List<Phrase> phrases,
    required List<String> phids,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true && Lister.checkCanLoop(phids) == true){

      for (final String phid in phids){

        final List<Phrase> _phrases = searchPhrasesByID(
          phrases: phrases,
          phid: phid,
        );

        if (Lister.checkCanLoop(_phrases) == true){
          _output.addAll(_phrases);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// BY ID + LANG
  // --------------------
  /// TESTED : WORKS PERFECT
  static Phrase? searchPhraseByIDAndLangCode({
    required List<Phrase>? phrases,
    required String? phid,
    required String? langCode,
  }){
    Phrase? _phrase;

    if (Lister.checkCanLoop(phrases) == true && TextCheck.isEmpty(phid) == false){

      /// SEARCH PHRASES

      final List<Phrase> _phrasesByID = searchPhrasesByID(
        phrases: phrases,
        phid: phid,
      );

      if (langCode == null){
        _phrase = searchFirstPhraseByLang(
          phrases: _phrasesByID,
          langCode: 'en',
        );
      }
      else {
        _phrase = searchFirstPhraseByLang(
          phrases: _phrasesByID,
          langCode: langCode,
        );
      }

      // _phrase = phrases.firstWhere((ph){
      //
      //   bool _found = false;
      //
      //   if (ph.id == id){
      //     _found = true;
      //   }
      //
      //   if (searchLangCode != null){
      //
      //     if (ph.langCode == searchLangCode){
      //       _found = true;
      //     }
      //     else {
      //       _found = false;
      //     }
      //
      //   }
      //
      //
      //   return _found;
      // });

    }

    return _phrase;
  }
  // --------------------
  /// BY LANG
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByLang({
    required List<Phrase>? phrases,
    required String langCode,
  }){
    List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){
      _output = phrases!.where((phr) => phr.langCode == langCode).toList();
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Phrase? searchFirstPhraseByLang({
    required List<Phrase>? phrases,
    required String langCode,
  }){

    Phrase? _phrase;

    if (Lister.checkCanLoop(phrases) == true) {

      _phrase = phrases!.firstWhereOrNull((Phrase phrase) => phrase.langCode == langCode);

      _phrase ??= phrases.firstWhereOrNull((Phrase phrase) => phrase.langCode == 'en');

    }

    return _phrase;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesByLangs({
    required List<Phrase> phrases,
    required List<String> langCodes,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true && Lister.checkCanLoop(langCodes) == true){

      for (final Phrase phrase in phrases){

        final bool _contains = Stringer.checkStringsContainString(
          strings: langCodes,
          string: phrase.langCode,
        );

        if (_contains == true){

          _output.add(phrase);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// BY VALUE / TRIGRAM ( SEARCH )
  // --------------------
  static Phrase? searchPhraseByIdenticalValue({
    required List<Phrase> phrases,
    required String value,
  }){
    Phrase? _phrase;

    if (Lister.checkCanLoop(phrases) == true && TextCheck.isEmpty(value) == false){

      for (final Phrase phrase in phrases){

        if (phrase.value  == value){
          _phrase = phrase;
          break;
        }

      }

    }

    return _phrase;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesRegExp({
    required List<Phrase> phrases,
    required String text,
    bool lookIntoIDs = true,
    bool lookIntoValues = false,
  }){
    final List<Phrase> _result = <Phrase>[];

    if (Lister.checkCanLoop(phrases) && text.isNotEmpty){

      if (lookIntoIDs == true){

        final List<Phrase> _byID = phrases.where((ph){

          return
            TextCheck.stringContainsSubStringRegExp(
              string: ph.id,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byID);
      }

      if (lookIntoValues == true){

        final List<Phrase> _byValue = phrases.where((ph){

          return
            TextCheck.stringContainsSubStringRegExp(
              string: ph.value,
              subString: text,
            ) == true;

        }).toList();

        _result.addAll(_byValue);
      }

    }

    // blog('found those phrases');
    // Phrase.blogPhrases(_result,);

    return cleanIdenticalPhrases(_result);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> searchPhrasesTrigrams({
    required List<Phrase>? sourcePhrases,
    required String? inputText,
  }){
    final List<Phrase> _foundPhrases = <Phrase>[];

    if (Lister.checkCanLoop(sourcePhrases) == true){

      final String? _fixedString = TextMod.fixCountryName(
        input: inputText,
        addTheseChars: {
          'space'               : {'char': ' '    ,'replacement': ' '},
        },
      );

      for (final Phrase source in sourcePhrases!){

        final List<String>? _trigram = source.trigram;

        final bool _trigramContains = Stringer.checkStringsContainString(
            strings: TextMod.stringsToLowerCase(strings: _trigram),
            string: _fixedString?.toLowerCase(),
        );

        final bool _valueContaines = TextCheck.stringContainsSubString(
            string: source.value?.toLowerCase(),
            subString: _fixedString?.toLowerCase(),
        );

        if (_trigramContains || _valueContaines){
          _foundPhrases.add(source);
        }

      }

    }

    return _foundPhrases;
  }
  // -----------------------------------------------------------------------------

  /// SYMMETRY

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> symmetrizePhrase({
    required Phrase? phrase,
    required List<Phrase> allMixedPhrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (phrase != null && Lister.checkCanLoop(allMixedPhrases) == true){
      if (phrase.langCode != null){

        final String _secondLang = phrase.langCode == 'en' ? 'ar' : 'en';

        final Phrase ?_otherLangPhrase = searchPhraseByIDAndLangCode(
          phrases: allMixedPhrases,
          phid: phrase.id,
          langCode: _secondLang,
        );

        if (_otherLangPhrase != null){
          _output.addAll(<Phrase>[
            phrase,
            _otherLangPhrase,
          ]);
        }

      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> symmetrizePhrases({
    required List<Phrase> phrasesToSymmetrize,
    required List<Phrase> allMixedPhrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrasesToSymmetrize) == true){

      for (final Phrase phrase in phrasesToSymmetrize){

        final List<Phrase> _pair = symmetrizePhrase(
            phrase: phrase,
            allMixedPhrases: allMixedPhrases
        );

        if (Lister.checkCanLoop(_pair) == true){
          _output.addAll(_pair);
        }

      }

    }

    return cleanIdenticalPhrases(_output);
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesIncludeIdenticalPhrase({
    required List<Phrase>? phrases,
    required Phrase? firstPhrase,
  }){
    bool _include = false;

    if (Lister.checkCanLoop(phrases) == true && firstPhrase != null){

      for (final Phrase secondPhrase in phrases!){

        final bool _found =
                firstPhrase.id == secondPhrase.id
                &&
                firstPhrase.value  == secondPhrase.value
                &&
                firstPhrase.langCode == secondPhrase.langCode;

        if (_found == true){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
  // --------------------
  /// loops phrases for any phrase of this lang code
  static bool checkPhrasesIncludeValueForThisLanguage({
    required List<Phrase> phrases,
    required String langCode,
  }){

    bool _phraseInclude = false;

    if (Lister.checkCanLoop(phrases)){

      for (final Phrase phrase in phrases){

        if (phrase.langCode == langCode){
          if (phrase.value != null){

            _phraseInclude = true;
            break;

          }
        }

      }

    }


    return _phraseInclude;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesIncludeThisID({
    required List<Phrase> phrases,
    required String? id,
  }){
    bool _include = false;

    if (Lister.checkCanLoop(phrases) == true && TextCheck.isEmpty(id) == false){

      for (final Phrase phrase in phrases){

        if (phrase.id == id){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesIncludeThisValue({
    required List<Phrase> phrases,
    required String value,
  }){
    bool _include = false;

    if (Lister.checkCanLoop(phrases) == true && TextCheck.isEmpty(value) == false){

      for (final Phrase phrase in phrases){

        if (phrase.value == value){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> sortNamesAlphabetically(List<Phrase> phrases){

    if (Lister.checkCanLoop(phrases) == true){
      phrases.sort((Phrase a, Phrase b) => a.value?.compareTo(b.value ?? '') ?? 0);
    }

    return phrases;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> sortPhrasesByIDAndLang({
    required List<Phrase> phrases,
  }){
    List<Phrase> _output = <Phrase>[];

    final List<String> _langs = getLangCodes(phrases);

    if (Lister.checkCanLoop(_langs) == true){

      /// MAP OF {langCode : <Phrase>[]}
      for (final String _langCode in _langs){

        final List<Phrase> _langPhrases = searchPhrasesByLang(
            phrases: phrases,
            langCode: _langCode,
        );

        final List<Phrase> _sortedIDs = sortPhrasesByID(phrases: _langPhrases);

        _output = <Phrase>[..._output, ..._sortedIDs];
      }

    }

    return _output;
  }
  // -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> sortPhrasesByID({
    required List<Phrase>? phrases,
  }){

    final List<Phrase> _output = [...?phrases];

    if (Lister.checkCanLoop(_output) == true){
      _output.sort((Phrase a, Phrase b) => a.id?.compareTo(b.id ?? '') ?? 0);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> insertPhrase({
    required List<Phrase>? phrases,
    required Phrase? phrase,
    required bool overrideDuplicateID,
    String? addLanguageCode,
  }){
    final List<Phrase> _output = <Phrase>[...?phrases];

    if (phrase != null){

      final Phrase _phraseToInsert = phrase.copyWith(
        langCode: addLanguageCode ?? phrase.langCode,
      );

      final bool _idIsTaken = checkPhrasesIncludeThisID(
        phrases: _output,
        id: phrase.id,
      );

      /// PHRASES DO NOT HAVE THIS ID
      if (_idIsTaken == false){
        _output.add(_phraseToInsert);
      }

      /// PHRASE HAS THIS ID
      else {

        if (overrideDuplicateID == true){

          final int _existingPhraseIndex = _output.indexWhere((ph) => ph.id == phrase.id);
          if (_existingPhraseIndex != -1){
            _output.removeAt(_existingPhraseIndex);
            _output.insert(_existingPhraseIndex, _phraseToInsert);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> insertPhrases({
    required List<Phrase> insertIn,
    required List<Phrase> phrasesToInsert,
    required bool overrideDuplicateID,
    String? addLanguageCode,
    bool? allowDuplicateIDs,
  }){

    List<Phrase> _output = <Phrase>[];

    if (allowDuplicateIDs != null && allowDuplicateIDs == true){
      _output = _combinePhrasesListsAndAllowDuplicateIDs(
        insertIn: insertIn,
        phrasesToInsert: phrasesToInsert,
        addLanguageCodeToInsertedPhrases: addLanguageCode,
      );
    }

    else {
      _output = _combinePhrasesWithoutDuplicateIDs(
        phrasesToInsert: phrasesToInsert,
        insertIn: insertIn,
        overrideDuplicateID: overrideDuplicateID,
        addLanguageCode: addLanguageCode,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _combinePhrasesListsAndAllowDuplicateIDs({
    required List<Phrase> insertIn,
    required List<Phrase> phrasesToInsert,
    String? addLanguageCodeToInsertedPhrases,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(insertIn) == true){
      _output.addAll(insertIn);
    }

    if (Lister.checkCanLoop(phrasesToInsert) == true){

      List<Phrase> _phrasesToInsert = <Phrase>[...phrasesToInsert];

      if (TextCheck.isEmpty(addLanguageCodeToInsertedPhrases) == false){
        _phrasesToInsert = _addLangCodeToPhrases(
          phrases: phrasesToInsert,
          langCode: addLanguageCodeToInsertedPhrases!,
        );
      }

      _output.addAll(_phrasesToInsert);
    }

    // blogPhrases(_output);

    return cleanIdenticalPhrases(_output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _addLangCodeToPhrases({
    required String langCode,
    required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _phrase = Phrase(
          value: phrase.value,
          id: phrase.id,
          langCode: langCode,
          trigram: phrase.trigram,
        );

        _output.add(_phrase);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _combinePhrasesWithoutDuplicateIDs({
    required List<Phrase>? insertIn,
    required List<Phrase>? phrasesToInsert,
    required bool overrideDuplicateID,
    String? addLanguageCode,
  }){

    List<Phrase> _output = <Phrase>[...?insertIn];

    if (Lister.checkCanLoop(phrasesToInsert) == true){

      for (final Phrase phrase in phrasesToInsert!){

        _output = insertPhrase(
          phrases: _output,
          phrase: phrase,
          overrideDuplicateID: overrideDuplicateID,
          addLanguageCode: addLanguageCode,
        );

      }

    }

    // blog('_combinePhrasesWithoutDuplicateIDs : output phrases inserted are : ${_output.length} phrases ');
    // Phrase.blogPhrases(_output);

    return _output;

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> replacePhraseByLangCode({
    required List<Phrase> phrases,
    required Phrase? phrase,
  }){
   List<Phrase> _output = <Phrase>[];

   if (Lister.checkCanLoop(phrases) == true){

     _output.addAll(phrases);

     if (phrase != null){

       Map<String, dynamic> _langsMap = cipherPhrasesToLangsMap(_output);

       _langsMap = Mapper.insertPairInMap(
         map: _langsMap,
         key: phrase.langCode,
         value: phrase.value,
         overrideExisting: true,
       );

       _output = decipherPhrasesLangsMap(
           langsMap: _langsMap,
           phid: phrase.id,
       );

     }

   }

   return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> removePhraseByLangCode({
    required List<Phrase>? phrases,
    required String? langCode,
  }){
    final List<Phrase> _output = [];

    if (phrases != null && langCode != null){
      _output.addAll(phrases);

      final int _index = _output.indexWhere((ph) => ph.langCode == langCode);

      if (_index != -1){
        _output.removeAt(_index);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> cleanIdenticalPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase firstPhrase in phrases){

        final bool _contains = checkPhrasesIncludeIdenticalPhrase(
          phrases: _output,
          firstPhrase: firstPhrase,
        );

        if (_contains == false){
          _output.add(firstPhrase);
        }

      }

    }

    // blog('phrases have become this after clean up');
    //   blogPhrases(_output);

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> cleanDuplicateIDs({
    required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        final bool _contains = checkPhrasesIncludeThisID(
            phrases: _output,
            id: phrase.id
        );

        if (_contains == false){
          _output.add(phrase);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> removeTrigramsFromPhrases(List<Phrase> phrases){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _cleaned = Phrase(
          id: phrase.id,
          value: phrase.value,
          langCode: phrase.langCode,
        );

        _output.add(_cleaned);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> deletePhidFromPhrases({
    required List<Phrase>? phrases,
    required String? phid,
  }){

    List<Phrase> _output = <Phrase>[];

    if (
        Lister.checkCanLoop(phrases) == true
        &&
        TextCheck.isEmpty(phid) == false
    ){

      _output = <Phrase>[...phrases!];

      for (int i = 0; i< phrases.length; i++){

        if (phrases[i].id == phid){
          // _output.removeAt(i);
          _output.remove(phrases[i]);
          // blog('deletePhidFromPhrases : deleted : $i : id  ${phrases[i].id} : ${phrases[i].value} : lang : ${phrases[i].langCode}');
        }

      }

    }

    // blog('deletePhidFromPhrases : list had ${phrases.length} : but now has : ${_output.length} phrases');

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> onlyIncludeIDAndValue({
    required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        final Phrase _phrase = Phrase(
          id: phrase.id,
          value: phrase.value,
        );

        _output.add(_phrase);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getTrigramIfIncluded({
    required bool includeTrigram,
    required List<String> existingTrigram,
    required String originalString,
  }){
    List<String> _output = [];

    if (includeTrigram == true){

      final bool _hasExitingOne = Lister.checkCanLoop(existingTrigram);

      if (_hasExitingOne == true){
        _output = existingTrigram;
      }
      else {
        _output = Stringer.createTrigram(input: originalString);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TRIGRAMS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> addTrigramsToPhrases({
    required List<Phrase> phrases,
  }){
    final List<Phrase> _output = <Phrase>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){

        _output.add(phrase.copyWith(
          trigram: Stringer.createTrigram(input: phrase.value),
        ));

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPhrase({String invoker = ''}){
    blog('PHRASE $invoker : langCode : $langCode : id : $id : $value : trigram(${trigram?.length})');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPhrases(List<Phrase>? phrases){

    int _count = 1;

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases!){
        blog(
            '  #$_count : '
                'id : [ ${phrase.id} ] : '
                'langCode : [ ${phrase.langCode} ] : '
                'name : [ ${phrase.value} ] : '
                'trigramLength : ${phrase.trigram?.length}'
        );
        _count++;
      }

    }
    else {
      blog('phrases ARE FUCKING NULL');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> blogPhrasesListsDifferences({
    required List<Phrase> phrases1,
    required String phrases1Name,
    required List<Phrase> phrases2,
    required String phrases2Name,
    bool sortBeforeCompare = true,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(phrases1) == true && Lister.checkCanLoop(phrases2) == true){

      List<Phrase> _phrases1;
      List<Phrase> _phrases2;

      if (sortBeforeCompare == true){

        _phrases1 = Phrase.sortPhrasesByIDAndLang(phrases: phrases1);
        _phrases2 = Phrase.sortPhrasesByIDAndLang(phrases: phrases2);
      }
      else {
        _phrases1 = phrases1;
        _phrases2 = phrases2;
      }

      final List<String> _list1 = Phrase.transformPhrasesToStrings(_phrases1);
      final List<String> _list2 = Phrase.transformPhrasesToStrings(_phrases2);

      _output = Stringer.blogStringsListsDifferences(
        strings1: _list1,
        list1Name: phrases1Name,
        strings2: _list2,
        list2Name: phrases2Name,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> transformPhrasesToStrings(List<Phrase> phrases){
    final List<String> _strings = <String>[];

    if (Lister.checkCanLoop(phrases) == true){

      for (final Phrase phrase in phrases){
        final String _string = phrase.toString();
        _strings.add(_string);
      }

    }

    return _strings;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesAreIdentical({
    required Phrase? phrase1,
    required Phrase? phrase2,
  }){

    bool _areIdentical = false;

    if (phrase1 != null && phrase2 != null){

      if (phrase1.id == phrase2.id){

        if (phrase1.langCode == phrase2.langCode){

          if (phrase1.value == phrase2.value){

            if (Lister.checkListsAreIdentical(list1: phrase1.trigram, list2: phrase2.trigram)){

              _areIdentical = true;

            }

          }

        }

      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhrasesListsAreIdentical({
    required List<Phrase>? phrases1,
    required List<Phrase>? phrases2,
  }){

    bool _listsAreIdentical = false;

    if (phrases1 == null && phrases2 == null){
      _listsAreIdentical = true;
    }
    else if (phrases1 != null && phrases1.isEmpty == true && phrases2 != null && phrases2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Lister.checkCanLoop(phrases1) == true && Lister.checkCanLoop(phrases2) == true){

      if (phrases1!.length == phrases2!.length){

        // final List<String> codes = _getLingCodesFromPhrases(phrases1);

        bool _allLangCodesAreIdentical = true;

        for (int i = 0; i < phrases1.length; i++){

          final Phrase _phrase1 = phrases1[i];
          final Phrase _phrase2 = phrases2[i];

          if (Phrase.checkPhrasesAreIdentical(phrase1: _phrase1, phrase2: _phrase2) == true){
            _allLangCodesAreIdentical = true;
          }

          else {
            _allLangCodesAreIdentical = false;
            break;
          }

        }

        if (_allLangCodesAreIdentical == true){
          _listsAreIdentical = true;
        }

      }

    }

    return _listsAreIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'id: $id : langCode : $langCode : value : $value : trigram.length : ${trigram?.length}';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Phrase){
      _areIdentical = checkPhrasesAreIdentical(
        phrase1: this,
        phrase2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      value.hashCode^
      id.hashCode^
      langCode.hashCode^
      trigram.hashCode;
  // -----------------------------------------------------------------------------

  /// JSON CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> decipherCityJsonMap({
    required String cityID,
    required Map<String, dynamic>? cityJsonMap,
  }){
    final List<Phrase> _output = [];

    if (cityJsonMap != null){

      final List<String> langCodes = cityJsonMap.keys.toList();

      if (Lister.checkCanLoop(langCodes) == true){

        for (final String langCode in langCodes){

          final Map<String, dynamic> _map = cityJsonMap[langCode];

          final Phrase _phrase = Phrase(
            id: cityID,
            value: _map['value'],
            trigram: Stringer.getStringsFromDynamics(_map['trigram']),
            langCode: langCode,
          );
          _output.add(_phrase);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
