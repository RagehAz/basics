part of ldb;

enum LDBComparison {
  ///
  greaterThan,
  ///
  greaterOrEqualThan,
  ///
  lessThan,
  ///
  lessOrEqualThan,
  /// WHEN : dynamic x on db == (x);
  equalTo,
  ///
  notEqualTo,
  /// WHEN : dynamic x on db is null == (true)
  nullValue,
  ///
  whereIn,
  ///
  whereNotIn,
  /// WHEN : List<dynamic>['a', 'b', 'c'] on db contains ('b') or not.
  arrayContains,
  ///
  arrayContainsAny,
}
class LDBFinder {
  // -----------------------------------------------------------------------------
  const LDBFinder({
    required this.field,
    required this.comparison,
    required this.value,
  });
  // -----------------------------------------------------------------------------
  final String field; /// fire field name
  final LDBComparison comparison; /// fire equality comparison type
  final dynamic value; /// search value
  // -----------------------------------------------------------------------------

  ///

  // --------------------

  // -----------------------------------------------------------------------------
  void x(){}
}
