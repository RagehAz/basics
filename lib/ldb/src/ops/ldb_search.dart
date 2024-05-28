part of ldb;
/// => TAMAM
class LDBSearch {
  // -----------------------------------------------------------------------------

  const LDBSearch();

  // -----------------------------------------------------------------------------

  /// BY FINDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> byFinder({
    required Finder? finder,
    required String? docName,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (
        finder != null &&
        docName != null
    ) {

      _output = await _Sembast.searchMaps(
        docName: docName,
        finder: finder,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FOR MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> firstWithValue({
    required String? field,
    required dynamic value,
    required String? docName,
  }) async {
    Map<String, dynamic>? _output;

    if (
        field != null &&
        value != null &&
        docName != null
    ) {

      final Finder _finder = Finder(
        filter: Filter.equals(field, value, anyInList: false),
        // sortOrders: <SortOrder>[
        //   SortOrder(fieldToSortBy)
        // ],
      );

      _output = await _Sembast.searchFirst(
        docName: docName,
        finder: _finder,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FOR MAPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> anyWithValue({
    required String? sortByField,
    required String? field,
    required bool fieldIsList,
    required dynamic value,
    required String? docName,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (
        sortByField != null &&
        field != null &&
        value != null &&
        docName != null
    ){

      final Finder _finder = Finder(
        filter: Filter.equals(field, value, anyInList: fieldIsList),
        sortOrders: <SortOrder>[SortOrder(sortByField)],
      );

      _output = await _Sembast.searchMaps(
        docName: docName,
        finder: _finder,
      );

      // blog('fieldToSortBy : $fieldToSortBy');
      // blog('searchField : $searchField');
      // blog('searchValue : $searchValue');
      // blog('docName : $docName');
      // blog('_doc : $_doc');
      // blog('_db : $_db');
      // blog('_finder : $_finder');
      // blog('_recordSnapshots : $_recordSnapshots');

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> anyInList({
    required String? docName,
    required String? sortByField,
    required String? field,
    required List<dynamic>? list,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (
        docName != null &&
        field != null &&
        Lister.checkCanLoop(list) == true &&
        sortByField != null
    ){

      final Finder _finder = Finder(
        filter: Filter.inList(field, <Object>[...list!]),
        sortOrders: <SortOrder>[SortOrder(sortByField)],
      );

      _output = await _Sembast.searchMaps(
        docName: docName,
        finder: _finder,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PHRASES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> fromPhrases({
    required dynamic value,
    required String? docName,
    required String? langCode,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (
        langCode != null &&
        value != null &&
        docName != null
    ){

      const String _field = 'trigram';
      const String _sortBy = 'value';

      dynamic _value = value;
      if (_value is String){
        _value = TextMod.replaceAllCharacters(characterToReplace: r'\', replacement: '', input: _value.trim());
      }

      final Finder _finder = Finder(
        filter: Filter.matches(_field, _value, anyInList: true),
        sortOrders: <SortOrder>[
          SortOrder(_sortBy)
        ],
      );

      _output = await _Sembast.searchMaps(
        docName: docName,
        finder: _finder,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> fromTrigram({
    required dynamic value,
    required String? docName,
    required String? field,
    required String? primaryKey,
  }) async {

    /// NOTE : REQUIRES ( Phrase.cipherMixedLangPhrasesToMap ) cipher for 'phrases' field

    final List<Map<String, dynamic>> _result = await anyWithValue(
      sortByField: primaryKey,
      field: field,
      fieldIsList: true,
      value: value,
      docName: docName,
    );

    return _result;
  }
  // -----------------------------------------------------------------------------
}
