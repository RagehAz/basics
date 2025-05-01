// ignore_for_file: avoid_redundant_argument_values, comment_references

part of bob;

@Entity()
class FlyerBob {
  // -----------------------------------------------------------------------------
  FlyerBob({
    required this.bobID,
    required this.id,
    required this.headline,
    required this.trigram,
    required this.description,
    required this.flyerType,
    required this.publishState,
    required this.phids,
    required this.zone,
    required this.authorID,
    required this.bzID,
    required this.position,
    required this.slides,
    required this.times,
    required this.hasPriceTag,
    required this.isAmazonFlyer,
    required this.hasPDF,
    required this.showsAuthor,
    required this.score,
    required this.pdfPath,
    required this.shareLink,
    required this.price,
    required this.bzIsActive,
    required this.affiliateLink,
    required this.gtaLink,
    required this.bzModel,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace)
  final String id;

  final String? headline;
  final List<String>? trigram;
  final String? description;
  final String? flyerType;
  final String? publishState;
  final List<String>? phids;
  final bool? showsAuthor;
  final String? zone;
  final String? authorID;
  final String? bzID;
  final String? position;
  final String? slides;
  final String? times;
  final bool? hasPriceTag;
  final bool? isAmazonFlyer;
  final bool? hasPDF;
  final int? score;
  final String? pdfPath;
  final String? shareLink;
  final String? price;
  final bool? bzIsActive;
  final String? affiliateLink;
  final String? gtaLink;
  final String? bzModel;
  // -----------------------------------------------------------------------------
}

/// Model[FlyerModel] - Bob[FlyerBob] - Foundation[FlyerBobFoundation] - Cipher[FlyerBobCipher] - Ops[FlyerBobOps]
abstract class FlyerBobFoundation {
  // --------------------------------------------------------------------------

