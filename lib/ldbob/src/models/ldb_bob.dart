// ignore_for_file: avoid_redundant_argument_values
part of bob;

/// Generic ObjectBox-backed replacement for what used to be a
/// sembast-per-docName store. Every `LDBOps` call
/// (`basics/lib/ldb/src/ops/ldb_ops.dart` -- insertMap/readMap/deleteMap/
/// etc) is scoped to a `docName` + `primaryKey` pair; this one box holds
/// every one of those docs' records, distinguished by (docName, recordID).
/// `LDBOps`'s public signature is unchanged, so none of its 30+ callers
/// across the app needed to change.
@Entity()
class LdbBob {
  // --------------------------------------------------------------------------
  LdbBob({
    required this.bobID,
    required this.docName,
    required this.recordID,
    required this.jsonValue,
  });
  // --------------------
  @Id()
  int bobID;

  @Index()
  final String docName;

  /// The record's own primary-key VALUE within its docName (e.g. a
  /// flyerID, countryID, or the docName itself for true singleton docs).
  /// Deliberately NOT enforced unique at the schema level -- sembast's
  /// `LDBOps` always allowed multiple records sharing the same id when
  /// `allowDuplicateIDs: true` was passed (see `countriesPhrases`, which
  /// relies on this to store one record per language for the same country
  /// id) -- so uniqueness is handled in Dart in `LdbBobOps.insert`, not by
  /// the database schema.
  @Index()
  final String recordID;

  /// JSON-encoded `Map<String, dynamic>` -- the actual document content.
  final String jsonValue;
  // -----------------------------------------------------------------------------
}

abstract class LdbBobOps {
  // --------------------------------------------------------------------------

  /// BOX

  // --------------------
  static Future<Box<LdbBob>?> _getBox() async {
    final Store? _store = await BobInit.getTheStore('ldb');
    return _store?.box<LdbBob>();
  }
  // -----------------------------------------------------------------------------

  /// ENCODE / DECODE

