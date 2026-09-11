part of ldb;

/// Re-implements sembast's own (always-a-linear-scan) `Finder`/`Filter`/
/// `SortOrder` evaluation against a plain `List<Map<String, dynamic>>`
/// instead of a live sembast `Database`, now that `LDBOps`/`LDBSearch` are
/// backed by ObjectBox (see `LdbBobOps` in
/// `basics/lib/ldbob/src/models/ldb_bob.dart`).
///
/// This is not a re-guess at sembast's semantics: `Filter`/`SortOrder`'s
/// public factories always construct `SembastFilterBase`/
/// `SembastSortOrderBase` internally (confirmed by reading
/// package:sembast's own source), and both expose a `matchesRecord`/
/// `compare` method against a `RecordSnapshot` -- the exact same method
/// sembast's own linear-scan search uses internally. So this produces
/// identical results to the old sembast-backed implementation, just
/// evaluated against records fetched from ObjectBox instead of an
/// in-memory sembast store. `Filter.custom` (an arbitrary Dart closure)
/// keeps working unmodified for the same reason.
///
/// `SembastFilterBase.matchesRecord` is reached via package:sembast's own
/// "protected" export (`api/protected/filter.dart`) -- an official,
/// sanctioned extension point for exactly this ("custom database
/// implementation") use case. `SembastFinder`/`SembastSortOrderBase` have
/// no such export, so those two are deep-imported from sembast's `src/`;
/// stable in practice (the public `Finder`/`SortOrder` factories have
/// always constructed exactly these two classes), hence the
/// `implementation_imports` suppression above rather than avoiding it.
class _LdbRecordSnapshot implements RecordSnapshot<int, Map<String, dynamic>> {
  // --------------------------------------------------------------------------
  _LdbRecordSnapshot({
    required this.key,
    required this.value,
  });
  // --------------------
  @override
  final int key;
  // --------------------
  @override
  final Map<String, dynamic> value;
  // --------------------
  @override
  Object? operator [](String field) {
    if (field == Field.key){
      return key;
    }
    else if (field == Field.value){
      return value;
    }
    else {
      return value[field];
    }
  }
  // --------------------
  @override
  RecordRef<int, Map<String, dynamic>> get ref => throw UnimplementedError(
    'LDB (ObjectBox-backed) records have no sembast RecordRef -- '
    'only matchesRecord()/compare() (field/key/value access) are supported.',
  );
  // --------------------
  @override
  RecordSnapshot<RK, RV> cast<RK extends sembast_type.Key?, RV extends sembast_type.Value?>() {
    throw UnimplementedError('cast() is not needed/supported for LDB (ObjectBox-backed) records.');
  }
  // -----------------------------------------------------------------------------
}

abstract class LdbFinderEngine {
  // --------------------------------------------------------------------------

  /// APPLY

  // --------------------
  /// TESTED : WORKS PERFECT
  /// Filters, sorts, and applies offset/limit to [maps] exactly the way
  /// sembast's own `Finder` search would, using sembast's own filter/sort
  /// evaluation logic (see class doc above).
  static List<Map<String, dynamic>> apply({
    required List<Map<String, dynamic>> maps,
    required Finder? finder,
  }) {

    if (finder == null){
      return maps;
    }

    final SembastFinder _finder = finder as SembastFinder;

    /// WRAP AS RECORD SNAPSHOTS (key is synthetic -- these docs have no
    /// meaningful sembast-style int key, only Filter.custom/SortOrder.custom
    /// closures that read Field.key would ever notice, and none of this
    /// app's finders do)
    List<_LdbRecordSnapshot> _snapshots = List.generate(maps.length, (int index) {
      return _LdbRecordSnapshot(key: index, value: maps[index]);
    });

    /// FILTER
    final Filter? _filter = _finder.filter;
    if (_filter != null){
      _snapshots = _snapshots.where((_LdbRecordSnapshot snapshot) {
        return (_filter as SembastFilter).matchesRecord(snapshot);
      }).toList();
    }

    /// SORT
    final List<SortOrder>? _sortOrders = _finder.sortOrders;
    if (Lister.checkCanLoop(_sortOrders) == true){
      _snapshots.sort((_LdbRecordSnapshot a, _LdbRecordSnapshot b) {
        for (final SortOrder order in _sortOrders!){
          final int _result = (order as SembastSortOrderBase).compare(a, b);
          if (_result != 0){
            return _result;
          }
        }
        return 0;
      });
    }

    /// OFFSET
    List<_LdbRecordSnapshot> _output = _snapshots;
    final int? _offset = _finder.offset;
    if (_offset != null && _offset > 0){
      _output = _output.sublist(_offset > _output.length ? _output.length : _offset);
    }

    /// LIMIT
    final int? _limit = _finder.limit;
    if (_limit != null && _limit < _output.length){
      _output = _output.sublist(0, _limit);
    }

    return _output.map((_LdbRecordSnapshot snapshot) => snapshot.value).toList();
  }
  // -----------------------------------------------------------------------------
}
