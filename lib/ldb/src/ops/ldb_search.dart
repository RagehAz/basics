part of ldb;

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
    required String? sortByField,
    required String? field,
    required dynamic value,
    required String? docName,
  }) async {
    Map<String, dynamic>? _output;

    if (
        sortByField != null &&
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

      final Finder _finder = Finder(
        filter: Filter.matches(_field, value, anyInList: true),
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

abstract class LDBFinder {
  /// Set the filter.
  set filter(Filter filter);

  /// Set the offset.
  set offset(int offset);

  /// Set the limit.
  set limit(int limit);

  /// Set the sort orders.
  set sortOrders(List<SortOrder> sortOrders);

  /// Set the sort order.
  set sortOrder(SortOrder sortOrder);

  /// Set the start boundary.
  set start(Boundary start);

  /// Set the end boundary.
  set end(Boundary end);

  /// Specify a [filter].
  ///
  /// Having a [start] and/or [end] boundary requires a sortOrders when the values
  /// are specified. start/end is done after filtering.
  ///
  /// A finder without any info does not filter anything
  Finder toFinder({
    Filter? filter,
    List<SortOrder>? sortOrders,
    int? limit,
    int? offset,
    Boundary? start,
    Boundary? end,
  }) {
    return Finder(
        filter: filter,
        sortOrders: sortOrders,
        limit: limit,
        offset: offset,
        start: start,
        end: end,
    );
  }

}