  // --------------------
  static String _encode(Map<String, dynamic> map) => jsonEncode(map);
  // --------------------
  static Map<String, dynamic> _decode(String jsonValue) {
    return Map<String, dynamic>.from(jsonDecode(jsonValue) as Map);
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  /// mirrors sembast's semantics: insert-or-replace-by-(docName,recordID)
  /// when [allowDuplicateIDs] is false, always-append (no existence check
  /// at all) when true.
  static Future<bool> insert({
    required Map<String, dynamic>? map,
    required String? docName,
    required String? primaryKey,
    required bool allowDuplicateIDs,
  }) async {
    bool _success = false;

    if (map != null && docName != null && primaryKey != null){

      final dynamic _idValue = map[primaryKey];

      if (_idValue != null){

        final String _recordID = _idValue.toString();

        await tryAndCatch(
          invoker: 'LdbBobOps.insert',
          timeout: BobInfo.theTimeOutS,
          functions: () async {

            final Box<LdbBob>? _box = await _getBox();

            if (_box != null){

              int _bobID = 0;

              if (allowDuplicateIDs == false){

                final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                    & LdbBob_.recordID.equals(_recordID);
                final Query<LdbBob> _query = _box.query(_condition).build();
                final LdbBob? _existing = _query.findFirst();
                _query.close();

                if (_existing != null){
                  _bobID = _existing.bobID;
                }

              }

              _box.put(LdbBob(
                bobID: _bobID,
                docName: docName,
                recordID: _recordID,
                jsonValue: _encode(map),
              ));

              _success = true;

            }

          },
        );

      }

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMany({
    required List<Map<String, dynamic>>? maps,
    required String? docName,
    required String? primaryKey,
    required bool allowDuplicateIDs,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(maps) == true && docName != null && primaryKey != null){

      /// ALWAYS-APPEND : one bulk write, no per-item existence check needed
      if (allowDuplicateIDs == true){

        await tryAndCatch(
          invoker: 'LdbBobOps.insertMany.allowDuplicates',
          timeout: BobInfo.theTimeOutS,
          functions: () async {

            final Box<LdbBob>? _box = await _getBox();

            if (_box != null){

              final List<LdbBob> _bobs = maps!.where((Map<String, dynamic> map) => map[primaryKey] != null).map((Map<String, dynamic> map) {
                return LdbBob(
                  bobID: 0,
                  docName: docName,
                  recordID: map[primaryKey].toString(),
                  jsonValue: _encode(map),
                );
              }).toList();

              _box.putMany(_bobs);

              _success = true;

            }

          },
        );

      }

      /// INSERT-OR-REPLACE PER ITEM : each item may or may not already exist
      else {

        _success = true;

        for (final Map<String, dynamic> map in maps!){

          final bool _thisSuccess = await insert(
            map: map,
            docName: docName,
            primaryKey: primaryKey,
            allowDuplicateIDs: false,
          );

          _success = _success && _thisSuccess;

        }

      }

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    Map<String, dynamic>? _output;

    if (docName != null && id != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.readMap',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                & LdbBob_.recordID.equals(id);
            final Query<LdbBob> _query = _box.query(_condition).build();
            final LdbBob? _found = _query.findFirst();
            _query.close();

            if (_found != null){
              _output = _decode(_found.jsonValue);
            }
          }

        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readField({
    required String? docName,
    required String? id,
    required String? fieldName,
    required String? primaryKey,
  }) async {
    dynamic _output;

    if (fieldName != null){
      final Map<String, dynamic>? _map = await readMap(
        docName: docName,
        id: id,
        primaryKey: primaryKey,
      );
      _output = _map?[fieldName];
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readMaps({
    required String? docName,
    required List<String>? ids,
    required String? primaryKey,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (docName != null && Lister.checkCanLoop(ids) == true){

      await tryAndCatch(
        invoker: 'LdbBobOps.readMaps',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                & LdbBob_.recordID.oneOf(ids!);
            final Query<LdbBob> _query = _box.query(_condition).build();
            final List<LdbBob> _found = _query.find();
            _query.close();

            _output = _found.map((LdbBob bob) => _decode(bob.jsonValue)).toList();
          }

        },
      );

    }

    return _output;
  }
  // --------------------
  /// Decodes this docName's records one at a time and returns the first one
  /// for which [test] returns true, stopping immediately instead of
  /// JSON-decoding every remaining record (unlike [readAll] + a Dart-side
  /// filter, which always decodes the whole docName first). Same result as
  /// that pattern, just without the wasted work once a match is found.
  static Future<Map<String, dynamic>?> readFirstMatching({
    required String? docName,
    required bool Function(Map<String, dynamic> map) test,
  }) async {
    Map<String, dynamic>? _output;

    if (docName != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.readFirstMatching',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName);
            final Query<LdbBob> _query = _box.query(_condition).build();
            final List<LdbBob> _found = _query.find();
            _query.close();

            for (final LdbBob bob in _found){
              final Map<String, dynamic> _map = _decode(bob.jsonValue);
              if (test(_map)){
                _output = _map;
                break;
              }
            }
          }

        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAll({
    required String? docName,
  }) async {
    List<Map<String, dynamic>> _output = [];

    if (docName != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.readAll',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName);
            final Query<LdbBob> _query = _box.query(_condition).build();
            final List<LdbBob> _found = _query.find();
            _query.close();

            _output = _found.map((LdbBob bob) => _decode(bob.jsonValue)).toList();
          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  /// NOTE : deletes ALL records with the given (docName, id) -- LDB allows
  /// duplicate records of the same id (see insert's allowDuplicateIDs).
  static Future<bool> deleteMap({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (docName != null && id != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.deleteMap',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                & LdbBob_.recordID.equals(id);
            final Query<LdbBob> _query = _box.query(_condition).build();
            _query.remove();
            _query.close();
            _success = true;
          }

        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteMaps({
    required String? docName,
    required List<String>? ids,
    required String? primaryKey,
  }) async {
    bool _success = false;

    if (docName != null && Lister.checkCanLoop(ids) == true){

      await tryAndCatch(
        invoker: 'LdbBobOps.deleteMaps',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                & LdbBob_.recordID.oneOf(ids!);
            final Query<LdbBob> _query = _box.query(_condition).build();
            _query.remove();
            _query.close();
            _success = true;
          }

        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAllAtOnce({
    required String? docName,
  }) async {
    bool _success = false;

    if (docName != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.deleteAllAtOnce',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName);
            final Query<LdbBob> _query = _box.query(_condition).build();
            _query.remove();
            _query.close();
            _success = true;
          }

        },
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// CHECK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    required String? docName,
    required String? id,
    required String? primaryKey,
  }) async {
    bool _output = false;

    if (docName != null && id != null){

      await tryAndCatch(
        invoker: 'LdbBobOps.checkMapExists',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<LdbBob>? _box = await _getBox();

          if (_box != null){
            final Condition<LdbBob> _condition = LdbBob_.docName.equals(docName)
                & LdbBob_.recordID.equals(id);
            final Query<LdbBob> _query = _box.query(_condition).build();
            final int _count = _query.count();
            _query.close();
            _output = _count > 0;
          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