  /// BOX INITIALIZER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Box<FlyerBob>?> _getStoreBox(String docName) async {
    final Store? _store = await BobInit.getTheStore(docName);
    return _store?.box<FlyerBob>();
  }
  // --------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerBob> cleanNullModels(List<FlyerBob?>? bobs){
    final List<FlyerBob> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final FlyerBob? bob in bobs!){

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
  static List<int> getBobsIDs(List<FlyerBob?>? bobs){
    final List<int> _output = [];

    if (Lister.checkCanLoop(bobs) == true){

      for (final FlyerBob? _bob in bobs!){

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
    required FlyerBob? bob,
    required String docName,
  }) async {
    bool _success = false;

    if (bob != null){

      await tryAndCatch(
        invoker: r'FlyerBobFoundation.insert',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FlyerBob>? _box = await _getStoreBox(docName);

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
    required List<FlyerBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true){

      await tryAndCatch(
        invoker: r'FlyerBobFoundation.insertMany',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FlyerBob>? _box = await _getStoreBox(docName);

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
    required List<FlyerBob> bobs,
    required String docName,
  }) async {
    bool _success = false;

    if (Lister.checkCanLoop(bobs) == true) {
      await tryAndCatch(
        invoker: r'FlyerBobFoundation.insertManyTransaction',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Store? _store = await BobInit.getTheStore(docName);

          if (_store != null) {

            List<int>? _function(Store store, int objectId) {
              final Box<FlyerBob>? _box = store.box<FlyerBob>();
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
  static Future<FlyerBob?> readByBobID({
    required int? bobID,
    required String docName,
  }) async {
    FlyerBob? _output;

    if (bobID != null && bobID != 0){

      await tryAndCatch(
        invoker: r'FlyerBobFoundationreadByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FlyerBob>? _box = await _getStoreBox(docName);
          _output = _box?.get(bobID);
        },
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<FlyerBob>> readByBobIDs({
    required List<int> bobsIDs,
    required String docName,
  }) async {
    List<FlyerBob> _output = [];

    if (Lister.checkCanLoop(bobsIDs) == true){

      await tryAndCatch(
        invoker: r'FlyerBobFoundation.readByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FlyerBob>? _box = await _getStoreBox(docName);
          _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerBob>> readAll({
    required String docName,
  }) async {
    List<FlyerBob>? _output = [];

    await tryAndCatch(
      invoker: r'FlyerBobFoundation.readAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {
        final Box<FlyerBob>? _box = await _getStoreBox(docName);
        _output = cleanNullModels(_box?.getAll());
      },
    );

    return _output ?? [];
  }
  // --------------------------------------------------------------------------

  /// FIND FIRST

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerBob?> findBobByModelID({
    required String? modelID,
    required String docName,
  }) async {
    FlyerBob? _output;

    if (modelID != null){

      await tryAndCatch(
        invoker: r'FlyerBobFoundation.findBobByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FlyerBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FlyerBob> _condition = FlyerBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<FlyerBob> _query = (_box.query(_condition)..order(FlyerBob_.id)).build();
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
  static Future<List<FlyerBob>> findBobsByModelsIDs({
    required List<String>? modelsIDs,
    required String docName,
  }) async {
    List<FlyerBob> _output = [];

    if (Lister.checkCanLoop(modelsIDs) == true){

      await tryAndCatch(
        invoker: r'FlyerBobFoundation.findBobsByModelsIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FlyerBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FlyerBob> _condition = FlyerBob_.id.oneOf(modelsIDs!,
              /// if it's a string use a case-sensitive condition, to speed up lookups.
              caseSensitive: true,
              // alias:  , // future version thing
            );
            final Query<FlyerBob> _query = (_box.query(_condition)..order(FlyerBob_.id)).build();
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
        invoker: r'FlyerBobFoundation.deleteByBobID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FlyerBob>? _box = await _getStoreBox(docName);
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

      final FlyerBob? _bob = await findBobByModelID(
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
        invoker: r'FlyerBobFoundation.deleteByBobIDs',
        timeout: BobInfo.theTimeOutS,
        functions: () async {
          final Box<FlyerBob>? _box = await _getStoreBox(docName);
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

    final List<FlyerBob> _bobs = await findBobsByModelsIDs(
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
      invoker: r'FlyerBobFoundation.deleteAll',
      timeout: BobInfo.theTimeOutS,
      functions: () async {

        final Box<FlyerBob>? _box = await _getStoreBox(docName);

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
    final Box<FlyerBob>? _box = await _getStoreBox(docName);
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
        invoker: r'FlyerBobFoundation.checkExistsByModelID',
        timeout: BobInfo.theTimeOutS,
        functions: () async {

          final Box<FlyerBob>? _box = await _getStoreBox(docName);

          if (_box != null){
            final Condition<FlyerBob> _condition = FlyerBob_.id.equals(modelID,
              caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
              // alias:  , // future version thing
            );
            final Query<FlyerBob> _query = (_box.query(_condition)..order(FlyerBob_.id)).build();
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

// abstract class FlyerBobCipher {
//   // --------------------------------------------------------------------------
//
//   /// SINGLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FlyerBob? toBob({
//     required FlyerModel? model,
//   }){
//     FlyerBob? _output;
//
//     if (model != null){
//
//       _output = FlyerBob(
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
//   static FlyerModel? toModel({
//     required FlyerBob? bob,
//   }){
//     FlyerModel? _output;
//
//     if (bob != null){
//
//       _output = FlyerModel(
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
//   static List<FlyerBob> toBobs({
//     required List<FlyerModel> models,
//   }){
//     final List<FlyerBob> _output = [];
//
//     if (Lister.checkCanLoop(models) == true){
//
//       for (final FlyerModel media in models){
//
//         final FlyerBob? _bob = toBob(model: media);
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
//   static List<FlyerModel> toModels({
//     required List<FlyerBob> bobs,
//   }){
//     final List<FlyerModel> _output = [];
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       for (final FlyerBob bob in bobs){
//
//         final FlyerModel? _media = toModel(bob: bob);
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
// abstract class FlyerBobOps {
//   // --------------------------------------------------------------------------
//
//   /// INSERT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insert({
//     required FlyerModel? model,
//     required String docName,
//   }) async {
//     return FlyerBobFoundation.insert(
//       bob: FlyerBobCipher.toBob(model: model),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertMany({
//     required List<FlyerModel> models,
//     required String docName,
//   }) async {
//     return FlyerBobFoundation.insertMany(
//       bobs: FlyerBobCipher.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertManyTransaction({
//     required List<FlyerModel> models,
//     required String docName,
//   }) async {
//     return FlyerBobFoundation.insertManyTransaction(
//       bobs: FlyerBobCipher.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FlyerModel>> readAll({
//     required String docName,
//   }) async {
//     final List<FlyerBob> _bobs = await FlyerBobFoundation.readAll(
//       docName: docName,
//     );
//     return FlyerBobCipher.toModels(bobs: _bobs);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND FIRST
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FlyerModel?> findByModelID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     final FlyerBob? _bob = await FlyerBobFoundation.findBobByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//     return FlyerBobCipher.toModel(bob: _bob);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND MANY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FlyerModel>> findByModelsIDs({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//     final List<FlyerBob> _bobs = await FlyerBobFoundation.findBobsByModelsIDs(
//       docName: docName,
//       modelsIDs: modelsIDs,
//     );
//     return FlyerBobCipher.toModels(bobs: _bobs);
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
//     return FlyerBobFoundation.deleteByModeID(
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
//     return FlyerBobFoundation.deleteByModelsIDs(
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
//     return FlyerBobFoundation.deleteAll(
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
//     return FlyerBobFoundation.countItemsInBob(
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
//     return FlyerBobFoundation.checkExistsByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//   }
//   // --------------------------------------------------------------------------
// }
