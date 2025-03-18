part of ldb;
/// => TAMAM
abstract class LDBMapper {
  // -----------------------------------------------------------------------------

  /// MAPS FROM SNAPSHOTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromSnapshots({
    required List<DBSnap> snaps,
  }){

    return snaps.map((RecordSnapshot<int, Map<String, dynamic>> snap) {
      return snap.value;
    }).toList();

  }
  // -----------------------------------------------------------------------------
}
