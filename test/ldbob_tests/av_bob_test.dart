import 'dart:io';

import 'package:basics/av/av.dart';
import 'package:basics/ldbob/bob.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

AvModel _buildAvModel(String id, String bobDocName) {
  return AvModel(
    id: id,
    uploadPath: 'storage/$bobDocName/$id',
    bobDocName: bobDocName,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('av_bob_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  const String docName = 'flyersMedias';

  tearDownAll(() async {
    await BobInit.closeTheStore();
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } on Exception catch (_) {}
  });

  group('AvBobOps.deleteMany (AvFoundation.deleteByModelsIDs)', () {

    test('removes only the targeted IDs, leaving untouched records in place', () async {
      final String keep = 'av_keep_${DateTime.now().microsecondsSinceEpoch}';
      final String drop1 = 'av_drop1_${DateTime.now().microsecondsSinceEpoch}';
      final String drop2 = 'av_drop2_${DateTime.now().microsecondsSinceEpoch}';

      final bool inserted = await AvBobOps.insertMany(
        models: [
          _buildAvModel(keep, docName),
          _buildAvModel(drop1, docName),
          _buildAvModel(drop2, docName),
        ],
        docName: docName,
      );
      expect(inserted, isTrue);

      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: [drop1, drop2],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<AvModel> remaining = await AvBobOps.findByModelsIDs(
        modelsIDs: [keep, drop1, drop2],
        docName: docName,
      );
      expect(remaining.length, 1);
      expect(remaining.single.id, keep);
    });

    test('IDs that do not exist are simply a no-op -- returns true, deletes nothing', () async {
      final String existing = 'av_existing_${DateTime.now().microsecondsSinceEpoch}';
      await AvBobOps.insertMany(models: [_buildAvModel(existing, docName)], docName: docName);

      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: ['av_does_not_exist_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<AvModel> stillThere = await AvBobOps.findByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere.length, 1);
    });

    test('a null modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: null,
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('an empty modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: <String>[],
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('deleting a mix of existing and non-existing IDs removes only the existing one', () async {
      final String existing = 'av_mixed_${DateTime.now().microsecondsSinceEpoch}';
      await AvBobOps.insertMany(models: [_buildAvModel(existing, docName)], docName: docName);

      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: [existing, 'av_never_existed_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<AvModel> stillThere = await AvBobOps.findByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere, isEmpty);
    });

    test('an ID that is only requested under a DIFFERENT docName is left untouched -- AvBob shares one Box across docNames, partitioned by bobDocName', () async {
      const String otherDocName = 'usersMedias';
      final String idInThisDoc = 'av_this_doc_${DateTime.now().microsecondsSinceEpoch}';
      final String idInOtherDoc = 'av_other_doc_${DateTime.now().microsecondsSinceEpoch}';

      await AvBobOps.insertMany(models: [_buildAvModel(idInThisDoc, docName)], docName: docName);
      await AvBobOps.insertMany(models: [_buildAvModel(idInOtherDoc, otherDocName)], docName: otherDocName);

      /// both IDs are passed, but scoped to `docName` -- only the record
      /// that ALSO carries bobDocName == docName should be removed, even
      /// though idInOtherDoc matches the id.oneOf(...) half of the condition.
      final bool deleted = await AvBobOps.deleteMany(
        modelsIDs: [idInThisDoc, idInOtherDoc],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<AvModel> thisDocResult = await AvBobOps.findByModelsIDs(
        modelsIDs: [idInThisDoc],
        docName: docName,
      );
      expect(thisDocResult, isEmpty);

      final List<AvModel> otherDocResult = await AvBobOps.findByModelsIDs(
        modelsIDs: [idInOtherDoc],
        docName: otherDocName,
      );
      expect(otherDocResult.length, 1);
    });

  });
}
