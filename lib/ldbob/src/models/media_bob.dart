// ignore_for_file: avoid_redundant_argument_values
part of bob;

/// dart run build_runner build
@Entity()
class MediaBobModel {
  // -----------------------------------------------------------------------------
  MediaBobModel({
    required this.bobID,
    required this.id,
    required this.bytes,
    required this.ownersIDs,
    required this.fileMime,
    required this.uploadPath,
    required this.name,
    required this.width,
    required this.height,
    required this.sizeMB,
    required this.data,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String id;

  @Property(type: PropertyType.byteVector)
  final Uint8List? bytes;

  final List<String> ownersIDs;
  final double? width;
  final double? height;
  final String? name;
  final double? sizeMB;
  final String? fileMime;
  final String? uploadPath;
  final String? data;
  // -----------------------------------------------------------------------------

}

class MediaBobOps {
  // -----------------------------------------------------------------------------

  const MediaBobOps();

  // -----------------------------------------------------------------------------

  /// CONVERTER

  // --------------------
  ///
  static MediaBobModel? toBobModel({
    required MediaModel? media,
  }){
    MediaBobModel? _output;

    if (media != null){

      _output = MediaBobModel(
        bobID: 0,
        id: media.id,
        bytes: media.bytes,
        ownersIDs: media.meta?.ownersIDs ?? [],
        fileMime: FileMiming.getMimeByType(media.meta?.fileExt),
        uploadPath: media.getUploadPath(),
        name: media.meta?.name,
        width: media.meta?.width,
        height: media.meta?.height,
        sizeMB: media.meta?.sizeMB,
        data: jsonEncode(media.meta?.data),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<MediaBobModel> toBobModels({
    required List<MediaModel> medias,
  }){
    final List<MediaBobModel> _output = [];

    if (Lister.checkCanLoop(medias) == true){

      for (final MediaModel media in medias){

        final MediaBobModel? _bob = toBobModel(media: media);

        if (_bob != null){
          _output.add(_bob);
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static MediaModel? toMediaModel({
    required MediaBobModel? bob,
  }){
    MediaModel? _output;

    if (bob != null){

      _output = MediaModel(
        id: bob.id,
        bytes: bob.bytes,
        meta: MediaMetaModel(
          ownersIDs: bob.ownersIDs,
          fileExt: FileMiming.getTypeByMime(bob.fileMime),
          uploadPath: bob.uploadPath,
          name: bob.name,
          sizeMB: bob.sizeMB,
          width: bob.width,
          height: bob.height,
          data: MapperSS.createStringStringMap(hashMap: jsonDecode(bob.data ?? ''), stringifyNonStrings: true),
        ),
      );

    }

    return _output;
  }
  // --------------------
  ///
  static List<MediaModel> toMediaModels({
    required List<MediaBobModel> bobs,
  }){
    final List<MediaModel> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final MediaBobModel bob in bobs){

        final MediaModel? _media = toMediaModel(bob: bob);

        if (_media != null){
          _output.add(_media);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  static Future<Box<MediaBobModel>?> _getStoreBox() async {
    final Store? _store = await BobInit.getTheStore();
    return _store?.box<MediaBobModel>();
  }
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  ///
  static List<MediaBobModel> cleanNullModels(List<MediaBobModel?>? models){
    final List<MediaBobModel> _output = [];

    if (Lister.checkCanLoop(models) == true){

      for (final MediaBobModel? model in models!){

        if (model != null){
          _output.add(model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static List<int> getBobsIDs(List<MediaBobModel?>? models){
    final List<int> _output = [];

    if (Lister.checkCanLoop(models) == true){

      for (final MediaBobModel? _bob in models!){

        if (_bob?.bobID != null && _bob!.bobID > 0){
          _output.add(_bob.bobID);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<bool> insert({
    required MediaModel? media,
  }) async {
    bool _success = false;

    if (media != null){

      await tryAndCatch(
        invoker: 'insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final MediaBobModel? _bob = toBobModel(
            media: media,
          );

          if (_bob != null){

            final Box<MediaBobModel>? _box = await _getStoreBox();

            final int? _newBobID = await _box?.putAsync(_bob);

            if (_newBobID != null && _newBobID > 0){
              _success = true;
            }

          }

        },
      );

    }

    return _success;
  }
  // --------------------
  ///
  static Future<bool> insertMany({
    required List<MediaModel> models,
  }) async {
    bool _success = false;

    final List<MediaBobModel> _bobs = toBobModels(medias: models);

    if (Lister.checkCanLoop(_bobs) == true){

      await tryAndCatch(
        invoker: 'insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<MediaBobModel>? _box = await _getStoreBox();

          final List<int>? _ids = await _box?.putManyAsync(
            _bobs,
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
    required List<MediaModel> models,
  }) async {
    bool _success = false;

    final List<MediaBobModel> _bobs = toBobModels(medias: models);

    if (Lister.checkCanLoop(_bobs) == true) {
      await tryAndCatch(
        invoker: 'insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore();

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<MediaBobModel>? _box = store.box<MediaBobModel>();
              final List<int>? ids = _box?.putMany(_bobs, mode: PutMode.insert);
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
  static Future<MediaModel?> readByBobID({
    required int? bobID,
  }) async {
    MediaModel? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: 'readByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<MediaBobModel>? _box = await _getStoreBox();
          final MediaBobModel? _bob = await _box?.getAsync(bobID);
          _output = toMediaModel(bob: _bob);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<MediaModel>> readByBobIDs({
    required List<int> bobIDs,
  }) async {
    List<MediaModel> _output = [];

    if (Lister.checkCanLoop(bobIDs) == true){

      await tryAndCatch(
        invoker: 'readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<MediaBobModel>? _box = await _getStoreBox();

          final List<MediaBobModel?>? _models = await _box?.getManyAsync(bobIDs, growableResult: false);

          _output = toMediaModels(
              bobs: cleanNullModels(_models),
          );

        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<MediaModel>> readAll() async {
    List<MediaModel>? _output = [];

    await tryAndCatch(
      invoker: 'readByBobID',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<MediaBobModel>? _box = await _getStoreBox();

        final List<MediaBobModel>? _bobs = await _box?.getAllAsync();

        _output = toMediaModels(bobs: cleanNullModels(_bobs));

      },
    );

    return _output ?? [];
  }
  // -----------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  ///
  static Future<MediaModel?> findByModelID({
    required String? modelID,
  }) async {

    final MediaBobModel? _bob =  await _findBobByBobID(
      modelID: modelID,
    );

    return toMediaModel(bob: _bob);
  }
  // --------------------
  ///
  static Future<MediaBobModel?> _findBobByBobID({
    required String? modelID,
  }) async {
    MediaBobModel? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: 'findByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<MediaBobModel>? _box = await _getStoreBox();

          if (_box != null){
            final Condition<MediaBobModel> _condition = MediaBobModel_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<MediaBobModel> _query = (_box.query(_condition)..order(MediaBobModel_.id)).build();
            _output =  await _query.findFirstAsync();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FIND MANY

  // --------------------
  ///
  static Future<List<MediaBobModel>> _findBobsByIDs({
    required List<String>? ids,
  }) async {
    List<MediaBobModel> _output = [];

    if (Lister.checkCanLoop(ids) == true){

      await tryAndCatch(
        invoker: '_findBobsByIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<MediaBobModel>? _box = await _getStoreBox();

          if (_box != null){
            final Condition<MediaBobModel> _condition = MediaBobModel_.id.oneOf(ids!,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<MediaBobModel> _query = (_box.query(_condition)..order(MediaBobModel_.id)).build();
            _output = _query.find();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<MediaModel>> findByIDs({
    required List<String> ids,
  }) async {

    final List<MediaBobModel> _bobs = await _findBobsByIDs(
      ids: ids,
    );

    return toMediaModels(bobs: _bobs);
  }
  // -----------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  ///
  static Future<bool> deleteByBobID(int? bobID) async {
    bool? _success = false;

    if (bobID != null){
      await tryAndCatch(
        invoker: 'delete',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<MediaBobModel>? _box = await _getStoreBox();
          _success = await _box?.removeAsync(bobID);
        },
      );
    }

    return _success ?? false;
  }
  // --------------------
  ///
  static Future<bool> deleteByID({
    required String? id,
  }) async {
    bool _success = false;

    if (id != null) {

      final MediaBobModel? _bob = await _findBobByBobID(
        modelID: id,
      );

      _success = await deleteByBobID(_bob?.bobID);

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// DELETE MANY

  // --------------------
  ///
  static Future<bool> deleteByBobIDs({
    required List<int>? bobIDs,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobIDs) == true){

      await tryAndCatch(
        invoker: 'delete',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<MediaBobModel>? _box = await _getStoreBox();
          final int? _countRemoved = await _box?.removeManyAsync(bobIDs!);
          _success = bobIDs!.length == _countRemoved;
        },
      );

    }

    return _success;
  }
  // --------------------
  ///
  static Future<bool> deleteByIDs({
    required List<String>? ids,
  }) async {

    final List<MediaBobModel> _bobs = await _findBobsByIDs(
      ids: ids,
    );

    return deleteByBobIDs(bobIDs: getBobsIDs(_bobs));
  }
  // -----------------------------------------------------------------------------

  /// DELETE ALL

  // --------------------
  ///
  static Future<bool> deleteAll() async {
    bool _success = false;

    await tryAndCatch(
      invoker: 'deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<MediaBobModel>? _box = await _getStoreBox();

        if (_box != null){

          final int _count = await _box.removeAllAsync();

          _success = _count >= 0;

        }

      },
    );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// COUNT

  // --------------------
  ///
  static Future<int?> countItemsInBob() async {
    final Box<MediaBobModel>? _box = await _getStoreBox();
    return _box?.count();
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

   // --------------------
  static Future<bool> checkExistsByID({
    required String? id,
  }) async {
    bool _output = false;

    if (id != null){

      await tryAndCatch(
        invoker: 'findByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<MediaBobModel>? _box = await _getStoreBox();

          if (_box != null){
            final Condition<MediaBobModel> _condition = MediaBobModel_.id.equals(id,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<MediaBobModel> _query = (_box.query(_condition)..order(MediaBobModel_.id)).build();
            final int _bobID = _query.entityId;
            _output = _bobID > 0;
            _query.close();
          }

        },
      );

    }

    return _output;
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
