part of bob;

/// dart run build_runner build

// --------------------

/// MODEL
// class $Model$ {
//   // --------------------------------------------------------------------------
//   const $Model$({
//     required this.id,
//     required this.bytes,
//     required this.text,
//   });
//   // --------------------
//   final String id;
//   final Uint8List? bytes;
//   final String text;
//   // --------------------------------------------------------------------------
// }

/// BOB MODEL
// @Entity()
// class $Bob$ {
//   // --------------------------------------------------------------------------
//   $Bob$({
//     required this.bobID,
//     required this.id,
//     required this.bytes,
//     required this.text,
//   });
//   // --------------------
//   @Id()
//   int bobID;
//   // --------------------
//   @Unique(onConflict: ConflictStrategy.replace)
//   final String id;
//   // --------------------
//   @Property(type: PropertyType.byteVector)
//   final Uint8List? bytes;
//   // --------------------
//   final String text;
//   // --------------------------------------------------------------------------
// }

/// LIVE TEMPLATE : bobs :
/// Model[$Model$] - Bob[$Bob$] - Foundation[$Foundation$] - Cipher[$Cipher$] - Ops[$Ops$]
// abstract class $Foundation$ {
//   // --------------------------------------------------------------------------
//
//   /// BOX INITIALIZER
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<Box<$Bob$>?> _getStoreBox(String docName) async {
//     final Store? _store = await BobInit.getTheStore(docName);
//     return _store?.box<$Bob$>();
//   }
//   // --------------------------------------------------------------------------
//
//   /// CLEANING
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<$Bob$> cleanNullModels(List<$Bob$?>? bobs){
//     final List<$Bob$> _output = [];
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       for (final $Bob$? bob in bobs!){
//
//         if (bob != null){
//           _output.add(bob);
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// GETTERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<int> getBobsIDs(List<$Bob$?>? bobs){
//     final List<int> _output = [];
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       for (final $Bob$? _bob in bobs!){
//
//         if (_bob?.bobID != null && _bob!.bobID > 0){
//           _output.add(_bob.bobID);
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// INSERT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insert({
//     required $Bob$? bob,
//     required String docName,
//   }) async {
//     bool _success = false;
//
//     if (bob != null){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.insert',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//           if (_box != null){
//
//             final int? _newBobID = _box.put(bob);
//
//             if (_newBobID != null && _newBobID > 0){
//               _success = true;
//             }
//
//           }
//
//         },
//       );
//
//     }
//
//     return _success;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertMany({
//     required List<$Bob$> bobs,
//     required String docName,
//   }) async {
//     bool _success = false;
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.insertMany',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//           if (_box != null){
//
//             final List<int>? _ids = _box.putMany(
//               bobs,
//               mode: PutMode.insert,
//             );
//
//             _success = Lister.superLength(_ids) == bobs.length;
//
//           }
//
//         },
//       );
//
//     }
//
//     return _success;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertManyTransaction({
//     required List<$Bob$> bobs,
//     required String docName,
//   }) async {
//     bool _success = false;
//
//     if (Lister.checkCanLoop(bobs) == true) {
//       await tryAndCatch(
//         invoker: r'$Foundation$.insertManyTransaction',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Store? _store = await BobInit.getTheStore(docName);
//
//           if (_store != null) {
//
//             List<int>? _function(Store store, int objectId) {
//               final Box<$Bob$>? _box = store.box<$Bob$>();
//               final List<int>? ids = _box?.putMany(bobs, mode: PutMode.insert);
//               return ids;
//             }
//
//             final List<int>? _ids = await _store.runInTransactionAsync<List<int>?, int>(TxMode.write, _function, 0);
//
//             _success = _ids != null && _ids.length == bobs.length;
//           }
//
//         },
//       );
//     }
//
//     return _success;
//   }
//   // --------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<$Bob$?> readByBobID({
//     required int? bobID,
//     required String docName,
//   }) async {
//     $Bob$? _output;
//
//     if (bobID != null && bobID != 0){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$readByBobID',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//           _output = _box?.get(bobID);
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   ///
//   static Future<List<$Bob$>> readByBobIDs({
//     required List<int> bobsIDs,
//     required String docName,
//   }) async {
//     List<$Bob$> _output = [];
//
//     if (Lister.checkCanLoop(bobsIDs) == true){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.readByBobIDs',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//           _output = cleanNullModels(_box?.getMany(bobsIDs, growableResult: false));
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<$Bob$>> readAll({
//     required String docName,
//   }) async {
//     List<$Bob$>? _output = [];
//
//     await tryAndCatch(
//       invoker: r'$Foundation$.readAll',
//       timeout: BobInfo.theTimeOutS,
//       functions: () async {
//         final Box<$Bob$>? _box = await _getStoreBox(docName);
//         _output = cleanNullModels(_box?.getAll());
//       },
//     );
//
//     return _output ?? [];
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND FIRST
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<$Bob$?> findBobByModelID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     $Bob$? _output;
//
//     if (modelID != null){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.findBobByModelID',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//           if (_box != null){
//             final Condition<$Bob$> _condition = $Bob$_.id.equals(modelID,
//               caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
//               // alias:  , // future version thing
//             );
//             final Query<$Bob$> _query = (_box.query(_condition)..order($Bob$_.id)).build();
//             _output =  _query.findUnique();
//             _query.close();
//           }
//
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND MANY
//
//   // --------------------
//   ///
//   static Future<List<$Bob$>> findBobsByModelsIDs({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//     List<$Bob$> _output = [];
//
//     if (Lister.checkCanLoop(modelsIDs) == true){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.findBobsByModelsIDs',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//           if (_box != null){
//             final Condition<$Bob$> _condition = $Bob$_.id.oneOf(modelsIDs!,
//               /// if it's a string use a case-sensitive condition, to speed up lookups.
//               caseSensitive: true,
//               // alias:  , // future version thing
//             );
//             final Query<$Bob$> _query = (_box.query(_condition)..order($Bob$_.id)).build();
//             _output = _query.find();
//             _query.close();
//           }
//
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// DELETE SINGLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteByBobID({
//     required int? bobID,
//     required String docName,
//   }) async {
//     bool? _success = false;
//
//     if (bobID != null){
//       await tryAndCatch(
//         invoker: r'$Foundation$.deleteByBobID',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//           _success = _box?.remove(bobID);
//         },
//       );
//     }
//
//     return _success ?? false;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteByModeID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     bool _success = false;
//
//     if (modelID != null) {
//
//       final $Bob$? _bob = await findBobByModelID(
//         modelID: modelID,
//         docName: docName,
//       );
//
//       if (_bob == null){
//         _success = true;
//       }
//       else {
//         _success = await deleteByBobID(
//           bobID: _bob.bobID,
//           docName: docName,
//         );
//       }
//
//     }
//
//     return _success;
//   }
//   // --------------------------------------------------------------------------
//
//   /// DELETE MANY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteByBobIDs({
//     required List<int>? bobsIDs,
//     required String docName,
//   }) async {
//     bool _success = false;
//
//     if (Lister.checkCanLoop(bobsIDs) == true){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.deleteByBobIDs',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//           final int? _countRemoved = _box?.removeMany(bobsIDs!);
//           _success = bobsIDs!.length == _countRemoved;
//         },
//       );
//
//     }
//
//     return _success;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> deleteByModelsIDs({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//
//     final List<$Bob$> _bobs = await findBobsByModelsIDs(
//       modelsIDs: modelsIDs,
//       docName: docName,
//     );
//
//     return deleteByBobIDs(
//       bobsIDs: getBobsIDs(_bobs),
//       docName: docName,
//     );
//
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
//     bool _success = false;
//
//     await tryAndCatch(
//       invoker: r'$Foundation$.deleteAll',
//       timeout: BobInfo.theTimeOutS,
//       functions: () async {
//
//         final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//         if (_box != null){
//           final int _count = _box.removeAll();
//           _success = _count >= 0;
//         }
//
//       },
//     );
//
//     return _success;
//   }
//   // --------------------------------------------------------------------------
//
//   /// COUNT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<int?> countItemsInBob({
//     required String docName,
//   }) async {
//     final Box<$Bob$>? _box = await _getStoreBox(docName);
//     return _box?.count();
//   }
//   // --------------------------------------------------------------------------
//
//   /// CHECKERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> checkExistsByModelID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     bool _output = false;
//
//     if (modelID != null){
//
//       await tryAndCatch(
//         invoker: r'$Foundation$.checkExistsByModelID',
//         timeout: BobInfo.theTimeOutS,
//         functions: () async {
//
//           final Box<$Bob$>? _box = await _getStoreBox(docName);
//
//           if (_box != null){
//             final Condition<$Bob$> _condition = $Bob$_.id.equals(modelID,
//               caseSensitive: true, /// if it's a string use a case-sensitive condition, to speed up lookups.
//               // alias:  , // future version thing
//             );
//             final Query<$Bob$> _query = (_box.query(_condition)..order($Bob$_.id)).build();
//             final int _count = _query.count();
//             _output = _count > 0;
//             _query.close();
//           }
//
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
// }
//
// abstract class $Cipher$ {
//   // --------------------------------------------------------------------------
//
//   /// SINGLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static $Bob$? toBob({
//     required $Model$? model,
//   }){
//     $Bob$? _output;
//
//     if (model != null){
//
//       _output = $Bob$(
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
//   static $Model$? toModel({
//     required $Bob$? bob,
//   }){
//     $Model$? _output;
//
//     if (bob != null){
//
//       _output = $Model$(
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
//   static List<$Bob$> toBobs({
//     required List<$Model$> models,
//   }){
//     final List<$Bob$> _output = [];
//
//     if (Lister.checkCanLoop(models) == true){
//
//       for (final $Model$ media in models){
//
//         final $Bob$? _bob = toBob(model: media);
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
//   static List<$Model$> toModels({
//     required List<$Bob$> bobs,
//   }){
//     final List<$Model$> _output = [];
//
//     if (Lister.checkCanLoop(bobs) == true){
//
//       for (final $Bob$ bob in bobs){
//
//         final $Model$? _media = toModel(bob: bob);
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
// abstract class $Ops$ {
//   // --------------------------------------------------------------------------
//
//   /// INSERT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insert({
//     required $Model$? model,
//     required String docName,
//   }) async {
//     return $Foundation$.insert(
//       bob: $Cipher$.toBob(model: model),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertMany({
//     required List<$Model$> models,
//     required String docName,
//   }) async {
//     return $Foundation$.insertMany(
//       bobs: $Cipher$.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<bool> insertManyTransaction({
//     required List<$Model$> models,
//     required String docName,
//   }) async {
//     return $Foundation$.insertManyTransaction(
//       bobs: $Cipher$.toBobs(models: models),
//       docName: docName,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// READ
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<$Model$>> readAll({
//     required String docName,
//   }) async {
//     final List<$Bob$> _bobs = await $Foundation$.readAll(
//       docName: docName,
//     );
//     return $Cipher$.toModels(bobs: _bobs);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND FIRST
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<$Model$?> findByModelID({
//     required String? modelID,
//     required String docName,
//   }) async {
//     final $Bob$? _bob = await $Foundation$.findBobByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//     return $Cipher$.toModel(bob: _bob);
//   }
//   // --------------------------------------------------------------------------
//
//   /// FIND MANY
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<$Model$>> findByModelsIDs({
//     required List<String>? modelsIDs,
//     required String docName,
//   }) async {
//     final List<$Bob$> _bobs = await $Foundation$.findBobsByModelsIDs(
//       docName: docName,
//       modelsIDs: modelsIDs,
//     );
//     return $Cipher$.toModels(bobs: _bobs);
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
//     return $Foundation$.deleteByModeID(
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
//     return $Foundation$.deleteByModelsIDs(
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
//     return $Foundation$.deleteAll(
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
//     return $Foundation$.countItemsInBob(
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
//     return $Foundation$.checkExistsByModelID(
//       docName: docName,
//       modelID: modelID,
//     );
//   }
//   // --------------------------------------------------------------------------
// }
