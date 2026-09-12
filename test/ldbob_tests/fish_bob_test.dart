import 'dart:io';

import 'package:basics/ldbob/bob.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../_fake_path_provider.dart';

FishBob _buildFishBob(String id) {
  return FishBob(
    bobID: 0,
    id: id,
    name: 'name-$id',
    bio: null,
    contacts: null,
    bzTypes: null,
    bzForm: null,
    countryID: null,
    assets: null,
    instagramFollowers: null,
    managers: null,
    lastEmailSent: null,
    imageURL: null,
    emailIsFailing: false,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Directory tempDir = Directory.systemTemp.createTempSync('fish_bob_test_');
  PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);

  const String docName = 'fishMedias';

  tearDownAll(() async {
    await BobInit.closeTheStore();
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } on Exception catch (_) {}
  });

  group('FishBobFoundation.deleteByModelsIDs', () {

    test('removes only the targeted IDs, leaving untouched records in place', () async {
      final String keep = 'fish_keep_${DateTime.now().microsecondsSinceEpoch}';
      final String drop1 = 'fish_drop1_${DateTime.now().microsecondsSinceEpoch}';
      final String drop2 = 'fish_drop2_${DateTime.now().microsecondsSinceEpoch}';

      final bool inserted = await FishBobFoundation.insertMany(
        bobs: [_buildFishBob(keep), _buildFishBob(drop1), _buildFishBob(drop2)],
        docName: docName,
      );
      expect(inserted, isTrue);

      final bool deleted = await FishBobFoundation.deleteByModelsIDs(
        modelsIDs: [drop1, drop2],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FishBob> remaining = await FishBobFoundation.findBobsByModelsIDs(
        modelsIDs: [keep, drop1, drop2],
        docName: docName,
      );
      expect(remaining.length, 1);
      expect(remaining.single.id, keep);
    });

    test('IDs that do not exist are simply a no-op -- returns true, deletes nothing', () async {
      final String existing = 'fish_existing_${DateTime.now().microsecondsSinceEpoch}';
      await FishBobFoundation.insertMany(bobs: [_buildFishBob(existing)], docName: docName);

      final bool deleted = await FishBobFoundation.deleteByModelsIDs(
        modelsIDs: ['fish_does_not_exist_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FishBob> stillThere = await FishBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere.length, 1);
    });

    test('a null modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await FishBobFoundation.deleteByModelsIDs(
        modelsIDs: null,
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('an empty modelsIDs list returns false and touches nothing', () async {
      final bool deleted = await FishBobFoundation.deleteByModelsIDs(
        modelsIDs: <String>[],
        docName: docName,
      );
      expect(deleted, isFalse);
    });

    test('deleting a mix of existing and non-existing IDs removes only the existing one', () async {
      final String existing = 'fish_mixed_${DateTime.now().microsecondsSinceEpoch}';
      await FishBobFoundation.insertMany(bobs: [_buildFishBob(existing)], docName: docName);

      final bool deleted = await FishBobFoundation.deleteByModelsIDs(
        modelsIDs: [existing, 'fish_never_existed_${DateTime.now().microsecondsSinceEpoch}'],
        docName: docName,
      );
      expect(deleted, isTrue);

      final List<FishBob> stillThere = await FishBobFoundation.findBobsByModelsIDs(
        modelsIDs: [existing],
        docName: docName,
      );
      expect(stillThere, isEmpty);
    });

  });
}
