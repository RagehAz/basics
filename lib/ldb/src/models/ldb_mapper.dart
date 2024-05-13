part of ldb;

class LDBMapper {
  // -----------------------------------------------------------------------------

  const LDBMapper();

  // -----------------------------------------------------------------------------

  /// MAPS FROM SNAPSHOTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromSnapshots({
    required List<RecordSnapshot<int, Map<String, dynamic>>> snapshots,
  }){

    return snapshots.map((RecordSnapshot<int, Map<String, dynamic>> snapshot) {
      return snapshot.value;
    }).toList();

  }
  // -----------------------------------------------------------------------------
}
