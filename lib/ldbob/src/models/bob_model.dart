// ignore_for_file: avoid_redundant_argument_values
part of bob;

/// dart run build_runner build
@Entity()
class BobModel {
  // -----------------------------------------------------------------------------
  BobModel({
    required this.bobID,
    required this.id,
    required this.value,
  });
  // --------------------
  @Id()
  int bobID;
  /// To prevent duplicates it is also possible to enforce a unique value for this secondary ID.
  /// or alternatively use @Index() if its not unique
  @Unique(onConflict: ConflictStrategy.replace)
  final String id;
  /// create a database @Index for the corresponding database column.
  /// improves performance when querying for that property.
  /// @Index is currently not supported for double and lists, List<String>, List<int>, Uint8List, Int8List
  /// USE CAREFULLY : it needs more resources RAM and slows down CRUD operations a bit.
  @Index()
  final String value;
  // @Property(type: PropertyType.byte)
  // final Uint8List bytes;
  // @Transient() // Ignore this property, not stored in the database.

  /*
  // Time with nanosecond precision.
  @Property(type: PropertyType.dateNano)
  DateTime nanoDate;

  @Property(type: PropertyType.byte)
  int byte; // 1 byte

  @Property(type: PropertyType.short)
  int short; // 2 bytes

  @Property(type: PropertyType.char)
  int char; // 1 bytes

  @Property(type: PropertyType.int)
  int int32; // 4 bytes

  @Property(type: PropertyType.float)
  double float; // 4 bytes

  @Property(type: PropertyType.byteVector)
  List<int> byteList;
 */

  ///
}

class BobOps {
  // -----------------------------------------------------------------------------

  const BobOps();

  // -----------------------------------------------------------------------------

  /// CONVERTER

  // --------------------
  ///
  static BobModel? fromModel({
    required Map<String, dynamic>? model,
  }){
    BobModel? _output;

    if (model != null){

      _output = BobModel(
        bobID: model['bobID'] ?? Numeric.createRandomIndex(listLength: 5),
        value: model['value'],
        id: model['id'],
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  static Future<Box<BobModel>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<BobModel>();
  }
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  static List<BobModel> cleanNullModels(List<BobModel?>? models){
    final List<BobModel> _output = [];

    if (Lister.checkCanLoop(models) == true){

      for (final BobModel? model in models!){

        if (model != null){
          _output.add(model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BobModel?> insert({
    required BobModel? bobModel,
    required String docName,
  }) async {
    BobModel? _output;

    if (bobModel != null){

      await tryAndCatch(
        invoker: 'insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BobModel>? _box = await _getStoreBox(docName);

          final int? _newBobID = await _box?.putAsync(bobModel);

          if (_newBobID != null && _newBobID > 0){
            _output = BobModel(
              bobID: _newBobID,
              value: bobModel.value,
              id: bobModel.id,
            );
          }

        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<bool> insertMany({
    required List<BobModel> models,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(models) == true){

      await tryAndCatch(
        invoker: 'insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BobModel>? _box = await _getStoreBox(docName);

          final List<int>? _ids = await _box?.putManyAsync(
            models,
            mode: PutMode.insert,
          );

          _success = Lister.superLength(_ids) == models.length;

        },
      );



    }

    return _success;
  }
  // --------------------
  ///
  static Future<bool> insertManyTransaction({
    required List<BobModel> models,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(models) == true) {
      await tryAndCatch(
        invoker: 'insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<BobModel>? _box = store.box<BobModel>();
              final List<int>? ids = _box?.putMany(models, mode: PutMode.insert);
              return ids;
            }

            final List<int>? _ids = await _store.runInTransactionAsync<List<int>?, int>(TxMode.write, _function, 0);

            _success = _ids != null && _ids.length == models.length;
          }
        },
      );
    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<BobModel?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    BobModel? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: 'readByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BobModel>? _box = await _getStoreBox(docName);
          _output = await _box?.getAsync(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<BobModel>> readByBobIDs({
    required List<int> bobIDs,
    required String docName,
  }) async {
    List<BobModel> _output = [];

    if (Lister.checkCanLoop(bobIDs) == true){

      await tryAndCatch(
        invoker: 'readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BobModel>? _box = await _getStoreBox(docName);
          final List<BobModel?>? _models = await _box?.getManyAsync(bobIDs, growableResult: false);
          _output = cleanNullModels(_models);

        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERECT
  static Future<List<BobModel>> readAll({
    required String docName,
  }) async {
    List<BobModel>? _output = [];

    await tryAndCatch(
      invoker: 'readByBobID',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<BobModel>? _box = await _getStoreBox(docName);
        _output = await _box?.getAllAsync();
      },
    );

    return _output ?? [];
  }
  // -----------------------------------------------------------------------------

  /// FIND

  // --------------------
  ///
  static Future<BobModel?> findByModelID({
    required String? modelID,
    required String docName,
  }) async {
    BobModel? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: 'findByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<BobModel>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<BobModel> _condition = BobModel_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<BobModel> _query = (_box.query(_condition)..order(BobModel_.id)).build();
            _output = await _query.findFirstAsync();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<bool> deleteByBobID({
    required int? bobID,
    required String docName,
  }) async {
    bool? _success = false;

    if (bobID != null){
      await tryAndCatch(
        invoker: 'delete',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BobModel>? _box = await _getStoreBox(docName);
          _success = await _box?.removeAsync(bobID);
        },
      );
    }

    return _success ?? false;
  }
  // --------------------
  ///
  static Future<bool> deleteByBobIDs({
    required List<int>? bobIDs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobIDs) == true){

      await tryAndCatch(
        invoker: 'delete',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<BobModel>? _box = await _getStoreBox(docName);
          final int? _countRemoved = await _box?.removeManyAsync(bobIDs!);
          _success = bobIDs!.length == _countRemoved;
        },
      );

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// COUNT

  // --------------------
  ///
  static Future<int?> countItemsInBob({
    required String docName,
  }) async {
    final Box<BobModel>? _box = await _getStoreBox(docName);
    return _box?.count();
  }
  // -----------------------------------------------------------------------------

  ///

  // --------------------
  /*
  There is also runAsync (API reference):
  like runInTransactionAsync but does not start a transaction,
  leaving that to your callback code.
  This allows to supply a callback that is an async function.

  If it is necessary to call put many times in a row,
  take a look at putQueued: Schedules the given object to be put later on,
  by an asynchronous queue,
  returns the id immediately even though the object may not have been written yet.
  You can use Store's
  awaitQueueCompletion() or awaitQueueSubmitted() to wait for the async queue to finish.

  Copy
  for (int i = 0; i < 100; i++) {
    userBox.putQueued(User(name: 'User $i'));
  }

  // Optional: wait until submitted items are processed.
  store.awaitQueueSubmitted();
  expect(userBox.count(), equals(100));
   */
  // -----------------------------------------------------------------------------
}
