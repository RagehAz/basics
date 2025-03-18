part of ldb;
/// => TAMAM
abstract class LDBSearch {
  // -----------------------------------------------------------------------------

  /// BY FINDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> byFinder({
    required Finder finder,
    required String? docName,
  }) => SembastSearch.searchMaps(
    docName: docName,
    finder: finder,
  );
  // -----------------------------------------------------------------------------

  /// FOR MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> firstWithValue({
    required String? field,
    required dynamic value,
    required String? docName,
    required String invoker,
  }) async {
    Map<String, dynamic>? _output;

    if (
        field != null &&
        value != null &&
        docName != null
    ) {

      _output = await SembastSearch.searchFirst(
        docName: docName,
        invoker: invoker,
        finder: Finder(
          filter: Filter.equals(field, value, anyInList: false),
          // sortOrders: <SortOrder>[
          //   SortOrder(fieldToSortBy)
          // ],
        ),
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

      _output = await SembastSearch.searchMaps(
        docName: docName,
        finder: Finder(
          filter: Filter.equals(field, value, anyInList: fieldIsList),
          sortOrders: <SortOrder>[SortOrder(sortByField)],
        ),
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

      _output = await SembastSearch.searchMaps(
        docName: docName,
        finder: Finder(
          filter: Filter.inList(field, <Object>[...list!]),
          sortOrders: <SortOrder>[SortOrder(sortByField)],
        ),
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

      _output = await SembastSearch.searchMaps(
        docName: docName,
        finder: Finder(
          filter: Filter.matches(_field, _value, anyInList: true),
          sortOrders: <SortOrder>[
            SortOrder(_sortBy)
          ],
        ),
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
