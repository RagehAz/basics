// ignore_for_file: avoid_redundant_argument_values, comment_references

part of bob;

@Entity()
class FishBob {
  // -----------------------------------------------------------------------------
  FishBob({
    required this.bobID,
    required this.id,
    required this.name,
    required this.bio,
    required this.contacts,
    required this.bzTypes,
    required this.bzForm,
    required this.countryID,
    required this.assets,
    required this.instagramFollowers,
    required this.managers,
    required this.lastEmailSent,
    required this.imageURL,
    required this.emailIsFailing,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String id;

  final String? name;
  final String? bio;
  final String? contacts;
  final String? bzTypes;
  final String? bzForm;
  final String? countryID;
  final String? imageURL;
  final bool emailIsFailing;
  final String? assets;
  final int? instagramFollowers;
  final String? managers;
  final int? lastEmailSent;
  // -----------------------------------------------------------------------------
}

/// Model[FishModel] - Bob[FishBob] - Foundation[FishBobFoundation] - Cipher[FishBobCipher] - Ops[FishBobOps]
abstract class FishBobFoundation {
  // --------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Box<FishBob>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<FishBob>();
  }
  // --------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FishBob> cleanNullModels(List<FishBob?>? bobs){
    final List<FishBob> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final FishBob? bob in bobs!){

        if (bob != null){
          _output.add(bob);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<int> getBobsIDs(List<FishBob?>? bobs){
    final List<int> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final FishBob? _bob in bobs!){

        if (_bob?.bobID != null && _bob!.bobID > 0){
          _output.add(_bob.bobID);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insert({
    required FishBob? bob,
    required String docName,
  }) async {
    bool _success = false;

    if (bob != null){

      await tryAndCatch(
        invoker: r'FishBobFoundation.insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FishBob>? _box = await _getStoreBox(docName);

          if (_box != null){

            final int? _newBobID = _box.put(bob);

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
  /// TESTED : WORKS PERFECT
  static Future<bool> insertMany({
    required List<FishBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true){

      await tryAndCatch(
        invoker: r'FishBobFoundation.insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FishBob>? _box = await _getStoreBox(docName);

          if (_box != null){

            final List<int>? _ids = _box.putMany(
              bobs,
              mode: PutMode.insert,
            );

            _success = Lister.superLength(_ids) == bobs.length;

          }

        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> insertManyTransaction({
    required List<FishBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true) {
      await tryAndCatch(
        invoker: r'FishBobFoundation.insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<FishBob>? _box = store.box<FishBob>();
              final List<int>? ids = _box?.putMany(bobs, mode: PutMode.insert);
              return ids;
            }

            final List<int>? _ids = await _store.runInTransactionAsync<List<int>?, int>(TxMode.write, _function, 0);

            _success = _ids != null && _ids.length == bobs.length;
          }

        },
      );
    }

    return _success;
  }
  // --------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishBob?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    FishBob? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: r'FishBobFoundationreadByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FishBob>? _box = await _getStoreBox(docName);
          _output = _box?.get(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<FishBob>> readByBobIDs({
    required List<int> bobsIDs,
    required String docName,
  }) async {
    List<FishBob> _output = [];

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'FishBobFoundation.readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FishBob>? _box = await _getStoreBox(docName);
          _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishBob>> readAll({
    required String docName,
  }) async {
    List<FishBob>? _output = [];

    await tryAndCatch(
      invoker: r'FishBobFoundation.readAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<FishBob>? _box = await _getStoreBox(docName);
        _output = cleanNullModels(_box?.getAll());
      },
    );

    return _output ?? [];
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishBob?> findBobByModelID({
    required String? modelID,
    required String docName,
  }) async {
    FishBob? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'FishBobFoundation.findBobByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FishBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FishBob> _condition = FishBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<FishBob> _query = (_box.query(_condition)..order(FishBob_.id)).build();
            _output =  _query.findUnique();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// FIND MANY

  // --------------------
  ///
  static Future<List<FishBob>> findBobsByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    List<FishBob> _output = [];

    if (Lister.checkCanLoop(modelsIDs) == true){

      await tryAndCatch(
        invoker: r'FishBobFoundation.findBobsByModelsIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FishBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FishBob> _condition = FishBob_.id.oneOf(modelsIDs!,
              /// if it's a string use a case-sensitive condition, to speed up lookups.
              caseSensitive: true,
              // alias:  , // future version thing
            );
            final Query<FishBob> _query = (_box.query(_condition)..order(FishBob_.id)).build();
            _output = _query.find();
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// DELETE SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByBobID({
    required int? bobID,
    required String docName,
  }) async {
    bool? _success = false;

    if (bobID != null){
      await tryAndCatch(
        invoker: r'FishBobFoundation.deleteByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FishBob>? _box = await _getStoreBox(docName);
          _success = _box?.remove(bobID);
        },
      );
    }

    return _success ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByModeID({
    required String? modelID,
    required String docName,
  }) async {
    bool _success = false;

    if (modelID != null) {

      final FishBob? _bob = await findBobByModelID(
        modelID: modelID,
        docName: docName,
      );

      if (_bob == null){
        _success = true;
      }
      else {
        _success = await deleteByBobID(
          bobID: _bob.bobID,
          docName: docName,
        );
      }

    }

    return _success;
  }
  // --------------------------------------------------------------------------

  /// DELETE MANY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByBobIDs({
    required List<int>? bobsIDs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'FishBobFoundation.deleteByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FishBob>? _box = await _getStoreBox(docName);
          final int? _countRemoved = _box?.removeMany(bobsIDs!);
          _success = bobsIDs!.length == _countRemoved;
        },
      );

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {

    final List<FishBob> _bobs = await findBobsByModelsIDs(
      modelsIDs: modelsIDs,
      docName: docName,
    );

    return deleteByBobIDs(
      bobsIDs: getBobsIDs(_bobs),
      docName: docName,
    );

  }
  // --------------------------------------------------------------------------

  /// DELETE ALL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> deleteAll({
    required String docName,
  }) async {
    bool _success = false;

    await tryAndCatch(
      invoker: r'FishBobFoundation.deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<FishBob>? _box = await _getStoreBox(docName);

        if (_box != null){
          final int _count = _box.removeAll();
          _success = _count >= 0;
        }

      },
    );

    return _success;
  }
  // --------------------------------------------------------------------------

  /// COUNT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int?> countItemsInBob({
    required String docName,
  }) async {
    final Box<FishBob>? _box = await _getStoreBox(docName);
    return _box?.count();
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExistsByModelID({
    required String? modelID,
    required String docName,
  }) async {
    bool _output = false;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'FishBobFoundation.checkExistsByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FishBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FishBob> _condition = FishBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<FishBob> _query = (_box.query(_condition)..order(FishBob_.id)).build();
            final int _count = _query.count();
            _output = _count > 0;
            _query.close();
          }

        },
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}

// abstract class FishBobCipher {
//   // --------------------------------------------------------------------------
//
//   /// SINGLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FishBob? toBob({
//     required FishModel? model,
//   }){
//     FishBob? _output;
//
//     if (model != null){
//
//       _output = FishBob(
//         bobID: 0,
//         id: model.id,
//         bytes: model.bytes,
//         text: model.text,
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FishModel? toModel({
//     required FishBob? bob,
//   }){
//     FishModel? _output;
//
//     if (bob != null){
//
//       _output = FishModel(
//         id: bob.id,
//         bytes: bob.bytes,
//         text: bob.text,
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// MULTIPLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<FishBob> toBobs({
//     required List<FishModel> models,
//   }){
//     final List<FishBob> _output = [];
//
//     if (Lister.checkCanLoop(models) == true){
//
//       for (final FishModel media in models){
//
//         final FishBob? _bob = toBob(model: media);
//
//         if (_bob != null){
//           _output.add(_bob);
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<FishModel> toModels({
//     required List<FishBob> bobs,
//   }){
//     final List<FishModel> _output = [];
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       for (final FishBob bob in bobs){
//
//         final FishModel? _media = toModel(bob: bob);
//
//         if (_media != null){
//           _output.add(_media);
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
// // --------------------------------------------------------------------------
// }
//
// abstract class FishBobOps {
//   // --------------------------------------------------------------------------
//
//   /// INSERT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insert({
//     required FishModel? model,
//     required String docName,
//   }) async {
//     return FishBobFoundation.insert(
//       bob: FishBobCipher.toBob(model: model),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertMany({
//     required List<FishModel> models,
//     required String docName,
//   }) async {
//     return FishBobFoundation.insertMany(
//       bobs: FishBobCipher.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertManyTransaction({
//     required List<FishModel> models,
//     required String docName,
//   }) async {
//     return FishBobFoundation.insertManyTransaction(
//       bobs: FishBobCipher.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FishModel>> readAll({
//     required String docName,
//   }) async {
//     final List<FishBob> _bobs = await FishBobFoundation.readAll(
//       docName: docName,
//     );
//     return FishBobCipher.toModels(bobs: _bobs);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND FIRST
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FishModel?> findByModelID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     final FishBob? _bob = await FishBobFoundation.findBobByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//     return FishBobCipher.toModel(bob: _bob);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND MANY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FishModel>> findByModelsIDs({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//     final List<FishBob> _bobs = await FishBobFoundation.findBobsByModelsIDs(
//       docName: docName,
//       modelsIDs: modelsIDs,
//     );
//     return FishBobCipher.toModels(bobs: _bobs);
//   }
//   // --------------------------------------------------------------------------
//
//   /// DELETE SINGLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> delete({
//     required String? modelID,
//     required String docName,
//   }) async {
//     return FishBobFoundation.deleteByModeID(
//       docName: docName,
//       modelID: modelID,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// DELETE MANY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteMany({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//     return FishBobFoundation.deleteByModelsIDs(
//       docName: docName,
//       modelsIDs: modelsIDs,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// DELETE ALL
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteAll({
//     required String docName,
//   }) async {
//     return FishBobFoundation.deleteAll(
//       docName: docName,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// COUNT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<int?> count({
//     required String docName,
//   }) async {
//     return FishBobFoundation.countItemsInBob(
//       docName: docName,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// CHECKERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> checkExists({
//     required String? modelID,
//     required String docName,
//   }) async {
//     return FishBobFoundation.checkExistsByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//   }
//   // --------------------------------------------------------------------------
// }
